Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA26709; Sun, 4 Aug 1996 00:54:21 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA02098 for linux-list; Sun, 4 Aug 1996 07:53:51 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA02093 for <linux@cthulhu.engr.sgi.com>; Sun, 4 Aug 1996 00:53:50 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA26656; Sun, 4 Aug 1996 00:53:49 -0700
Date: Sun, 4 Aug 1996 00:53:49 -0700
Message-Id: <199608040753.AAA26656@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: more on real-time functionality for Linux
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Because Larry mentioned some things regarding real time under Linux
just to other day, I thought the following text would be interesting
to people.

A Vision for Linux 2.2 -- POSIX.1b Compatibility and Real-Time Support
----------------------------------------------------------------------

Markus Kuhn -- 1996-07-22


[The latest version of this text can be found on <URL:ftp://
ftp.informatik.uni-erlangen.de/local/cip/mskuhn/misc/linux-posix.1b>.]

Today, the Linux kernel and libc are quite well compatible with the
POSIX.1 and POSIX.2 standards, which specify system calls, library
functions and shell command compatibility for UNIX-style operating
systems. Some Linux distributions have even passed POSIX.1 conformance
tests. However, the POSIX.1 system calls and library functions define
only a minimum core functionality required by anything that looks like
UNIX. Many slightly more advanced functions like mmap(), fsync(),
timers, modifiable scheduling algorithms, IPC, etc., which are
essential for many real world applications, have not been standardized
by POSIX.1 in 1990.

The new POSIX.1b standard (now officially called IEEE Std
1003.1b-1993, ISBN 1-55937-375-X, during development of the standard,
it was called POSIX.4) corrects this and I believe POSIX.1b contains a
large number of useful ideas for further development on Linux.

In the very short introduction below, I hope to rise your interest in
POSIX.1b and in real-time problems in general and to stimulate some
development work in this direction. Happy reading!


The new POSIX extensions focus on the requirements of real-time
applications and on applications which have to perform high
performance I/O. Many applications like interactive video games, high
performance database servers, multimedia players and control software
for all kinds of hardware require more deterministic scheduling,
paging, signaling, timing and inter process communication mechanisms
than what is available on traditional UNIX systems like BSD4.3. The
functionality of systems like BSD4.3 has been optimized with mainframe
multi-user time-sharing scenarios in mind, while operating systems for
personal computers should also support real-time applications in
addition. On a personal computer, it is often acceptable and desired
that for example interactive games or CPU and memory intensive
multimedia applications are excluded from the normal paging and
scheduling strategies that try to be as fair as possible to all users
of a large mainframe.

The lack of real-time capability in Linux 1.2 has so far been the main
reason why still a number of interesting applications that run fine on
MS-DOS were unimplementable as user processes under Linux. Some
examples are for instance highly reliable audio recording/replay
tools, control software for astronomical CCD cameras, real-time signal
processing algorithms, serial port smartcard emulators, MIDI computer
music tools, etc. With the recent addition of POSIX.1b memory locking
and static priority scheduling functions to Linux 1.3, this starts to
change now. A lot of things still have to be implemented and your
contributions are very welcome! This text summarizes, what functions
have not yet been implemented and which people have already started to
work on some of these. Please contact them if you want to know the
status of their work or if you want to contribute. Please let me know
about any progress so that I can keep this text up-to-date.

In order to use the first new POSIX.1b features that have recently
been added to Linux, please install a recent kernel, libc-5.3.12, and
man-pages-1.11 or newer as available via ftp from sunsite.unc.edu or
tsx-11.mit.edu. The real-time-support is far from complete, but some
interesting features are already available.


POSIX.1b-1993 defines in addition to POSIX.1-1990 the following new
concepts and functions:


Improved Signals
----------------

