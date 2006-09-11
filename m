Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 14:09:27 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3846 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038252AbWIKNJY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Sep 2006 14:09:24 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 11BECF81CF;
	Mon, 11 Sep 2006 15:09:20 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ipO-NVOsnkAJ; Mon, 11 Sep 2006 15:09:19 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A858EF819B;
	Mon, 11 Sep 2006 15:09:19 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k8BD9OJe001822;
	Mon, 11 Sep 2006 15:09:25 +0200
Date:	Mon, 11 Sep 2006 14:09:20 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	nigel@mips.com, ralf@linux-mips.org, dan@debian.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
In-Reply-To: <20060909.225641.41198763.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0609111406400.29692@blysk.ds.pg.gda.pl>
References: <20060711025342.GA6898@nevyn.them.org>
 <20060711.122014.52129937.nemoto@toshiba-tops.co.jp> <4501AABC.1050009@mips.com>
 <20060909.225641.41198763.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1850/Mon Sep 11 11:41:17 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 9 Sep 2006, Atsushi Nemoto wrote:

> But I'm still looking for better solution (silver bullet?) for
> cpu_has_vtag_icache case.

 What's wrong with just letting a TLB fault happen?

  Maciej
