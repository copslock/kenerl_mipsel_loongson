Received:  by oss.sgi.com id <S305156AbPKXWgS>;
	Wed, 24 Nov 1999 14:36:18 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:33099 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbPKXWgA>;
	Wed, 24 Nov 1999 14:36:00 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08736
	for <linuxmips@oss.sgi.com>; Wed, 24 Nov 1999 14:42:18 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA60949
	for linux-list;
	Wed, 24 Nov 1999 14:25:11 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [150.166.49.50])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA96980;
	Wed, 24 Nov 1999 14:25:01 -0800 (PST)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: (from ulfc@localhost)
	by calypso.engr.sgi.com (8.9.3/8.8.7) id OAA01515;
	Wed, 24 Nov 1999 14:24:51 -0800
Date:   Wed, 24 Nov 1999 14:24:51 -0800
From:   Ulf Carlsson <ulfc@cthulhu.engr.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, bbrown@ti.com, mhassler@ti.com,
        vwells@ti.com, kmcdonald@ti.com
Subject: Re: kgdb support
Message-ID: <19991124142451.H30786@engr.sgi.com>
References: <99112412134700.03259@jharrell_dt> <19991124114330.F30786@engr.sgi.com> <383C4F7C.C0C40DE0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <383C4F7C.C0C40DE0@ti.com>; from Jeff Harrell on Wed, Nov 24, 1999 at 01:50:04PM -0700
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> I am porting the MIPS/Linux version of the Linux kernel to a IDT79S145
> evaluation board.  This board has a IDT64475 (MIPS).  I would like to use a
> standard serial port as a kgdb port.  I will use my other serial port for the
> console port.  Could you provide any additional information regarding the kgdb
> interface?   Is kgdb a standalone application that would need to be built on
> the host to access a target board or is it a patch to the kernel files that
> needs to built into the kernel running on the host?

I think kgdb basically is the same thing as gdb-stubs was, they just renamed it
for some reason. There is a program that comes with gdb-stubs that will let you
drop into kgdb over the serial line if you run it on the target.  You don't need
anything else than gdb to actually run the stuff once the kernel on the target
machine is in the kgdb mode.  If you get a kernel fault, it will automatically
drop into kgdb.  Read the patch and you'll see.

Scott Lurndal is currently working on support for kdb on MIPS, and that will
make things a bit easier when it's working.  Do not exchange kgdb and kdb, they
are two different things :-).

Ulf
