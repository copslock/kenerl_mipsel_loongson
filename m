Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA27329; Wed, 1 May 1996 08:45:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id IAA13207; Wed, 1 May 1996 08:45:27 -0700
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id IAA13199; Wed, 1 May 1996 08:45:26 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA27314 for <linux@neteng.engr.sgi.com>; Wed, 1 May 1996 08:45:25 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id IAA17255; Wed, 1 May 1996 08:45:24 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id IAA07701; Wed, 1 May 1996 08:44:55 -0700
Date: Wed, 1 May 1996 08:44:55 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199605011544.IAA07701@fir.esd.sgi.com>
To: Ralf Baechle <ralf@informatik.uni-koblenz.de>
Cc: ewt@redhat.com (Erik Troan), linux@neteng.engr.sgi.com
Subject: Re: scope of this mailing list
In-Reply-To: <199605010233.EAA26130@informatik.uni-koblenz.de>
References: <Pine.LNX.3.91.960429200526.3781C-100000@redhat.com>
	<199605010233.EAA26130@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
...
 > The main issue in achieving binary compatibility accross all Linux/MIPS
 > targets is the byte order.  For some machines (Mips Magnum 4000, Olivetti
 > M700-10, SNI RM series and others more) the byte order for the kernel is
 > configurable.  For other it is fixed.  This is often the case for machines
 > that were built with NT in mind.
 > 
 > The MIPS architecture offers us the nice feature of switchable byteorder
 > for usermode.  Thus we have a way to run software from other systems with
 > differing native byte order.  In other words: it's technological possible
 > but it's not implemented yet.
...

     I once worked on this problem on another OS base.  The basic system
calls are easy.  ioctls, especially for streams, were much harder.  Within
the limits of the published ABI, as opposed to the universe of working programs,
the task is not too difficult.
