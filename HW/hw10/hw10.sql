CREATE TABLE parents AS
  SELECT 'ace' AS parent, 'bella' AS child UNION
  SELECT 'ace'          , 'charlie'        UNION
  SELECT 'daisy'        , 'hank'           UNION
  SELECT 'finn'         , 'ace'            UNION
  SELECT 'finn'         , 'daisy'          UNION
  SELECT 'finn'         , 'ginger'         UNION
  SELECT 'ellie'        , 'finn';

CREATE TABLE dogs AS
  SELECT 'ace' AS name, 'long' AS fur, 26 AS height UNION
  SELECT 'bella'      , 'short'      , 52           UNION
  SELECT 'charlie'    , 'long'       , 47           UNION
  SELECT 'daisy'      , 'long'       , 46           UNION
  SELECT 'ellie'      , 'short'      , 35           UNION
  SELECT 'finn'       , 'curly'      , 32           UNION
  SELECT 'ginger'     , 'short'      , 28           UNION
  SELECT 'hank'       , 'curly'      , 31;

CREATE TABLE sizes AS
  SELECT 'toy' AS size, 24 AS min, 28 AS max UNION
  SELECT 'mini'       , 28       , 35        UNION
  SELECT 'medium'     , 35       , 45        UNION
  SELECT 'standard'   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT ch_dog.name
  FROM parents, dogs AS ch_dog, dogs AS p_dog
  WHERE ch_dog.name=parents.child AND parents.parent=p_dog.name
  ORDER BY p_dog.height DESC
  ;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size
  FROM dogs, sizes
  WHERE height > min AND height <= max
  
  ;


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS
  SELECT dog1.name AS bro1, dog2.name AS bro2, dog1.size
  FROM size_of_dogs AS dog1, size_of_dogs AS dog2, parents AS p1, parents AS p2
  WHERE dog1.name != dog2.name AND dog1.size = dog2.size AND
        dog1.name = p1.child AND dog2.name = p2.child AND
        p1.parent = p2.parent
  ;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT 'The two siblings, ' || bro1 || ' and ' || bro2 || ', have the same size: ' || size
  FROM siblings
  WHERE bro1 <= bro2
;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, MAX(height) - MIN(height) AS height_range
  FROM dogs
  GROUP BY fur
  HAVING 0.7*AVG(height) <= MIN(height) AND MAX(height) <= 1.3*AVG(height)
  
  ;

