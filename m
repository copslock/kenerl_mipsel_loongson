Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 17:08:34 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:53765 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226119AbVDKQIS>; Mon, 11 Apr 2005 17:08:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 177B8E1C65; Mon, 11 Apr 2005 18:07:52 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03652-07; Mon, 11 Apr 2005 18:07:51 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D2C59E1C63; Mon, 11 Apr 2005 18:07:51 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j3BG7tFr014699;
	Mon, 11 Apr 2005 18:07:55 +0200
Date:	Mon, 11 Apr 2005 17:08:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Laird <danieljlaird@hotmail.com>
Cc:	libc-alpha@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
In-Reply-To: <BAY101-F54440B7BD61E4D879501FDC320@phx.gbl>
Message-ID: <Pine.LNX.4.61L.0504111659410.31547@blysk.ds.pg.gda.pl>
References: <BAY101-F54440B7BD61E4D879501FDC320@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 11 Apr 2005, Daniel Laird wrote:

> I am trying to build glibc-2.3.4 (gcc-3.4.3, binutils-2.15.96) with
> linux-2.6.11.6 on mips.

 You may consider glibc 2.3.5.

> I am having problems with bits/syscalls.h whereas yours seem to be empty mine
> just does not exist???

 Can I ask you which package are you specifically referring to?  Perhaps 
you've picked an outdated one.

> Any reason for this?
> I have applied your patches but they do not seem to correct this error have
> you seen this.

 There used to be problems with <bits/syscalls.h> generation, which, 
depending on the exact version of Linux headers supplied, could be 
triggered or not.  They are supposed to be fixed in 2.3.5 (credit goes 
to Richard Sandiford).

  Maciej
