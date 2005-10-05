Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 14:23:01 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:24079 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3465667AbVJENWq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 14:22:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D2752F596E; Wed,  5 Oct 2005 15:22:41 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21731-02; Wed,  5 Oct 2005 15:22:41 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 988DBE1D01; Wed,  5 Oct 2005 15:22:41 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j95DMhVJ003740;
	Wed, 5 Oct 2005 15:22:43 +0200
Date:	Wed, 5 Oct 2005 14:22:51 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for 4KS cpu.
In-Reply-To: <cda58cb80510042355r66d6b4b7k@mail.gmail.com>
Message-ID: <Pine.LNX.4.61L.0510051112390.13762@blysk.ds.pg.gda.pl>
References: <cda58cb80510040149p690397afo@mail.gmail.com> 
 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>  <434277D5.1090603@mips.com>
  <Pine.LNX.4.61L.0510041358300.10696@blysk.ds.pg.gda.pl>  <434289A7.50007@mips.com>
  <cda58cb80510040818v6d93fe53w@mail.gmail.com> 
 <Pine.LNX.4.61L.0510041651150.10696@blysk.ds.pg.gda.pl> 
 <cda58cb80510041033h2a67f072s@mail.gmail.com> <cda58cb80510042355r66d6b4b7k@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.86.2/1112/Wed Oct  5 11:04:38 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 5 Oct 2005, Franck wrote:

> Actually it would be better to let smartmips options in case we use
> fallback options:

 In which case the toolchain is not going to support the "-msmartmips" 
option anyway...  Perhaps you should just use the same options throughout 
as there is probably no sensible set of legacy options to fall back to.  

  Maciej
