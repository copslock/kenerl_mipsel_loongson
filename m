Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2002 16:06:47 +0100 (CET)
Received: from p508B539B.dip.t-dialin.net ([80.139.83.155]:64235 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122117AbSJ3PGr>; Wed, 30 Oct 2002 16:06:47 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g9UF65D19951;
	Wed, 30 Oct 2002 16:06:05 +0100
Date: Wed, 30 Oct 2002 16:06:04 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Recent Kernel Page Fault Problems Spawning Init?
Message-ID: <20021030160604.A19907@linux-mips.org>
References: <CBD6266EA291D5118144009027AA63353F9412@xboi05.boi.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <CBD6266EA291D5118144009027AA63353F9412@xboi05.boi.hp.com>; from roger_twede@hp.com on Tue, Oct 29, 2002 at 05:53:15PM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 29, 2002 at 05:53:15PM -0500, TWEDE,ROGER (HP-Boise,ex1) wrote:

> I would be appreciative of any advice anyone can offer in this regard.
> 
> Were any fundamental kernel changes made in the 2.4.17 through 2.4.19
> timeframe which could explain why the spawning of init would hang?
> 
> After mounting a root filesystem and attempting to spawn init, 3 or 4 page
> faults occur.  The entry point of init, its bss section and an elf loader
> .text section get hit, etc.  followed by an endless series of page faults to
> a bad address which just faults repeatedly, never allowing init or the elf
> loader to proceed.
> 
> I've tried a RM 7000A and 20KC based boards so far with apparently identical
> behavior on both.

Various people have reported this kind of problem in past but so far all of
them turned out some local problem.  20kc and RM7000 are both supposed to be
working fine.

  Ralf
