use wgpu_tutorial::run;
use pollster::pollster;

fn main() {
    pollster::block_on(run());
}
