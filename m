Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2007 19:28:16 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:44559 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022487AbXEOS2O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 May 2007 19:28:14 +0100
Received: (qmail 10134 invoked by uid 1000); 15 May 2007 20:27:14 +0200
Date:	Tue, 15 May 2007 20:27:13 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	i2c@lm-sensors.org, linux-mips@linux-mips.org
Cc:	khali@linux-fr.org
Subject: Re: [PATCH 2/2] i2c-au1550: convert to platform driver
Message-ID: <20070515182713.GC9506@roarinelk.homelinux.net>
References: <20070515180920.GB9506@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070515180920.GB9506@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Scrap those 2 patches, I just noticed I introduced a change in 
behaviour with multiple messages. Updates follow.

Thanks,
	Manuel Lauss
