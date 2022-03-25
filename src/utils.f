      module utils

      character*1 :: slash = '/'

      contains

      subroutine getdat(iYear, iMonth, iDay)

      integer*2 iYear, iMonth, iDay
      integer time_vec(8)

      call date_and_time(values = time_vec)

      iYear = time_vec(1)
      iMonth = time_vec(2)
      iDay = time_vec(3)

      end subroutine

      subroutine gettim(iHours, iMins, iSecs, i100th)

      integer*2 iHours, iMins, iSecs, i100th
      integer time_vec(8)

      call date_and_time(values = time_vec)

      iHours = time_vec(5)
      iMins = time_vec(6)
      iSecs = time_vec(7)
      i100th = time_vec(8)/10

      end subroutine

      end module
