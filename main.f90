program orbit

    use output
    use calcs
    use initialize
    use movement

    implicit none

    real :: results(5000, 6)
    real :: dt, time
    integer :: timestep
    real, parameter :: e = 0.7

    real :: momentum(5000)
    real :: energy(5000)
    real :: times(5000)


    time = 0
    timestep = 1
    dt = 0.05
    call setup(results, e)
    call data_out(results, time, timestep)

    times(1) = time
    momentum(timestep) = ang_mom(results, timestep)
    energy(timestep) = eng(results, timestep)



    do timestep=2,5000

      time = timestep*dt

      !call rk4(results, dt, timestep)
      call leapfrog(results, dt, timestep)

      if (mod(timestep, 20)==0) then
        call data_out(results, time, timestep)

      endif

      times(timestep) = time
      momentum(timestep) = ang_mom(results, timestep)
      energy(timestep) = eng(results, timestep)

    enddo

    call conservation_out(momentum, energy, times, timestep)


end program orbit
