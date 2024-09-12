#include <omp.h>

#include <cmath>
#include <fstream>
#include <vector>

#include "collision.h"
#include "io.h"
#include "sim_validator.h"

int main(int argc, char* argv[]) {
    // Read arguments and input file
    Params params{};
    std::vector<Particle> particles;
    read_args(argc, argv, params, particles);

    // Set number of threads
    omp_set_num_threads(params.param_threads);

#if CHECK == 1
    // Initialize collision checker
    SimulationValidator validator(params.param_particles, params.square_size, params.param_radius);
    // Initialize with starting positions
    validator.initialize(particles);
    // Uncomment the line below to enable visualization (makes program much slower)
    // validator.enable_viz_output("test.out");
#endif

    // TODO: this is the part where you simulate particle behavior.

    /*
    After simulating each timestep, you must call:

    #if CHECK == 1
    validator.validate_step(particles);
    #endif
    */

#if CHECK == 1
    // Check final positions
    validator.validate_step(particles);
#endif
}
