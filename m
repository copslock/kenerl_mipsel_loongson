Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2005 14:53:26 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:55309 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224922AbVBOOxL>; Tue, 15 Feb 2005 14:53:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 139D7F5974; Tue, 15 Feb 2005 15:53:00 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15444-08; Tue, 15 Feb 2005 15:52:59 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DF517E1D10; Tue, 15 Feb 2005 15:52:59 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1FEr2tU011526;
	Tue, 15 Feb 2005 15:53:02 +0100
Date:	Tue, 15 Feb 2005 14:53:10 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Peter 'p2' De Schrijver" <p2@mind.be>
Cc:	linux-mips@linux-mips.org
Subject: Re: turbo channel drivers for 2.6
In-Reply-To: <20050215010448.GP3448@mind.be>
Message-ID: <Pine.LNX.4.61L.0502151444150.10988@blysk.ds.pg.gda.pl>
References: <20050215010448.GP3448@mind.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 15 Feb 2005, Peter 'p2' De Schrijver wrote:

> Is there anyone working on a turbo channel driver for 2.6 ? I have 2.4

 I am, halfheartedly.  Have you seen James Simmons's work?

> running on the DEC 3000 (turbo channel alpha machine). I want to get 2.6
> to work and it would make sense to share the turbo channel part with
> other platforms (mipsel, vax).

 That's the only reasonable way of doing it.  It should also permit easy 
support for multi-bus peripheral device drivers, namely for:
DEFTA/DEFEA/DEFPA, PMAGD/PBXGA and DGLTA/DGLPB.

  Maciej
