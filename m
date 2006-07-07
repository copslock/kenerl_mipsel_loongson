Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 18:04:19 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2565 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133521AbWGGREJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Jul 2006 18:04:09 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 4F723F6181;
	Fri,  7 Jul 2006 19:04:03 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 30145-05; Fri,  7 Jul 2006 19:04:03 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E8A58F59C3;
	Fri,  7 Jul 2006 19:04:02 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.7/8.13.1) with ESMTP id k67H4DkP018919;
	Fri, 7 Jul 2006 19:04:13 +0200
Date:	Fri, 7 Jul 2006 18:04:08 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
In-Reply-To: <20060708.014339.89274844.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0607071759140.25285@blysk.ds.pg.gda.pl>
References: <20060708.000032.88471510.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0607071607520.25285@blysk.ds.pg.gda.pl>
 <20060708.011245.82794581.anemo@mba.ocn.ne.jp> <20060708.014339.89274844.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1588/Fri Jul  7 15:54:23 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 8 Jul 2006, Atsushi Nemoto wrote:

> Can we use Index_Load_Data_I to load the instruction code from icache?

 No need to go through such a hassle when we have a proper architectural 
way of handling it.  Remember MIPS TLB-based MMUs (the two variations I 
know well, anyway) were designed to support a paged kernel.

  Maciej
