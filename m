Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id PAA48255 for <linux-archive@neteng.engr.sgi.com>; Thu, 19 Feb 1998 15:26:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA03533 for linux-list; Thu, 19 Feb 1998 15:25:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA03519 for <linux@engr.sgi.com>; Thu, 19 Feb 1998 15:25:03 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA03754
	for <linux@engr.sgi.com>; Thu, 19 Feb 1998 15:25:01 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-26.uni-koblenz.de [141.26.249.26])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA25538
	for <linux@engr.sgi.com>; Fri, 20 Feb 1998 00:24:58 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA10525;
	Thu, 19 Feb 1998 00:47:50 +0100
Message-ID: <19980219004750.26917@uni-koblenz.de>
Date: Thu, 19 Feb 1998 00:47:50 +0100
To: Tatsuya Nakamura <tatsuya@na.kubota.co.jp>
Cc: linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Subject: Re: Is Magnum 4000 supported?
References: <19980218095700L.tatsuya@na.kubota.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <19980218095700L.tatsuya@na.kubota.co.jp>; from Tatsuya Nakamura on Wed, Feb 18, 1998 at 09:57:00AM +0900
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Feb 18, 1998 at 09:57:00AM +0900, Tatsuya Nakamura wrote:

> I try to use of Linux/MIPS on MIPS Magnum 4000 system.
> 
> I tried some versions kernel, and some configuration.
> 
> But, 2.1.XX kernel didn't show some message to console.
> The 2.0.21 kernel could show message to console, but it didn't work
> fine.
> 
> 2.0.21 kernel stopped after ethernet information displaing,
> and appear this message:
> 
> Unable to handle kernel paging request at virtual address 00000004, epc == ffffffff8005ac5c
> $0: ........
> 
> MIPS Magnum 4000 system does not tested?

The development is actually being done by somebody who's using an OEM
version of the Magnum 4000, the Olivetti M700-10.  But that machine is
99.9% identical.

Question: do you know if you have a Magnum 4000SC?  The SC CPU version is
quite a bit faster but the support for it is broken in the kernels you've
tested.

What resolution is you machine running at?  Milo and the kernel only support
the lowres mode (1024 x 768).

  Ralf
