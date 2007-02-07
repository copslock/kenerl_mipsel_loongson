Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2007 17:29:46 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:7442 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039477AbXBGR3k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Feb 2007 17:29:40 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E2792E1C93;
	Wed,  7 Feb 2007 18:28:54 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4OVi1UOsEhaO; Wed,  7 Feb 2007 18:28:54 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 89EE7F5943;
	Wed,  7 Feb 2007 18:28:54 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l17HT75s000440;
	Wed, 7 Feb 2007 18:29:07 +0100
Date:	Wed, 7 Feb 2007 17:29:02 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
In-Reply-To: <20070208.012216.103777705.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0702071725150.9744@blysk.ds.pg.gda.pl>
References: <S20038814AbXBEQMb/20070205161231Z+24864@ftp.linux-mips.org>
 <20070207.133809.71085888.nemoto@toshiba-tops.co.jp> <20070207110929.GA17660@linux-mips.org>
 <20070208.012216.103777705.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2533/Wed Feb  7 15:20:47 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 8 Feb 2007, Atsushi Nemoto wrote:

> If the format of FCSR was common to all CPU (I hope so), we can do
> check it in caller of fp_restore_context(), in C language.

 The R3010, etc. use bits 23 and 17:0 the same way as the R4000 and MIPS 
architecture processors do.  The other bits are unused and hardwired to 
zeroes.

  Maciej
