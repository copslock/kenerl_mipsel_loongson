Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA102054 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Sep 1997 10:17:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA13782 for linux-list; Wed, 24 Sep 1997 10:17:15 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA13708 for <linux@engr.sgi.com>; Wed, 24 Sep 1997 10:16:59 -0700
Received: from cygint.cygnus.com (cygnus.com [205.180.230.20]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA13866
	for <linux@engr.sgi.com>; Wed, 24 Sep 1997 10:16:58 -0700
	env-from (drepper@cygnus.com)
Received: from localhost.cygnus.com (rtl.cygnus.com [205.180.230.21])
	by cygint.cygnus.com (8.8.5/8.8.7) with ESMTP id KAA16923;
	Wed, 24 Sep 1997 10:16:36 -0700 (PDT)
Message-Id: <199709241716.KAA16923@cygint.cygnus.com>
To: ralf@cobaltmicro.com
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: glibc 2.0.4 bug ...
In-Reply-To: Your message of "Wed, 24 Sep 1997 00:15:10 -0700 (PDT)"
References: <199709240715.AAA20896@dns.cobaltmicro.com>
X-Mailer: Mew version 1.06 on Emacs 19.34.1
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Date: Wed, 24 Sep 1997 10:16:35 -0700
From: Ulrich Drepper <drepper@cygnus.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

From: Ralf Baechle <ralf@cobaltmicro.com>
Subject: glibc 2.0.4 bug ...
Date: Wed, 24 Sep 1997 00:15:10 -0700 (PDT)

> Quickfix: add the following prototype for llseek(2):
> 
>   extern loff_t llseek (int fd, loff_t offset, int whence);

I've mentioned this several times: llseek is an internal function.
What we need is the LFS interface which then defines lseek64.

-- Uli
---------------.      drepper@cygnus.com  ,-.   Rubensstrasse 5
Ulrich Drepper  \    ,-------------------'   \  76149 Karlsruhe/Germany
Cygnus Solutions `--' drepper@gnu.ai.mit.edu  `------------------------
