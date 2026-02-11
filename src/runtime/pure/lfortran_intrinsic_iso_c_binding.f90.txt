module lfortran_intrinsic_iso_c_binding
implicit none

type :: c_ptr
    integer ptr
end type

type :: c_funptr
    integer ptr
end type

! Numeric data types
integer, parameter :: c_int = 4                  ! int              
integer, parameter :: c_short = 2                ! short             
integer, parameter :: c_long = 8                 ! long int                   
integer, parameter :: c_long_long = 8            ! long long int              
integer, parameter :: c_signed_char = 1          ! signed char, unsigned char 
integer, parameter :: c_size_t = 8               ! size_t                     
integer, parameter :: c_int8_t =  1              ! int8_t                     
integer, parameter :: c_int16_t = 2              ! int16_t                    
integer, parameter :: c_int32_t = 4              ! int32_t                    
integer, parameter :: c_int64_t = 8              ! int64_t                    
integer, parameter :: c_int_least8_t = 1         ! int_least8_t               
integer, parameter :: c_int_least16_t = 2        ! int_least16_t              
integer, parameter :: c_int_least32_t = 4        ! int_least32_t              
integer, parameter :: c_int_least64_t = 8        ! int_least64_t              
integer, parameter :: c_int_fast8_t = 1          ! int_fast8_t                
integer, parameter :: c_int_fast16_t = 2         ! int_fast16_t               
integer, parameter :: c_int_fast32_t = 4         ! int_fast32_t               
integer, parameter :: c_int_fast64_t = 8         ! int_fast64_t               
integer, parameter :: c_intmax_t = 8             ! intmax_t                   
integer, parameter :: c_intptr_t = 8             ! intptr_t                   
integer, parameter :: c_ptrdiff_t = 8            ! ptrdiff_t                  
!!integer, parameter :: real = 4                  ! c_float
integer, parameter :: c_float = 4                ! c_float     
integer, parameter :: c_double = 8               ! double                    
integer, parameter :: c_long_double = -1         ! long double   
!!integer, parameter :: c_complex = 4             ! c_float_complex            
integer, parameter :: c_float_complex = 4        ! c_float_complex            
integer, parameter :: c_double_complex = 8       ! c_double_complex            
integer, parameter :: c_long_double_complex = -1 ! long double _complex       
integer, parameter :: c_bool = 1                 ! c_bool              
integer, parameter :: c_char = 1                 ! c_char 

! Character(1) data types
character(len=1), parameter :: c_null_char       = char(0)       ! null character  = '\0'
character(len=1), parameter :: c_alert           = char(7)       ! alert  = BEL   = '\a'
character(len=1), parameter :: c_backspace       = char(8)       ! backspace       = '\b'
character(len=1), parameter :: c_form_feed       = char(12)      ! form feed       = '\f'
character(len=1), parameter :: c_new_line        = char(10)      ! new line        = '\n'
character(len=1), parameter :: c_carriage_return = char(13)      ! carriage return = '\r'
character(len=1), parameter :: c_horizontal_tab  = char(9)       ! horizontal tab  = '\t'
character(len=1), parameter :: c_vertical_tab    = char(11)      ! vertical tab    = '\v'

! Null pointer
type(c_ptr), parameter :: c_null_ptr = c_ptr(0)
type(c_funptr), parameter :: c_null_funptr = c_funptr(0)

interface
    logical function c_associated(c_ptr_1)
    import c_ptr
    type(c_ptr), intent(in) :: c_ptr_1
    end function

    subroutine c_f_pointer(cptr, fptr, shape)
    import c_ptr
    type(c_ptr), intent(in) :: cptr
    !type(*), pointer, intent(out) :: fptr
    integer, pointer, intent(out) :: fptr
    integer, intent(in), optional :: shape(:)
    end subroutine

    !type(c_ptr) function c_loc(x)
    integer function c_loc(x)
    import c_ptr
    !type(*), intent(in) :: x
    integer, intent(in) :: x
    end function

    !type(c_funptr) function c_funloc(x)
    integer function c_funloc(x)
    import c_funptr
    !type(*), intent(in) :: x
    integer, intent(in) :: x
    end function
end interface

end module
