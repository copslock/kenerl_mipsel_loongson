Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 22:05:10 +0100 (BST)
Received: from p508B6582.dip.t-dialin.net ([IPv6:::ffff:80.139.101.130]:26499
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbTDCVFJ>; Thu, 3 Apr 2003 22:05:09 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h33L4p710586;
	Thu, 3 Apr 2003 23:04:51 +0200
Date: Thu, 3 Apr 2003 23:04:51 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Madhavi <madhavis@sasken.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Relocation overflow problem with MIPS
Message-ID: <20030403230451.A6583@linux-mips.org>
References: <Pine.LNX.4.33.0304031124100.24014-100000@pcz-madhavis.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0304031124100.24014-100000@pcz-madhavis.sasken.com>; from madhavis@sasken.com on Thu, Apr 03, 2003 at 11:25:28AM +0530
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 03, 2003 at 11:25:28AM +0530, Madhavi wrote:

> I am working on a device driver software for linux kernel version 2.4.19.
> My driver is a loadable module and the size of the module executable is
> approximately 1.4MB.
> 
> When I tried to load this module on x86, I didn't have any problems while
> installing it. On MIPS (R5432) CPU, this is giving the following problems:
> 
> edge_mod.o: Relocation overflow of type 4 for printk

[...]

You must use the same flag to compile modules as the kernel's Makefile.
In particular you were missing -mlong-calls.

> Could anyone tell me what this problem could be? What is relocation
> overflow of type 4? Where can I find the list of all the possible
> relocation overflow types and their descriptions?

Read the source ...

> My module is not compiled using the options -fPIC. Would it make any
> difference if I enable this option?
> 
> I have seen this following comment in modutils-2.4.12/obj/obj_mips.c
> 
> /* _gp_disp is a magic symbol for PIC which is not supported for
>    the kernel and loadable modules.  */
> 
> So, I was thinking that -fPIC wouldn't help much. Am I right?

-fPIC is the compiler default.

> Sasken Business Disclaimer

[legal bullshit disclaimer burried in /dev/zero]

  Ralf
