Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2003 15:45:45 +0000 (GMT)
Received: from mail.convergence.de ([IPv6:::ffff:212.84.236.4]:30700 "EHLO
	mail.convergence.de") by linux-mips.org with ESMTP
	id <S8225419AbTKKPpd>; Tue, 11 Nov 2003 15:45:33 +0000
Received: from [10.1.1.146] (helo=heck)
	by mail.convergence.de with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.14)
	id 1AJaeo-0005NY-7r
	for linux-mips@linux-mips.org; Tue, 11 Nov 2003 16:42:18 +0100
Received: from js by heck with local (Exim 3.35 #1 (Debian))
	id 1AJahm-0003Y0-00
	for <linux-mips@linux-mips.org>; Tue, 11 Nov 2003 16:45:22 +0100
Date: Tue, 11 Nov 2003 16:45:21 +0100
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: Re: random kernel panics with 2.4.22 running on VR4120A
Message-ID: <20031111154521.GA11931@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@linux-mips.org
References: <20031024151325.GB22979@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031024151325.GB22979@convergence.de>
User-Agent: Mutt/1.5.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

I wrote:
> 
> After the 2.4.22 merge in linux-mips.org CVS I updated our kernel,
> from 2.4.21-2003-07-08 to 2.4.22-2003-09-24, and now we are getting
> occational kernel panics at random places, either one of:
> 
>   Unhandled kernel unaligned access in unaligned.c::emulate_load_store_insn, line 481:
>   Kernel unaligned instruction access in unaligned.c::do_ade, line 550:
> 
> It happens about once per day on a box wich continously runs
> a test suite, and rather seldom on other boxes.

I've updated to 2.4.22-2003-10-27, and the test suite ran
for about a week now: The problem seems to be solved.

Johannes
