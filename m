Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 16:56:21 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:21777 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225202AbUJUP4Q>; Thu, 21 Oct 2004 16:56:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7D0B6F5A14; Thu, 21 Oct 2004 17:56:10 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24609-08; Thu, 21 Oct 2004 17:56:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 46373E1CA8; Thu, 21 Oct 2004 17:56:10 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id i9LFuLTZ018498;
	Thu, 21 Oct 2004 17:56:21 +0200
Date: Thu, 21 Oct 2004 16:56:13 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Koeller <thomas.koeller@baslerweb.com>,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20041021130316.GA26440@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0410211652020.29667@blysk.ds.pg.gda.pl>
References: <20041020023431Z98555-1751+175@linux-mips.org>
 <200410201858.40582.thomas.koeller@baslerweb.com>
 <200410211119.50747.thomas.koeller@baslerweb.com> <20041021130316.GA26440@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/538/Tue Oct 19 12:04:13 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 21 Oct 2004, Ralf Baechle wrote:

> > I have been consulting with PMC-Sierra and received confirmation that
> > the problems described under errata items 2.15 and 2.16 still exist
> > with rev. 1.2 silicon.
> 
> Linux does not use Hit_Writeback_D and Hit_Writeback_SD so these can't

 Yet?

> possible be a problem.

 Now.  Though the issue can only be revisited once the situation changes, 
indeed.

  Maciej
