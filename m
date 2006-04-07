Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 12:06:57 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:58636 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133529AbWDGLGq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Apr 2006 12:06:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 79FE9F7DA1;
	Fri,  7 Apr 2006 13:18:03 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09966-09; Fri,  7 Apr 2006 13:18:03 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id AD4E6F7D9D;
	Fri,  7 Apr 2006 13:18:01 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k37BI6GY018227;
	Fri, 7 Apr 2006 13:18:07 +0200
Date:	Fri, 7 Apr 2006 12:18:03 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] use CONFIG_HZ
In-Reply-To: <20060407.011000.77652835.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0604071156350.25570@blysk.ds.pg.gda.pl>
References: <20060407.011000.77652835.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88/1380/Fri Apr  7 08:46:22 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 7 Apr 2006, Atsushi Nemoto wrote:

> Make HZ configurable (except for DECSTATION which is using special HZ
> value which is out of choice).  Also remove some param.h files and

 The DECstation could actually use a choice of 128Hz, 256Hz and 1024Hz if 
anybody cared.

  Maciej
