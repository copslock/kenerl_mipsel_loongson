Received:  by oss.sgi.com id <S305156AbPKXWBS>;
	Wed, 24 Nov 1999 14:01:18 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:43070 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbPKXWA4>;
	Wed, 24 Nov 1999 14:00:56 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA04000
	for <linuxmips@oss.sgi.com>; Wed, 24 Nov 1999 14:07:14 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA29756
	for linux-list;
	Wed, 24 Nov 1999 11:43:46 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [150.166.49.50])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA39827;
	Wed, 24 Nov 1999 11:43:40 -0800 (PST)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: (from ulfc@localhost)
	by calypso.engr.sgi.com (8.9.3/8.8.7) id LAA00980;
	Wed, 24 Nov 1999 11:43:30 -0800
Date:   Wed, 24 Nov 1999 11:43:30 -0800
From:   Ulf Carlsson <ulfc@cthulhu.engr.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: kgdb support
Message-ID: <19991124114330.F30786@engr.sgi.com>
References: <99112412134700.03259@jharrell_dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <99112412134700.03259@jharrell_dt>; from Jeff Harrell on Wed, Nov 24, 1999 at 12:00:56PM -0700
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Nov 24, 1999 at 12:00:56PM -0700, Jeff Harrell wrote:
> In the process of looking through the MIPS/Linux code base,  I noticed that
> the kgdb interface seems to support the ZS85C30  (see the function
> rs_kgdb_hook) but do not see where the generic serial interface (i.e.
> /drivers/char/serial.c) is supported.  Is the kgdb support provided through
> the file gdb-stub.c? Any help would be greatly appreciated.

The kgdb that comes from ftp.gcom.com:/pub/linux/src provides support for normal
serial ports if that's what you're looking for.  You may be able to use that
serial driver with the gdb-stub.c that we have in arch/mips/kernel provided
enough time to get the things together.  What are you trying to do?

Ulf
