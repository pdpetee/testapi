CREATE ROLE director1 WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:XachiwhuSZubBgQL7oc4uQ==$mpApW5CYaMKzzp1mfbQJdY5Q9ZIJba1zbl7irTfMuTc=:Azh4uOgdHXNvYio6I0eSDPUbXhg2nzwG7sM10137lzA=';

CREATE ROLE director2 WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:XachiwhuSZubBgQL7oc4uQ==$mpApW5CYaMKzzp1mfbQJdY5Q9ZIJba1zbl7irTfMuTc=:Azh4uOgdHXNvYio6I0eSDPUbXhg2nzwG7sM10137lzA=';

CREATE ROLE emp1 WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:1j2BpP0WZ0rooCY37Dy17g==$Z8RUxmr3sfF3y1ro+eECN4zcokAvz8YaZzqovkadtzU=:UTagnW7JyM+E9EJvGxZptCPB48Z0nyh2HwmGvb7yIwc=';

COMMENT ON ROLE emp1 IS 'Employee from department 1 ';

CREATE ROLE emp2 WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:eJB3FXwQXInrr2INRrskSA==$H1mMAnsxkn5Zc9z8D1mY806OAiJNf4F3NvN50T1Utq0=:EXjbQRa16qWNt3MkaS17ninedrdUfy/gKiPb8+rVMSs=';

COMMENT ON ROLE emp2 IS 'Employee from department 2';

CREATE ROLE emp3 WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:T4a6vfpSAyG8yQqXvhQqKw==$Paea/4KLVxLHVYeHr2k3m6ubrkai4BiOlFygRNkzd+A=:nL02synnJ98nVlNYx93RFsA5+G8fhhhk+W3u+G9u8vo=';

COMMENT ON ROLE emp3 IS 'Employee from company 3';

CREATE ROLE guest WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:NBuQdst6bcaDxa9fv4+CEg==$Cav7vVszkshB4Ja5y8zWGJVlgeAUEzwjYoAPdAV2UtU=:vnr2eaY3EfFnO/jVBHRCmGRusW4zkuo8fKSrpihbmRI=';

COMMENT ON ROLE guest IS 'No permissions to do anything';

CREATE ROLE manager1 WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:cPQg9vwJbIoGOLPr+cPy3w==$d3xpXSv5fNEjn1kgSJV9D49wL+eYcL2utDpfY49kcpk=:oSMcTT63TmQu8rwgX9zMkGq02n38DwA2e3FQ8tJ2RNA=';

CREATE ROLE manager2 WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:RxpuS5q7TnYcuHbN46hKFw==$BSkBXSv3PoMlNZawgbTtezD1whrzikg2IpqaNxp/B8k=:t5iYxAfwxCJIViswyoEWjVrD3iyHRr8TOaUUkUy2xaE=';

CREATE ROLE manager3 WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:cgpTMs4aRlwjEQfnhPcAtQ==$sayu4hszYBaXbdzNHKPzNyOd97S9mstNpfuwbyg4GBs=:0GV2Py4brvOInLSSpv0yyRVDCyouinnXlV8HCE2tABQ=';

CREATE ROLE owner WITH
  LOGIN
  SUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:qL7qcTvJVZlDc9RHzrXYSw==$zO/ki1AWllewjQOq6KBQzCAHfG7NRUNFFlkPupEAcOg=:g52Nuw7Jidd2PvlyCrmnxQPre4zdQaxJaU2XgbqK1ik=';


    
