Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 18:53:39 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:64521 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037874AbWIKRxe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Sep 2006 18:53:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A2C74F5C12;
	Mon, 11 Sep 2006 19:53:28 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnMKIFrmQnZz; Mon, 11 Sep 2006 19:53:28 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id EACFCF5BC9;
	Mon, 11 Sep 2006 19:53:27 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k8BHrYKm008659;
	Mon, 11 Sep 2006 19:53:35 +0200
Date:	Mon, 11 Sep 2006 18:53:29 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	nigel@mips.com, ralf@linux-mips.org, dan@debian.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
In-Reply-To: <20060911.233046.41631256.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0609111810090.29692@blysk.ds.pg.gda.pl>
References: <4501AABC.1050009@mips.com> <20060909.225641.41198763.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0609111406400.29692@blysk.ds.pg.gda.pl>
 <20060911.233046.41631256.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1856/Mon Sep 11 15:51:46 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 11 Sep 2006, Atsushi Nemoto wrote:

> >  What's wrong with just letting a TLB fault happen?
> 
> It might add a little overhead to usual TLB refill handling.  The
> overhead might be neglectable, but I'm not sure.

 There is no need to change the refill handler -- only the general TLBL 
exception has to be modified.  And this one may be not too critical -- the 
change required is in the path to mark pages accessed.  Is the path 
frequent enough to seek a complex solution while a simple one would just 
work?

  Maciej
