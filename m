Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA99159 for <linux-archive@neteng.engr.sgi.com>; Tue, 18 Aug 1998 19:34:01 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA66546
	for linux-list;
	Tue, 18 Aug 1998 19:31:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id TAA58988;
	Tue, 18 Aug 1998 19:31:36 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id TAA27036; Tue, 18 Aug 1998 19:31:05 -0700
Date: Tue, 18 Aug 1998 19:31:05 -0700
Message-Id: <199808190231.TAA27036@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: Ulf Carlsson <grim@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: bus error IRQ
In-Reply-To: <19980818021316.J3345@uni-koblenz.de>
References: <199808171845.UAA29545@calypso.saturn>
	<19980818021316.J3345@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > The bad thing with a bus error is that it may be delayed for a very long
 > time thus resulting in a useless program counter.  What happens is that
 > the CPU writes to some invalid address but the write access over the
 > system bus is delayed because the writeback cache policy is being used.
 > Later, maybe even much later, when the cacheline gets written back to
 > memory for some reason the system board signals a bus error interrupt.
 > At this point the program counter may already be completly useless.
...

     You cannot get a delayed bus error on a cached write, unless
you do a "create dirty exclusive" cache operation to validate the line
before writing.  You can get delayed bus errors on uncached writes,
as to device control registers.  Since any K1SEG address is uncached,
it is not too hard to generate a bus error with a bad pointer value.
