Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA75231 for <linux-archive@neteng.engr.sgi.com>; Wed, 19 Aug 1998 17:59:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA14530
	for linux-list;
	Wed, 19 Aug 1998 17:58:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA84158;
	Wed, 19 Aug 1998 17:58:31 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de ([141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA05020; Wed, 19 Aug 1998 17:58:29 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-16.uni-koblenz.de [141.26.249.16])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA11711;
	Thu, 20 Aug 1998 02:58:27 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA00803;
	Thu, 20 Aug 1998 02:13:22 +0200
Message-ID: <19980820021322.C388@uni-koblenz.de>
Date: Thu, 20 Aug 1998 02:13:22 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Ulf Carlsson <grim@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: bus error IRQ
References: <199808171845.UAA29545@calypso.saturn> <19980818021316.J3345@uni-koblenz.de> <199808190231.TAA27036@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199808190231.TAA27036@fir.engr.sgi.com>; from William J. Earl on Tue, Aug 18, 1998 at 07:31:05PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Aug 18, 1998 at 07:31:05PM -0700, William J. Earl wrote:

> ralf@uni-koblenz.de writes:
> ...
>  > The bad thing with a bus error is that it may be delayed for a very long
>  > time thus resulting in a useless program counter.  What happens is that
>  > the CPU writes to some invalid address but the write access over the
>  > system bus is delayed because the writeback cache policy is being used.
>  > Later, maybe even much later, when the cacheline gets written back to
>  > memory for some reason the system board signals a bus error interrupt.
>  > At this point the program counter may already be completly useless.
> ...
> 
>      You cannot get a delayed bus error on a cached write, unless
> you do a "create dirty exclusive" cache operation to validate the line
> before writing.

Linux uses Create_Dirty_Excl_D as optimization where possible, so the
probability for this to happen is relativly high.  Linux however should
never use Create_Dirty_Excl_D or Create_Dirty_Excl_SD on R4[04]00SC
CPUs, have to verify this.

>                  You can get delayed bus errors on uncached writes,
> as to device control registers.  Since any K1SEG address is uncached,
> it is not too hard to generate a bus error with a bad pointer value.

  Ralf
