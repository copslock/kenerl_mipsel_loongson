Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 00:48:44 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:1555 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224917AbUJDXsj>; Tue, 5 Oct 2004 00:48:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 23804F596D; Tue,  5 Oct 2004 01:48:32 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22441-02; Tue,  5 Oct 2004 01:48:32 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B8197F596B; Tue,  5 Oct 2004 01:48:31 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i94NmoFY016583;
	Tue, 5 Oct 2004 01:48:50 +0200
Date: Tue, 5 Oct 2004 00:48:37 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
In-Reply-To: <20041004145244.GB8198@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0410050044510.14763@blysk.ds.pg.gda.pl>
References: <4152D58B.608@longlandclan.hopto.org> <20040923154855.GA2550@paradigm.rfc822.org>
 <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de>
 <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.LNX.4.58L.0410022213140.18388@blysk.ds.pg.gda.pl>
 <20041004145244.GB8198@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 4 Oct 2004, Ralf Baechle wrote:

> >  I think we should either handcode all handlers explicitly or build a
> > single one dynamically, like we do for copy_page()/clear_page().
> 
> That was the plan.
> 
> > For now,
> > I'll just add the missing nop directly to the handlers.  Thanks for 
> > working on it.
> 
> Those nops are now cluttering the handler for all those processors
> that don't need it.  Great.

 Except that:

1. The handler is expected to be for R4000/R4400 only.  If it's used for
   anything else, that it's the anything else's maintainer fault.

2. The except_vec0_sb1 handler is one with the nop omitted, so it can be
   used for these processors.

3. Correct operation first, only then optimization.

4. Anyone please feel free to do a better fix.

5. Given the "gran plan" as referred to above, points 1 - 4 above are
   probably irrelevant anyway. ;-)

  Maciej
