Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA506868 for <linux-archive@neteng.engr.sgi.com>; Fri, 14 Nov 1997 14:08:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA03214 for linux-list; Fri, 14 Nov 1997 14:05:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA03142; Fri, 14 Nov 1997 14:04:55 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA11639; Fri, 14 Nov 1997 14:04:52 -0800
	env-from (ralf@hotel.uni-koblenz.de)
Received: from hotel.uni-koblenz.de (ralf@pmport-08.uni-koblenz.de [141.26.249.8])
	by informatik.uni-koblenz.de (8.8.8/8.8.7) with ESMTP id XAA05565;
	Fri, 14 Nov 1997 23:04:50 +0100 (MET)
Received: (from ralf@localhost)
	by hotel.uni-koblenz.de (8.8.7/8.8.7) id XAA09889;
	Fri, 14 Nov 1997 23:01:26 +0100
Message-ID: <19971114230125.53286@hotel.uni-koblenz.de>
Date: Fri, 14 Nov 1997 23:01:25 +0100
From: ralf@uni-koblenz.de
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>
Cc: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: Pentium F00F bug Linux workaround
References: <199711142117.NAA27890@oz.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <199711142117.NAA27890@oz.engr.sgi.com>; from Ariel Faigon on Fri, Nov 14, 1997 at 01:17:24PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Nov 14, 1997 at 01:17:24PM -0800, Ariel Faigon wrote:
> [Just forwarding from linux-dev since I thought some people
>  may be interested.  Ingo Molnar has found a way to workaround
>  the latest Pentium/Pentium-MMX F00F bug. Linus then improved on it.
> 
>  I'm impressed by the repeatedly demonstrated ability of the Linux
>  community to beat Microsoft.  It remains to be seen how long it'll
>  take Microsoft to respond to this serious bug that can crash any
>  Windows/WindowsNT machine from user mode (incl. any remotely loaded
>  Captive-X control)]

The Linux kernel as well handles a CPU bug that QED / IDT still haven't
acknowledged to exist :-)

  Ralf
