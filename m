Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VDpFk28656
	for linux-mips-outgoing; Tue, 31 Jul 2001 06:51:15 -0700
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VDpCV28646
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 06:51:12 -0700
Received: from real.realitydiluted.com ([208.242.241.164] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 15RZuu-0002a6-00; Tue, 31 Jul 2001 08:50:36 -0500
Message-ID: <3B66B5F3.79D6AAB8@cotw.com>
Date: Tue, 31 Jul 2001 08:43:15 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Horrible X and kernel crashes under mipsel RH7.1...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

Well, the X server is giving me fits with the new RH7.1 packages. This is
a rather long email, so hold on.

WHAT WORKS
----------
If I use MontaVista's older toolchain with a glibc-2.0.6 based root
filesystem with my 2.4.5 MIPS kernel and framebuffer and compile X from
CVS things work great.

WHAT DOES NOT WORK
------------------
If I use a new cross toolchain with latest binutils from HJLu, gcc-3.0 and
glibc-2.2.3 and the RH7.1 mipsel based distribution, X cross compiled form
CVS crashes and takes the kernel with it. I have not tested anything under
the Debian distros yet.

CRASH OUTPUT
------------
I did three different runs which gave me different results. Here is the
first one. I know that I had plenty of memory to handle the
2^5 = (32) 4KB pages = 128KB allocation.

root@localhost:/home/sjhill$ /usr/X11R6/bin/Xfbdev 
__alloc_pages: 5-order allocation failed.
__alloc_pages: 5-order allocation failed.
Unable to handle kernel paging request at virtual address 00000000, epc == 00000
000, ra == 80167750
Oops in fault.c:do_page_fault, line 172:
$0 : 00000000 801f0000 b30003f0 000000bb
$4 : 0000000c 0000006b 809d3bc0 00006b18
$8 : 00000020 801658f0 801cbc98 801c5000
$12: 00000001 00000040 00000003 81f6eea0
$16: 801dbf18 801cbe60 00000001 801d60cc
$20: 801d0a3c 809d3bc0 00000000 806e3620
$24: 00000001 2ac99d90
$28: 813f2000 813f3de0 00000000 80167750
epc   : 00000000
Status: b001f003
Cause : 00000008
Process Xfbdev (pid: 596, stackpage=813f2000)

***************

The next one I printed out the memory usage as well as the attempt to run
startx and xinit first. The page alloc messages aren't printed, but the
kernel still dies a horrible death.


root@localhost:~$ free
             total       used       free     shared    buffers     cached
Mem:         30340      26700       3640          0       3992      15536
-/+ buffers/cache:       7172      23168
Swap:        66016       2368      63648
root@localhost:~$ /usr/X11R6/bin/startx

giving up.
xinit:  Connection refused (errno 146):  unable to connect to X server
xinit:  No such process (errno 3):  Server error.
root@localhost:~$ free
             total       used       free     shared    buffers     cached
Mem:         30340      27424       2916          0       4052      16188
-/+ buffers/cache:       7184      23156
Swap:        66016       2368      63648
root@localhost:~$ xinit

free
giving up.
xinit:  Connection refused (errno 146):  unable to connect to X server
xinit:  No such process (errno 3):  Server error.
root@localhost:~$ free
             total       used       free     shared    buffers     cached
Mem:         30340      27428       2912          0       4052      16188
-/+ buffers/cache:       7188      23152
Swap:        66016       2368      63648
root@localhost:~$ /usr/X11R6/bin/Xfbdev 
[Xfbdev:522] Illegal instruction 801cbe60 at 801980a4 ra=80167750
Unable to handle kernel paging request at virtual address 00000000, epc == 80198
0b4, ra == 80167750
Oops in fault.c:do_page_fault, line 172:
$0 : 00000000 801f0000 b30003f0 000000bb
$4 : 0000000c 00000001 809b1c20 00006b18
$8 : 00000020 801658f0 801cbc98 801c5000
$12: 00000001 00000040 00000003 814b2e20
$16: 801dbf18 801cbe60 00000001 801d60cc
$20: 801d0a3c 809b1c20 00000000 80758840
$24: 00000001 2ac99d90
$28: 8119e000 8119fde0 00000000 80167750
epc   : 801980b4
Status: b001f003
Cause : 00000008
Process Xfbdev (pid: 522, stackpage=8119e000)

***************

This one gives a little more output and screams about illegal instructions.
root@localhost:~$ /usr/X11R6/bin/Xfbdev 
[Xfbdev:513] Illegal instruction 801cbe60 at 801980b8 ra=80167750
[Xfbdev:513] Illegal instruction 801cbe60 at 801980d0 ra=80167750
[Xfbdev:513] Illegal instruction 801cbe60 at 801980e8 ra=80167750
Unable to handle kernel paging request at virtual address 00000000, epc == 00000
000, ra == 80167750
Oops in fault.c:do_page_fault, line 172:
$0 : 00000000 801f0000 b30003f0 000000bb
$4 : 0000000c 00000001 80e84480 00006b18
$8 : 00000020 801658f0 801cbc98 801c5000
$12: 00000001 00000040 00000003 81659920
$16: 801dbf18 801cbe60 00000001 00000000
$20: 801d0a3c 80e84480 00000000 809369c0
$24: 00000001 2ac99d90
$28: 816a2000 816a3de0 00000000 80167750
epc   : 00000000
Status: b001f003
Cause : 00000008
Process Xfbdev (pid: 513, stackpage=816a2000)

***************

If anyone has had success or similar problems please comment. Thanks.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
