Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Sep 2004 09:05:50 +0100 (BST)
Received: from web60707.mail.yahoo.com ([IPv6:::ffff:216.109.117.230]:33129
	"HELO web60707.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224920AbUI2IFn>; Wed, 29 Sep 2004 09:05:43 +0100
Message-ID: <20040929080531.85660.qmail@web60707.mail.yahoo.com>
Received: from [61.11.17.69] by web60707.mail.yahoo.com via HTTP; Wed, 29 Sep 2004 01:05:31 PDT
Date: Wed, 29 Sep 2004 01:05:31 -0700 (PDT)
From: Shantanu Gogate <sagogate@yahoo.com>
Subject: MIPS kernel emulator issues
To: baitisj@evolution.org, jdl@vivato.net
Cc: uclibc@uclibc.org, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <sagogate@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sagogate@yahoo.com
Precedence: bulk
X-list: linux-mips

Guys,

Any pointers which will lead to explaining why I am getting segmentation fault and kernel
stacktraces on floating point instructions being generated through uClibc would be appreciated.

I found this thread involving Jeff and Jon a bit relevant to my problem. Hence mailing them
directly.
http://www.uclibc.org/lists/uclibc/2003-June/006379.html

This thread started by Jon is almost exactly my problem, but I dont see any replies to that post.
http://www.uclibc.org/lists/uclibc/2003-May/006182.html
Both these posts are over an year old.

The situation here is as follows:

I have 2 boards based on a 4Kc MIPS core. One on which we have
successfully ported everything from booloader to applications. The other
is almost similar to this one (the Processor core is the same), just the
things around like RAM,Flash chip, ENET PHY are different. We are using
cross compiler gcc (version 3.3.4) along with uClibc, kernel 2.4.25. Everything is working fine on
platform #1. The kernel as well as the userland applications are all compiled with the same gcc
cross compiler (version 3.3.4)

a) on platform #2 when I run any program which calls any function from
uClibc which uses floating point numbers you get a kernel stack trace
saying "Reserved instruction in kernel code in traps.c::do_ri, line 663"
and a lengthy stack trace follows.

b) the same static binary which just does z = x *y, where x,y,z are floats and prints two floating
point numbers runs fine on platform #1.

c) If I remove the "printf" and just write the floating point arithmetic
instructions ( i.e something like z = x*y ). I dont get the stack trace on platform #2 or #1

d) If I statically link this small program with glibc instead, it works
fine on platform #2 _and_ #1.

e) If I load the platform #2 with a kernel image over tftp from a remote machine
where the rootfs is embedded inside the kernel image itself, then the
dummy program linked with uClibc or glibc works fine ..no stacktrace !!!

If "e)" was not happening i.e the embedded ramdisk rootfs was also giving same
problems then one could have said that it was something to do with
incorrect compilation of uClibc itself, which is why it was working with
glibc but not with uClibc. However programs linked with the same uClibc
are working when the embedded rootfs kernel is loaded. How ?!? Why ?!! 

uClibc configuration is to have floating point support and "HAS_FPU=y". If I change "HAS_FPU=n"
then it does compile with "-msoft-float", however the printf output from the dummy program is just
"nan".


Regards,
Shantanu




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
