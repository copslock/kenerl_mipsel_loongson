Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id DAA316178 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Dec 1997 03:44:01 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA03236 for linux-list; Wed, 17 Dec 1997 03:42:54 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA03223 for <linux@engr.sgi.com>; Wed, 17 Dec 1997 03:42:47 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA06736
	for <linux@engr.sgi.com>; Wed, 17 Dec 1997 03:42:45 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id MAA06449;
	Wed, 17 Dec 1997 12:42:04 +0100 (MET)
Received: by zaphod (SMI-8.6/KO-2.0)
	id MAA15743; Wed, 17 Dec 1997 12:42:03 +0100
Message-ID: <19971217124202.65461@zaphod.uni-koblenz.de>
Date: Wed, 17 Dec 1997 12:42:02 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Michael Elizabeth Chastain <mec@shout.net>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: Re: Trivial patch: arch/mips/config.in
References: <199712171053.EAA11267@duracef.shout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <199712171053.EAA11267@duracef.shout.net>; from Michael Elizabeth Chastain on Wed, Dec 17, 1997 at 04:53:56AM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Dec 17, 1997 at 04:53:56AM -0600, Michael Elizabeth Chastain wrote:
> Hello MIPS hackers,
> 
> I'm working on Menuconfig and I found that arch/mips/config.in has
> a trivial syntax error.  Here is a patch.
> 
> I don't read this list so please send copies of any replies to me.

Thanks, applied.

  Ralf

> diff -u -r -N linux-2.1.72/arch/mips/config.in linux/arch/mips/config.in
> --- linux-2.1.72/arch/mips/config.in	Tue Dec  2 13:41:44 1997
> +++ linux/arch/mips/config.in	Wed Dec 17 04:46:38 1997
> @@ -97,6 +97,7 @@
>    bool 'Set version information on all symbols for modules' CONFIG_MODVERSIONS
>    bool 'Kernel daemon support (e.g. autoload of modules)' CONFIG_KERNELD
>  fi
> +endmenu
>  
>  source drivers/block/Config.in
>  

-- 
Uni Koblenz live:

[...]
4 bytes from kernel.panic.julia.de (194.221.49.153): icmp_seq=55. time=18530. ms
64 bytes from kernel.panic.julia.de (194.221.49.153): icmp_seq=56. time=17534. ms
64 bytes from kernel.panic.julia.de (194.221.49.153): icmp_seq=57. time=16542. ms
64 bytes from kernel.panic.julia.de (194.221.49.153): icmp_seq=59. time=14556. ms
64 bytes from kernel.panic.julia.de (194.221.49.153): icmp_seq=60. time=13559. ms
64 bytes from kernel.panic.julia.de (194.221.49.153): icmp_seq=61. time=12562. ms
64 bytes from kernel.panic.julia.de (194.221.49.153): icmp_seq=63. time=10565. ms
[...]
----194.221.xx.xx PING Statistics----
80 packets transmitted, 40 packets received, 50% packet loss
round-trip (ms)  min/avg/max = 4145/35740/70823