POSIX.1b adds a new class of signals. These have the following new
features:

  - there are much more user specified signals now, not only SIGUSR1
    and SIGUSR2.

  - The additional POSIX.1b signals can now carry a little bit data (a
    pointer or an integer value) that can be used to transfer to the
    signal handler information about why the signal has been caused.

  - The new signals are queued, which means that if several signals of
    the same type arrive before the signal handler is called, all of
    them will be delivered.

  - POSIX.1b signals have a well-defined delivery order, i.e. you can
    work now with signal priorities.

  - A new function sigwaitinfo() allows to wait on signals and to
    continue quickly after the signal arrived with program execution
    without the overhead of calling a signal handler first.

The new queued signals are a necessary prerequisite for the
implementation of the POSIX.1b asynchronous I/O interface (see below).
They might also provide a good interface for delivering hardware
interrupts to user processes.

New functions for signals are:

  sigwaitinfo(), sigtimedwait(), sigqueue().

Implementation status: not yet implemented. Kevin Tran
<ttran@cs.UCR.edu> has sent me a short note that he has started to do
some work on POSIX.1b signals for Linux.


Inter Process Communication (IPC) and memory mapped files
---------------------------------------------------------

POSIX.1b now defines shared memory, messages, and semaphores. The
functionality and design of these is similar or better than the System
V IPC mechanisms which we have already in Linux. The major extensions
compared to System V IPC are:

  - Strings (like filename paths) instead of integers are used now to
    identify IPC resources. This will allow to avoid IPC resource
    collisions much easier than in SysV IPC. The POSIX IPC name space
    should probably be made visible as a /proc/ipc subdirectory, such
    that the usual tools like ls and rm can be used to locate and
    remove stale persistent IPC resources.

  - Semaphores come in two flavors: kernel based semaphores (as in
    System V, which requires a system call for each P/V operation) and
    now also user memory based semaphores. Kernel based semaphores are
    sometimes necessary for security reasons, however they are a real
    pain if you want to build e.g. a high performance database:
    Suppose there are 20 server processes operating on a single huge
    B-tree in a memory mapped database file. Inserting a node with
    minimal blocking of concurrent accesses by the other 19 processes
    in a large B-tree can require around 100 semaphore operations, and
    this means currently 100 kernel calls :-(. With POSIX.1b's user
    memory based semaphores, you put all your semaphores in a piece of
    shared memory and the library accesses them with highly efficient
    test-and-set machine code. System calls will then only be
    necessary in the rare case of a blocking P operation. A high
    performance database programmer's dream and easy to implement!

  - In POSIX.1b, both memory mapped files and shared memory are done
    with the mmap() system call.

The new functions for IPC are:

  mmap(), munmap(), shm_open(), shm_close(), shm_unlink(), ftruncate(),
  sem_init(), sem_destroy(), sem_open(), sem_close(), sem_unlink(),
  sem_wait(), sem_trywait(), sem_post(), sem_getvalue(), mq_open(),
  mq_close(), mq_mq_unlink(), mq_send(), mq_receive(), mq_notify(),
  mq_setattr(), mq_getattr(), mprotect().

Implementation status: POSIX IPC has not yet been implemented
(although a part of the basic mechanisms is already available in the
existing SysV IPC code). Since Linux 1.3, mmap() is fully implemented.
Eric Dumas <dumas@freenix.fr> has written me that he has done some
work on POSIX IPC, however there are no patches available, yet.


Memory locking
--------------

Four new functions mlock(), munlock(), mlockall() and munlockall()
allow to disable paging for either specified memory regions (mlock())
or for all pages (code, stack, data, shared memory, mapped files,
shared libraries) to which a process has access (mlockall()). This
allows to guarantee that for instance small time-critical daemons stay
in memory which can help to guarantee response time of these
processes. Under Linux, this (like many other real-time related
features) is only allowed for root processes in order to avoid abuse
of this feature by normal users in large time-sharing systems.

Another application of memory locking are cryptographic computer
security programs. Using mlock(), these systems can ensure that an
unencrypted secret key or a password which is temporarily stored in a
small user space array will never get in contact with the swap device,
where under rare circumstances, someone might find the secret bytes
even many months later. For these applications, it would be desirable
if Linux allowed even non-root processes a small number of mlock()ed
pages (e.g. up to four locked pages per non-root process should be
ok).

Implementation status: Linus has now added full POSIX.1b memory
locking support to Linux alpha test kernel version 1.3.43. There exist
also libc support and manual pages. So you won't have to apply the
POSIX.4_locking patch from Ralf Haller <hal@iitb.fhg.de> any more.



Synchronous I/O
---------------

Databases, e-mail systems, log daemons, etc. require to be sure that
the written piece of data has actually reached the harddisk, because
transaction protocols require that a system crash or power failure
after the write command can not harm the data any more. POSIX.1b
defines the fsync() and O_SYNC mechanisms which Linux 1.2 already has.

In addition, there is a very useful new function fdatasync() which
requires that the data block is flushed to disk, however which does
NOT require that the inode with the latest access/modification time is
also flushed each time. With fdatasync(), the inode has only to be
written in case the file length, file owner, or permission bits have
changed. In database applications with mostly constant file sizes,
where you sometimes require an fsync() after each few written blocks,
but where you don't care about whether the access times in the inodes
on the disc are always 100% up-to-date, fdatasync() could easily
double (!) the performance of your system.

There is also an msync() function for flushing a range of pages from
memory mapped files to the disk.

Implementation status: fsync(), fdatasync(), msync(), and O_SYNC are
already available. O_DSYNC has not yet been implemented. However
fdatasync() in Linux 1.3.55 is currently only an alias for fsync() and
therefore not yet any more efficient than fsync().


Timers
------

  - Instead of the old BSD style gettimeofday()/settimeofday() calls,
    POSIX.1b defines clock_gettimer(), clock_settimer() and
    clock_getres(). They offer nanosecond resolution instead of
    microseconds as with the old BSD calls (at least on Pentiums, a
    timer resolution much than a microsecond is available). In
    addition, you can query now the actual resolution of the timer
    with clock_getres().

  - A new function nanosleep() allows to sleep also for less than a
    second (the old sleep() had only second resolution). In addition,
    nanosleep won't interfere with SIGALRM and in case of EINTR, it
    returns the time left, so you can easily continue in a while loop.

  - POSIX.1b defines also itimers, however instead of what the
    existing BSD itimers provide, you now can deal with several timers
    (at least 32 per process) and you have again theoretically up to
    one nanosecond resolution. The old itimer functions can still
    easily be implemented in libc for compatibility reasons using new
    POSIX-style itimer system calls.

Implementation status: The POSIX clock and itimers system calls have
not not yet been implemented, although much of the functionality is
already available in the form of the BSD timers and adding them should
be quite easy. Queued signals have to be implemented first for
itimers. Nanosleep() is already available in Linux, but at the moment
it supports only 10 ms resolution and it can optionally perform short
microsecond precision busy waits of up to 2 ms length.


Scheduling
----------

Linux 1.2 has so far been optimized a lot as a time sharing system,
where several people run application programs like editors, compilers,
debuggers, X window servers, networking daemons, etc. and do word
processing, software development, etc.

However there are a lot of applications for which Linux is currently
unusable and for which even die-hard Linux enthusiasts have to keep a
stand-alone DOS version on their disk. For >90% of these applications,
the fact that Linux is incapable of guaranteeing the response time of
an application is the major problem. Software for controlling e.g. an
EPROM programmer, a robot arm, or an astronomical CCD camera is not
realizable under a classic Unix if there is no dedicated real-time
controller present in the controlled device. A lot of commercially
available hardware has been designed with the real-time "capability"
of DOS in mind and has no own microcontroller for time-critical
actions.

A real-world example: I have myself spent a long frustrating time of
trying to implement an interface to a pay-TV decoder for Linux (which
emulates a chip card and allows you to watch pay-TV for free :-). In
this application, you have to wait for an incoming byte on the serial
port, then you have to wait for around 0.7 to 2 ms (never shorter,
never longer, otherwise the TV decoder gets a timeout and stops!)
before returning an answer byte. It is virtually impossible to
implement a user process for this task under Linux 1.2, while it is
trivial to do this under DOS. I am looking forward to the day when
Linux provides enough real-time support for this application so that I
can finally remove MS-DOS from my harddisk.

For these and similar real-time applications, POSIX.1b specifies three
different schedulers, each with static priorities:

  SCHED_FIFO     A preemptive, priority based scheduler. Each process
                 managed under this scheduling priority possesses the
                 CPU as long as (a) it does not block itself and (b)
                 there comes no interrupt which puts another process
                 into a higher priority wait queue. There exists a FIFO
                 queue for each priority level and every process which
                 gets runnable again is inserted into the queue behind
                 all other processes. This is the most popular
                 scheduler used in typical real-time operating
                 systems. Function sched_yield() allows the process to
                 go to the end of the FIFO queue without blocking.

  SCHED_RR       A preemptive, priority based round robin scheduling
                 strategy with quanta. It is a very similar to
                 SCHED_FIFO, however each process has a time quantum and
                 the process becomes preempted and is inserted at the
                 end of the FIFO for the same priority level if it
                 runs longer than the time quantum and other processes
                 of the same priority level are waiting in the queue.
                 Processes of lower priorities will like in SCHED_FIFO
                 never get the CPU as long as a higher level process
                 is in a ready queue and if a higher priority process
                 becomes ready to run, it also gets the CPU immediately.

  SCHED_OTHER    This is any implementation defined scheduler. Under
                 Linux it is the classic time-sharing scheduler with
                 "nice" values, etc. Under Linux, all SCHED_OTHER
                 processes share the common static priority value 0.

For security reasons, only root processes should under Linux be
allowed to get any static priority higher than the one for
SCHED_OTHER, because if these real-time scheduling mechanisms are
abused, the whole system can be blocked.

If one is developing a real-time application, it is a very good idea
to have a shell with a higher static priority somewhere open in order
to be able to kill the tested application in case something goes
wrong. You should be aware, that if you use X11, not only the shell,
but also the X server, the window manager and xterm will require a
higher static priority in order to stop processes blocking the rest of
the system. Therefore, testing real-time software will usually better
be done on the console.

With this POSIX.1b functionality, it is possible to run real-time
software under Linux by giving it root permissions and assigning it a
SCHED_FIFO strategy and a higher static priority than all other
classic SCHED_OTHER Linux processes. In addition, typical real-time
application lock their pages with mlockall() into the memory in order
to avoid being swapped out. This guarantees that the real-time
application can react as soon as possible on any interrupts and that
the response time will not be influenced by the complicated normal
Linux time-sharing priority mechanisms or by paging. However, please
read also the chapter on interrupt dispatch latency below!

The new functions are here:

  sched_setparam(), sched_getparam(), sched_setscheduler(),
  sched_getscheduler(), sched_yield(), sched_get_priority_max(),
  sched_get_priority_min(), sched_rr_get_interval().

Implementation status: The sched_*() system calls are now available
since Linux 1.3.55 (Markus Kuhn <mskuhn@cip.informatik.uni-erlangen.de>).
Although much testing, performance evaluation, and optimization with
the real-time scheduler is necessary (especially with regard to "fast
interrupt handling, see below), you can already use the sched_*()
calls in order to get the processor exclusively. There are also libc
and manual pages available. Some earlier work on this was done by
David F. Carlson <carlson@dot4.com> in his POSIX.4_scheduler patch
against Linux 1.2 (still available on sunsite).


Asynchronous I/O (aio)
----------------------

POSIX.1b defines a number of functions which allow to send a long list
of read/write requests at various seek positions in various files to
the kernel with one single lio_listio() system call. While the process
continues to execute the next instructions, the kernel will
asynchronously read or write the requested pages and will send signals
when the task has been completed (if this is desired).

This is very nice for a database which knows that it will require a
lot of different blocks scattered on a file. It will simply pass a
list of the blocks to the kernel, and the kernel can optimize the disk
head movement before sending the requests to the device. In addition
this minimizes the number of system calls and allows the database to
do something else in the meantime (e.g. waiting for the client process
sending an abort instruction in which case the database server can
cancel the async i/o requests with aio_cancel()).

Another important application of aio are multimedia systems like MPEG
or sound file players and recorders. These programs want to preload
the next few seconds of the data stream from harddisk into locked
memory, but also want to continue showing the video on the screen at
the same time without any interruptions caused by synchronous I/O. The
POSIX.1b async I/O calls provide a nice way for such anticipatory
loading.

POSIX.1b also defines priorities for asynchronous I/O, i.e. there is a
way to tell the kernel that the read request for the MPEG player is
more important than the read request of gcc. On a future real-time
Linux, you don't want to see any image distortions while watching MPEG
video and compiling a kernel at the same time if you gave the MPEG
player a higher static priority.

New functions in this area are:

  aio_read(), aio_write(), lio_listio(), aio_suspend(), aio_cancel(),
  aio_error(), aio_return(), aio_fsync().

Implementation status: Not yet implemented. The aio functions are
probably best implemented in libc using kernel threads and the normal
synchronous I/O system calls. There has recently been some progress on
implementing kernel threads in Linux 1.3 using the clone() system
call. Adding priority I/O to Linux might be a more complicated job,
because many device drivers would have to be extended by priority wait
queues.


Implemented options
-------------------

As POSIX.1b conformance does not require the implementation of all
these functions, macros have been specified for <unistd.h> that
indicate to application software which of the POSIX.1b functionality
is available on this system. This way, portable software can be
written that uses real-time features only when they are available.

Under the latest Linux kernel and libc development versions, the
following POSIX.1b macros have been defined and indicate implemented
functions:

     _POSIX_FSYNC
     _POSIX_MAPPED_FILES
     _POSIX_MEMLOCK
     _POSIX_MEMLOCK_RANGE
     _POSIX_MEMORY_PROTECTION
     _POSIX_PRIORITY_SCHEDULING

The POSIX.1b options indicated by the following macros have not yet
been implemented under Linux:

     _POSIX_ASYNCHRONOUS_IO
     _POSIX_MESSAGE_PASSING
     _POSIX_PRIORITIZED_IO
     _POSIX_REALTIME_SIGNALS
     _POSIX_SEMAPHORES
     _POSIX_SHARED_MEMORY_OBJECTS
     _POSIX_SYNCHRONIZED_IO
     _POSIX_TIMERS


General real-time problems
--------------------------

Apart from implementing new POSIX.1b system calls, there are a number
of other problems with the current Linux kernel that have to be solved
in order to improve real-time performance.

Problem 1: Interrupt dispatch latency

A blocked process waiting for the end of some I/O request becomes
runnable again when the CPU receives an interrupt from the I/O device
that processed the request. The time that passes between the interrupt
and the execution of the interrupt handler is called the "interrupt
latency". The time that passes between the interrupt and the
continuation of the execution of the blocked process is called the
"interrupt dispatch latency". We are assuming that the blocked process
is the process with the highest priority (the POSIX.1b scheduler
system calls allow to ensure this). Many real-time applications
require that the interrupt dispatch latency is as short as possible,
some applications require even guarantees for the maximum interrupt
dispatch latency (e.g. 20 microseconds).

At the moment, Linux has basically two types of interrupt handlers:
"fast" and "slow" ones.

The "slow interrupt handlers" call the scheduler each time immediately
after the interrupt has been handled. This guarantees that if the
process has become runnable by handling the interrupt and has the
highest priority, then it will directly get control over the CPU after
the interrupt handler. This ensures a short interrupt dispatch
latency, but the cost is that the scheduler is executed for each
interrupt, which can cause a system performance degradation for
devices with a high interrupt rate (e.g., network controllers). The
slow interrupt handler do not disable other interrupts while they are
being executed. This ensures a low interrupt latency, because other
higher priority interrupts will not be blocked. The "slow" interrupt
handler behavior is what you want for real-time applications.

The "fast interrupt handlers" only mark in a bitmask that an interrupt
has been handled for this device. The scheduler is NOT called after
the fast interrupt handler and the process waiting on the interrupt
may have to wait up to 1 s / HZ = 10 ms for the next timer interrupt
which will call the scheduler again (because the timer interrupt is
handled the "slow" way). "Fast" interrupt handlers are those which are
installed by the driver by specifying the SA_INTERRUPT option when
calling request_irq(). "Fast" interrupt handlers are the reason why
for devices like the serial port, the interrupt dispatch latency can
easily reach 10 ms and more. "Fast" interrupt handlers disable other
interrupts while the handler is being executed. This increases
interrupt latency. The Linux "fast" interrupt handlers cause very low
interrupt handling overhead, but they can be the cause for a lot of
headaches for real-time application developers.

See linux/arch/i386/kernel/irq.c, linux/include/asm-i386/irq.h and
linux/arch/i386/kernel/entry.S for implementation details of how fast
and slow interrupts are handled in Linux.

Examples for "slow" Linux 1.3 interrupt drivers with good interrupt
dispatch latency are

  keyboard
  floppy disk
  timer
  sound cards
  mouse drivers
  some Ethernet cards
  
Examples for "fast" interrupt drivers with bad interrupt dispatch
latency are

  serial port
  some Ethernet cards
  most harddisk/SCSI drivers
  most CD-ROM drivers

Especially for the serial port, it would be very nice to have a way to
switch to low dispatch latency interrupt handling, such that an
application can react as fast as possible on any incoming serial byte.
Apart from the "fast" interrupt handler type, another important cause
of latency in the serial port are the 16550 FIFO UARTs. At the moment,
the UARTs are configured to trigger an interrupt (except for for bit
rates < 2400 bit/s) only if the FIFO is filled with at least eight
bytes or if an UART timeout has occured (this happens after four
character transmission times). The 16550 chip can be configured to
trigger limits 1, 4, 8, and 14, but Linux currently provides no
ioctl() for this. For details about the FIFO UART, please consult the
National Semiconductor PC16550D data sheet.

For real-time applications, it would be very desirable to change the
FIFO trigger limit to one byte so that incoming serial bytes are
immediately delivered to the waiting process. Applications that depend
heavily on minimum serial port interrupt dispatch latency are for
example MIDI music systems, DCF77 reference time long-wave radio signal
receivers in Europe, packet radio network interfaces, and ISO 7816
smartcard interfaces.

Some existing work in this area:

Stuart Cheshire <cheshire@DSG.Stanford.EDU> has implemented a "smart"
interrupt handler that can switch between the classic "fast" and
"slow" alternatives (see <URL:http://mosquitonet.stanford.edu/
smartirq.html> for details). This way, you can get the real-time
advantage of "slow" handling for the serial port without introducing a
permanent system overhead even when no real-time application is
active.

Nick Simicich <njs@scifi.emi.net> and Rik Faith <faith@cs.unc.edu>
have written a program called "cytune" which can change the FIFO
thresholds for individual ports in the Cyclades async mux driver.

Problem 2: Timer resolution

On most Linux architectures, a timer interrupt occurs every 10 ms (HZ
= 100). One exception is the Alpha architecture, where the timer
interrupt comes every 1 ms (HZ = 1024). The macro HZ, which specifies
the timer frequency, is defined in <asm/param.h>. At the moment, the
kernel timer mechanism, on which the itimer and nanosleep
implementation is based, checks after each timer interrupt whether a
software timer has expired, makes the corresponding process runnable
again, and calls the scheduler. This means that a highest priority
real-time process can have to wait up to 2 * (1 s / HZ) = 20 ms longer
than requested.

An excellent solution would be to implement an interrupt-on-demand
timer facility. The 8253 timer/counter chip in the PC would then have
to be programmed such that it delivers an interrupt with microsecond
precision exactly at the time when a software timer expires. This
would increase the software timer precision by a factor of 10 000! As
the 8253 timer would be programmed in a single shot mode, a lost
interrupt might cause an accidental system halt. If this is problem,
the CMOS battery clock, which can also be used to implement periodic
interrupts, should be utilized to trigger periodic calls to the
scheduler in order to ensure process preemption and kernel clock
update. The time stamp counter (TSC) available in all Pentium
processors is a 64-bit counter clocked at CPU frequency. It can be
used on Pentium systems in order to get extremely precise timing
information with theoretically close to nanosecond resolution and
without overflow problems.




Literature
----------

For those of you who have become interested in POSIX.1b, there exists
a good book:

  Bill O. Gallmeister, POSIX.4 -- Programming for the Real World,
  O'Reilly & Associates, 1995, ISBN 1-56592-074-0.

This book is not only a good introduction into POSIX.1b (which was
originally called POSIX.4), it is also an easy reading nice way into
the world of real-time operating systems for those developers who have
so far been very UNIX and time-sharing oriented.

You can order the POSIX.1b standard (officially called IEEE Std
1003.1b-1993; this book includes also all text of POSIX.1 and costs
114 USD) as well as the other POSIX standards directly from IEEE:

  phone:  +1 908 981 1393 (TZ: eastern standard time)
           1 800 678 4333 (from US+Canada only)
  fax:    +1 908 981 9667
  e-mail: stds.info@ieee.org

Information about POSIX and other IEEE standards is also available on
<URL:http://stdsbbs.ieee.org/> and <URL:http://www.knosof.co.uk/
posix.html>, however unfortunately the full standard documents are
only available as books or on CD-ROM, not on the Internet. Having
access to the POSIX specs is certainly a good idea for any Linux
kernel hacker.

Here is a brief list of some of the POSIX standards:

  POSIX.1          Basic OS interface (C language)
  POSIX.1a         Misc. extensions (symlinks, etc.)
  POSIX.1b         Real-time and I/O extensions (was: POSIX.4)
  POSIX.1c         Threads (was: POSIX.4a)
  POSIX.1d         More real-time extensions (was: POSIX.4b)
  POSIX.1e         Security extensions, ACLs (was: POSIX.6)
  POSIX.1f         Transparent network file access (was: POSIX.8)
  POSIX.1g         Protocol independent communication, sockets (was: POSIX.12)
  POSIX.1i         Technical corrections to POSIX.1b
  POSIX.2          Shell and common utility programs (date, ln, ...)
  POSIX.3          Test methods
  POSIX.5          ADA binding to POSIX.1
  POSIX.7          System administration
  POSIX.9          FORTRAN-77 binding to POSIX.1
  POSIX.15         Supercomputing extensions (checkpoint/recovery, etc.)

and a few others which are still in early draft stage. If you want to
follow progress on POSIX standardization, you should read the
announcements in the moderated USENET group comp.std.unix. The current
status of POSIX drafts is summarized in <URL:http://stdsbbs.ieee.org/
groups/pasc/standing/sd11.html>.

ISO has also published POSIX.1 as ISO/IEC 9945-1:1990. ISO and IEEE
will soon publish the new revision of this standard: ISO/IEC
9945-1:1996. This will be the new 1996 revision of POSIX.1, which will
contain in one single standard POSIX.1(1990), POSIX.1b(1993),
POSIX.1c(1995), and POSIX.1i(1995) (perhaps also POSIX.1a(1996) if it
gets ready in time). If you want to order the POSIX standard but are
not in a hurry, may be it is a good idea to wait a few months until
ISO/IEC 9945-1:1996 is available. All differences between
POSIX.1(1990) and POSIX.1(1996) will be marked by bars at the page
margins.

This text just summarizes POSIX.1b and related work on Linux. Many
people interested in POSIX.1b support seem also to be interested in
POSIX.1c support (threads). Some information about POSIX.1c support is
on <URL:http://www.mit.edu:8001/people/proven/pthreads.html> and
<URL:http://www.aa.net/~mtp/>. There is now a production release
package called "PCthreads (tm) POSIX threads for Linux" available from
<URL:ftp://sunsite.unc.edu/pub/Linux/devel/lang/c/>. It is maintained
by Michael T. Peterson <mtp@big.aa.net>. A POSIX.1c package that
provides real kernel-threads using the clone() system call is
available from <URL:http://pauillac.inria.fr/~xleroy/linuxthreads/>
and has been developed by Xavier Leroy <Xavier.Leroy@inria.fr>.
