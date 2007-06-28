Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2007 15:54:24 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:64704 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022664AbXF1OyT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2007 15:54:19 +0100
Received: from cpe-065-190-165-210.nc.res.rr.com ([65.190.165.210] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I3vNv-0002YC-J7; Thu, 28 Jun 2007 14:54:16 +0000
Message-ID: <4683CB96.9090609@garzik.org>
Date:	Thu, 28 Jun 2007 10:54:14 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.12 (X11/20070530)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	sshtylyov@ru.mvista.com, mlachwani@mvista.com
Subject: Re: [PATCH 3/4] rbtx4938: Fix secondary PCIC and glue internal NICs
References: <20070622.232219.48807177.anemo@mba.ocn.ne.jp>	<20070625002822.GD5814@linux-mips.org>	<20070625.231502.69024828.anemo@mba.ocn.ne.jp> <20070628.230050.27955707.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070628.230050.27955707.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Seems to sane to me, by my quick read.

My only comment is:  if invalid MAC address, generate a random one using 
get_random_bytes() like some other net drivers do, rather than just failing.

Users should be able to use the NIC even if the MAC is invalid -- after 
all, they can set one using ifconfig even if it is not available at 
driver load time.

	Jeff
