Received:  by oss.sgi.com id <S553990AbQKHHy1>;
	Tue, 7 Nov 2000 23:54:27 -0800
Received: from router.isratech.ro ([193.226.114.69]:45840 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553922AbQKHHyM>;
	Tue, 7 Nov 2000 23:54:12 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eA87rbM05625
	for <linux-mips@oss.sgi.com>; Wed, 8 Nov 2000 09:53:44 +0200
Message-ID: <3A09753F.DB2457EE@isratech.ro>
Date:   Wed, 08 Nov 2000 10:46:07 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: MIPS kernel!
Content-Type: multipart/mixed;
 boundary="------------302C573CB07886B58EA20698"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------302C573CB07886B58EA20698
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello ,

I tried to cross compile the kernel from ftp.embedix.com, meaning that
I found that this embedix Linux is made to work on any platform . I have
an Atlas board and a QED processsor (  a mips one ) and I fail in trying
to cross compile the linux-2.2.13. I get the following errors.

/home/nicu/Kituri/Lineo/linux-2.2.13/scripts/mkdep amigaffs.c bitmap.c
di
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/atomic.h:47: invalid
operands to binary +
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/atomic.h: In function
`atomic_sub':
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/atomic.h:57: invalid
operands to binary -
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/atomic.h: In function
`atomic_add_return':
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/atomic.h:67:
incompatible types in assignment
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/atomic.h:69:
incompatible types in assignment
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/atomic.h: In function
`atomic_sub_return':
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/atomic.h:81:
incompatible types in assignment
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/atomic.h:83:
incompatible types in assignment
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/timex.h: In function
`get_cycles':
In file included from
/home/nicu/Kituri/Lineo/linux-2.2.13/include/linux/timex.h:138,
                 from
/home/nicu/Kituri/Lineo/linux-2.2.13/include/linux/sched.h:14,
                 from
/home/nicu/Kituri/Lineo/linux-2.2.13/include/linux/mm.h:4,
                 from
/home/nicu/Kituri/Lineo/linux-2.2.13/include/linux/slab.h:14,
                 from
/home/nicu/Kituri/Lineo/linux-2.2.13/include/linux/malloc.h:4,
                 from
/home/nicu/Kituri/Lineo/linux-2.2.13/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/timex.h:36: warning:
implicit declaration of function `read_32bit_cp0_register'
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/timex.h:36: `CP0_COUNT'

undeclared (first use this function)
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/timex.h:36: (Each
undeclared identifier is reported only once
/home/nicu/Kituri/Lineo/linux-2.2.13/include/asm/timex.h:36: for each
function it appears in.)
make: *** [init/main.o] Error 1

Another weird thing . When I received my Atlas board I gqt a CD with the
kernel sources and binaries. I installed the binaries on the Atlas board
and it works fine but when I tried to cross compile the kernel I get
some stupid errors like the one above. I realy do not understand
anything , does anyone cross compiled a kernele for MIPS processors and
Atlas boards ? The version is linux 2.2.12.( the Hard Hat Linux ).

Thak you for all your help.

Regards,
Nicu

--------------302C573CB07886B58EA20698
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:POPOVICI;Nicolae Octavian 
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;Software
adr:;;;;;;
version:2.1
email;internet:octavp@isratech.ro
title:Software engineer
x-mozilla-cpt:;0
fn:Nicolae Octavian POPOVICI
end:vcard

--------------302C573CB07886B58EA20698--
