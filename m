Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2004 03:20:09 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:41740 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225367AbUJOCUC>; Fri, 15 Oct 2004 03:20:02 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DBEDFE1CBF; Fri, 15 Oct 2004 04:19:56 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30285-01; Fri, 15 Oct 2004 04:19:56 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 69FE8E1CB5; Fri, 15 Oct 2004 04:19:56 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9F2JtFv012492;
	Fri, 15 Oct 2004 04:19:55 +0200
Date: Fri, 15 Oct 2004 03:19:55 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Manish Lachwani <mlachwani@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
In-Reply-To: <20041014225553.GA13597@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0410150311370.25607@blysk.ds.pg.gda.pl>
References: <416DE31E.90509@mvista.com> <20041014191754.GB30516@linux-mips.org>
 <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl> <416EFBAB.8050600@mvista.com>
 <Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl>
 <20041014225553.GA13597@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 15 Oct 2004, Ralf Baechle wrote:

> Sure, go ahead.  This btw should match with the pci_controller definition
> which is looking fishy also.

 Tough.  Both the PCI memory and the PCI I/O spaces are mapped in several
areas, depending on the byte lane swapping policy needed and whether
64-bit addressing is feasible or not.  We'd need two areas for I/O and
four for memory (plus another one for the 40-bit HT address space).

  Maciej
