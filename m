Received:  by oss.sgi.com id <S305156AbPKXVL6>;
	Wed, 24 Nov 1999 13:11:58 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36917 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbPKXVLh>; Wed, 24 Nov 1999 13:11:37 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA01420
	for <linuxmips@oss.sgi.com>; Wed, 24 Nov 1999 13:19:17 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA58866
	for linux-list;
	Wed, 24 Nov 1999 12:52:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA62775;
	Wed, 24 Nov 1999 12:51:43 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from gatekeep.ti.com (gatekeep.ti.com [192.94.94.61]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06537; Wed, 24 Nov 1999 12:51:37 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep4.itg.ti.com ([157.170.188.63])
	by gatekeep.ti.com (8.9.3/8.9.3) with ESMTP id OAA12753;
	Wed, 24 Nov 1999 14:50:52 -0600 (CST)
Received: from ti.com (IDENT:jharrell@ppp-isbas99-180.itg.ti.com [192.168.134.180])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id OAA25878;
	Wed, 24 Nov 1999 14:50:23 -0600 (CST)
Message-ID: <383C4F7C.C0C40DE0@ti.com>
Date:   Wed, 24 Nov 1999 13:50:04 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ulf Carlsson <ulfc@cthulhu.engr.sgi.com>
CC:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, bbrown@ti.com, mhassler@ti.com,
        vwells@ti.com, kmcdonald@ti.com
Subject: Re: kgdb support
References: <99112412134700.03259@jharrell_dt> <19991124114330.F30786@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ulf Carlsson wrote:

> On Wed, Nov 24, 1999 at 12:00:56PM -0700, Jeff Harrell wrote:
> > In the process of looking through the MIPS/Linux code base,  I noticed that
> > the kgdb interface seems to support the ZS85C30  (see the function
> > rs_kgdb_hook) but do not see where the generic serial interface (i.e.
> > /drivers/char/serial.c) is supported.  Is the kgdb support provided through
> > the file gdb-stub.c? Any help would be greatly appreciated.
>
> The kgdb that comes from ftp.gcom.com:/pub/linux/src provides support for normal
> serial ports if that's what you're looking for.  You may be able to use that
> serial driver with the gdb-stub.c that we have in arch/mips/kernel provided
> enough time to get the things together.  What are you trying to do?
>
> Ulf

I am porting the MIPS/Linux version of the Linux kernel to a IDT79S145 evaluation
board.  This board has a
IDT64475 (MIPS).  I would like to use a standard serial port as a kgdb port.  I
will use my other serial port for the
console port.  Could you provide any additional information regarding the kgdb
interface?   Is kgdb a standalone
application that would need to be built on the host to access a target board or is
it a patch to the kernel files that needs
to built into the kernel running on the host?

Jeff


--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 984-0183
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
