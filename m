Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 13:06:36 +0000 (GMT)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:52632 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8225316AbUATNGf>;
	Tue, 20 Jan 2004 13:06:35 +0000
Received: from rekin.icm.edu.pl (rekin.icm.edu.pl [192.168.1.132])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.6/icm) with ESMTP id i0KD6NCM000049
	for <linux-mips@linux-mips.org>; Tue, 20 Jan 2004 14:06:23 +0100 (CET)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1AivaM-0006gv-00
	for <linux-mips@linux-mips.org>; Tue, 20 Jan 2004 14:06:26 +0100
Date: Tue, 20 Jan 2004 14:06:26 +0100
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: Current 2.4 CVS (2.4.24-pre2) doesn't boot on SGI Indy
Message-ID: <20040120130625.GA24435@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040115141427.GA28546@icm.edu.pl> <Pine.LNX.4.21.0401151816540.3511-100000@www.marty44.net> <20040115231735.GA6619@icm.edu.pl> <4007386F.80207@gentoo.org> <20040115172602.H18368@mvista.com> <20040116115053.GA18099@icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116115053.GA18099@icm.edu.pl>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Fri, Jan 16, 2004 at 12:50:53PM +0100, Dominik 'Rathann' Mierzejewski wrote:
> On Thu, Jan 15, 2004 at 05:26:02PM -0800, Jun Sun wrote:
> > On Thu, Jan 15, 2004 at 08:03:43PM -0500, Kumba wrote:
> > > Dominik 'Rathann' Mierzejewski wrote:
> [...] 
> > > I have a 2.4.23 kernel I used from a 20031128 CVS snapshot that works 
> > > fine, but a 2.4.23 20031214 snapshot didn't work (on an R4400@250MHz 
> > > I2), so likely the problem was introduced sometime between those dates. 
> > >   Might help for tracking down the issue.
> 
> Thanks, that'll be useful.

OK, I've narrowed it down to sometime between 20031205 and 20031214, but
since there were no commits between 20031204 and 20031211, it has to be one
of these:

6242 2003/12/11 01:29:17 linux_2_4 ralf Fix a bunch of long standing bugs and performance clear_page issues: - Fi .....
6244 2003/12/11 15:36:14 linux_2_4 macro Remove a superfluous initializer.
6245 2003/12/11 15:41:09 linux_2_4 macro Conditionalize console ioctls appropriately.
6246 2003/12/11 16:06:48 linux_2_4 macro Initrd support for DECstations; by Thiemo Seufer.
6248 2003/12/11 16:07:24 linux_2_4 ladis PI1 parport update: * don't intialize twice when compiled in * place P .....
6250 2003/12/11 16:25:43 linux_2_4 macro Force the 4kB page size for processors that do not support other sizes. D .....
6252 2003/12/11 16:39:41 linux_2_4 macro Formatting fixes plus an error code correction; by Thiemo Seufer.
6254 2003/12/11 20:47:12 linux_2_4 ralf Fix a bunch of long standing bugs and performance copy_page issues: - Fix .....
6256 2003/12/11 21:07:56 linux_2_4 ralf Three basically identical copies of pgd_init are 2.0 too much ...
6257 2003/12/11 21:25:25 linux_2_4 ralf pg-r3k.c has become just the trivial case of pg-r4k.c so zap it.
6258 2003/12/11 22:57:23 linux_2_4 ralf Fix stupid dependency ...
6259 2003/12/11 22:59:09 linux_2_4 ralf Rebuild.
6262 2003/12/13 05:03:21 linux_2_4 ralf semaphore.o is an exporting object.
6263 2003/12/13 05:33:38 linux_2_4 ralf Add sound ioctls.

Still searching...

Cheers,

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>                                                 
Interdisciplinary Centre for Mathematical and Computational Modelling                               
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810                               
