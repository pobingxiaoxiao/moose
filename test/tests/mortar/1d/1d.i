[Mesh]
  file = 2-lines.e
  construct_side_list_from_node_list = true
[]

[Variables]
  [./u]
    order = FIRST
    family = LAGRANGE
    block = '1 2'
  [../]

  [./lm]
    order = FIRST
    family = SCALAR
  [../]
[]

[Kernels]
  [./diff]
    type = Diffusion
    variable = u
  [../]
[]

[ScalarKernels]
  [./ced]
    type = NodalEqualValueConstraint
    variable = lm
    var = u
    nodes = '2 3'
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = u
    boundary = '1'
    value = 1
  [../]

  [./right]
    type = DirichletBC
    variable = u
    boundary = '2'
    value = 3
  [../]

  [./evc1]
    type = OneDEqualValueConstraintBC
    variable = u
    boundary = '100'
    lambda = lm
    component = 0
    vg = 1
  [../]

  [./evc2]
    type = OneDEqualValueConstraintBC
    variable = u
    boundary = '101'
    lambda = lm
    component = 0
    vg = -1
  [../]
[]

[Preconditioning]
  [./fmp]
    type = SMP
    full = true
    solve_type = 'NEWTON'
  [../]
[]

[Executioner]
  type = Steady
[]

[Outputs]
  exodus = true
  output_on = 'initial timestep_end'
  [./console]
    type = Console
    perf_log = true
    output_on = 'timestep_end failed nonlinear'
  [../]
[]
