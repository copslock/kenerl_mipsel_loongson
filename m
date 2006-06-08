Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2006 11:14:39 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:27603 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133417AbWFHKOa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2006 11:14:30 +0100
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id C3CA845DF1; Thu,  8 Jun 2006 12:14:03 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FoHWB-0007KK-AN; Thu, 08 Jun 2006 11:13:35 +0100
Date:	Thu, 8 Jun 2006 11:13:35 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Kernel binary size changes in dependence of the gcc version
Message-ID: <20060608101335.GA22883@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

I wondered how the various gcc versions influence the size of the
kernel binary, and what difference a size-optimised build makes.

The appended overview is for a Broadcom/Sibyte kernel with some
amount of drivers built in, so the absolute numbers aren't that
relevant. The configuration was always the same except for
CONFIG_64BIT and CONFIG_CC_OPTIMIZE_FOR_SIZE.


Thiemo


32 bit:
-------

Kernel 2.6.17-rc5 Sibyte SWARM 32 bit, default compiler options:

   text	   data	    bss	    dec	    hex	filename
3500246	 319636	 172080	3991962	 3ce99a	vmlinux   # gcc-3.3 (3.3.6-13)
3440510	 291012	 172080	3903602	 3b9072 vmlinux   # gcc-3.4 (3.4.6-1)
3482825	 291140	 172080	3946045	 3c363d vmlinux   # gcc-4.0 (4.0.3-3)
3452750	 288164	 172080	3912994	 3bb522 vmlinux   # gcc-4.1 (4.1.0-4)
3455566	 288164	 172080	3915810	 3bc022 vmlinux   # gcc-snapshot (20060530-1)


Kernel 2.6.17-rc5 Sibyte SWARM 32 bit, size optimized build:

   text	   data	    bss	    dec	    hex	filename
3423398	 319636	 172080	3915114	 3bbd6a	vmlinux   # gcc-3.3 (3.3.6-13)
3224502	 291012	 172080	3687594	 3844aa	vmlinux   # gcc-3.4 (3.4.6-1)

Newer gcc versions fail to build the 2.6.17-rc5 32 bit kernel with 
-Os due to unresolved references to libgcc. With a kernel patch
providing libgcc functions, and a 2.6.17-rc6 snapshot:

   text	   data	    bss	    dec	    hex	filename
3415310	 319620	 172080	3907010	 3b9dc2	vmlinux   # gcc-3.3 (3.3.6-13)
3215829	 290996	 172080	3678905	 3822b9	vmlinux   # gcc-3.4 (3.4.6-1)
3175683	 290404	 172080	3638167	 378397	vmlinux   # gcc-4.0 (4.0.3-3)
3184250	 287348	 172080	3643678	 37991e	vmlinux   # gcc-4.1 (4.1.0-4)
3198118	 287348	 172080	3657546	 37cf4a	vmlinux   # gcc-snapshot (20060530-1)


64 bit:
-------

The difference in size from gcc-3.4 to gcc-4.0 for 64 bit kernels is to
a large part caused by the use of -msym32, which is only available
since gcc-4.0.

Kernel 2.6.17-rc5 Sibyte SWARM 64 bit, default compiler options:

   text	   data	    bss	    dec	    hex	filename
4240626	 506688	 258096	5005410	 4c6062	vmlinux   # gcc-3.3 (3.3.6-13)
4183387	 469024	 258096	4910507	 4aedab	vmlinux   # gcc-3.4 (3.4.6-1)
3740658	 469272	 258096	4468026	 442d3a	vmlinux   # gcc-4.0 (4.0.3-3)
3701722	 463904	 258096	4423722	 43802a	vmlinux   # gcc-4.1 (4.1.0-4)
3703474	 463904	 258096	4425474	 438702	vmlinux   # gcc-snapshot (20060530-1)


Kernel 2.6.17-rc5 Sibyte SWARM 64 bit, size optimized build:

   text	   data	    bss	    dec	    hex	filename
4110677	 506688	 258096	4875461	 4a64c5	vmlinux   # gcc-3.3 (3.3.6-13)
3912126	 469024	 258096	4639246	 46ca0e	vmlinux   # gcc-3.4 (3.4.6-1)
3384418	 468248	 258096	4110762	 3eb9aa	vmlinux   # gcc-4.0 (4.0.3-3)
3389841	 462880	 258096	4110817	 3eb9e1	vmlinux   # gcc-4.1 (4.1.0-4)
3401534	 462880	 258096	4122510	 3ee78e	vmlinux   # gcc-snapshot (20060530-1)
