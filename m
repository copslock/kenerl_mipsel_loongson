Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 19:02:16 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:42765 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022694AbXFGSCO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 19:02:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 73627E1D38;
	Thu,  7 Jun 2007 20:01:27 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sg3-9mJPEz2Z; Thu,  7 Jun 2007 20:01:27 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 13386E1C6B;
	Thu,  7 Jun 2007 20:01:27 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l57I1fG4032689;
	Thu, 7 Jun 2007 20:01:41 +0200
Date:	Thu, 7 Jun 2007 19:01:36 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] No I/O ports on the DECstation
In-Reply-To: <20070607174749.GB1893@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0706071859290.18949@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0705291505370.14456@blysk.ds.pg.gda.pl>
 <20070531121521.GE28936@linux-mips.org> <Pine.LNX.4.64N.0705311359250.7856@blysk.ds.pg.gda.pl>
 <20070607174749.GB1893@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3376/Thu Jun  7 10:39:26 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Jun 2007, Ralf Baechle wrote:

> Git is pickier than patch.  Anything that will still be applied by patch
> with a fuzz will be rejected by git-apply.  For good reason, I several
> times ended with a corrupt tree thanks to patch happily (miss-)applying
> some stale patch with fuzz.  Heck, it hit akpm recently ...

 I see -- I'll regenerate patches if they are fuzzy then.  Thanks.

  Maciej
