Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2004 16:42:18 +0000 (GMT)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:8030 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8224991AbUBLQmS>;
	Thu, 12 Feb 2004 16:42:18 +0000
Received: from rekin.icm.edu.pl (rekin.icm.edu.pl [192.168.1.132])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.6/icm) with ESMTP id i1CGg5dL026629
	for <linux-mips@linux-mips.org>; Thu, 12 Feb 2004 17:42:05 +0100 (CET)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1ArJuf-00021a-00
	for <linux-mips@linux-mips.org>; Thu, 12 Feb 2004 17:42:05 +0100
Date: Thu, 12 Feb 2004 17:42:05 +0100
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: indy r4000FPC kernel?
Message-ID: <20040212164204.GC7586@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <Pine.LNX.4.58.0402121652410.24037@brilsmurf.chem.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402121652410.24037@brilsmurf.chem.tue.nl>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Thu, Feb 12, 2004 at 05:12:58PM +0100, Joost wrote:
> Hello,
> 
> Is this the correct list to be asking about kernel trouble?
> If not, i apologize for this lengthy piece of offtopic ranting :-)
> 
>   I'm trying to get a working kernel on my indy, but 2.4.16
> seems to be as far as it will go. The 2.4.22 that comes with
> debian testing gives an error while booting so i decided
> to try and be adventurous and downloaded the 2.6 sources
> via cvs. The PROM in this beast is old i gues, it won't
> boot elf kernels, so i used the 'ecoff' tip on linux-mips.com.

Get a current version (branch linux_2_4) from linux-mips.org's CVS
and try that one. There have been some trouble with r4k processors
lately, but they seem to be resolved now. I'm running 2.4.25-pre6
at the moment. Oh, and use arcboot - it saves a lot of hassle.
You don't have to upload your kernel to volume header and you can
boot any ELF kernel image that is on any ext2/3 partition on your
system.

HTH

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>                                                 
Interdisciplinary Centre for Mathematical and Computational Modelling                               
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810                               
