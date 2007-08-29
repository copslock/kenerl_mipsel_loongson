Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 13:04:50 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:30927 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022214AbXH2MEl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 13:04:41 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 1733F400C7;
	Wed, 29 Aug 2007 14:04:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id eeLwtfcHE-oC; Wed, 29 Aug 2007 14:04:34 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 311B1400C4;
	Wed, 29 Aug 2007 14:04:34 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l7TC4bvZ027575;
	Wed, 29 Aug 2007 14:04:37 +0200
Date:	Wed, 29 Aug 2007 13:04:33 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	bo y <byu1000@gmail.com>
cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: tlbex.c
In-Reply-To: <99ac6e0e0708270822w32f8a024gd18c5883c86c8713@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0708291302350.26167@blysk.ds.pg.gda.pl>
References: <99ac6e0e0708270822w32f8a024gd18c5883c86c8713@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4100/Wed Aug 29 10:32:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 27 Aug 2007, bo y wrote:

> Should the following instruction field masks to be 0x3f ?
> 
>    #define OP_MASK         0x2f
>    #define FUNC_MASK       0x2f
> 
> I do not see OP_MASK is used but FUNC_MASK is used in the same file.

 Yes.  Send a patch.

  Maciej
