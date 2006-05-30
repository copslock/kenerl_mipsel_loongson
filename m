Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2006 15:03:29 +0200 (CEST)
Received: from ra.tuxdriver.com ([24.172.12.4]:34822 "EHLO ra.tuxdriver.com")
	by ftp.linux-mips.org with ESMTP id S8133465AbWE3NDU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2006 15:03:20 +0200
Received: from bilbo.hq.tuxdriver.com (azure.tuxdriver.com [24.172.12.5])
	by ra.tuxdriver.com (8.13.6/8.13.6) with ESMTP id k4UD39u4027979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 May 2006 09:03:10 -0400
Received: from bilbo.hq.tuxdriver.com (localhost.localdomain [127.0.0.1])
	by bilbo.hq.tuxdriver.com (8.13.1/8.13.1) with ESMTP id k4UD38sP018753;
	Tue, 30 May 2006 09:03:08 -0400
Received: (from linville@localhost)
	by bilbo.hq.tuxdriver.com (8.13.1/8.13.1/Submit) id k4UD378l018752;
	Tue, 30 May 2006 09:03:07 -0400
Date:	Tue, 30 May 2006 09:03:07 -0400
From:	"John W. Linville" <linville@tuxdriver.com>
To:	Roman Mashak <mrv@corecom.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: Re: compiling BCM5700 driver
Message-ID: <20060530130300.GA18560@tuxdriver.com>
Mail-Followup-To: Roman Mashak <mrv@corecom.co.kr>,
	linux-mips@linux-mips.org
References: <000101c6838e$437abdf0$9d0ba8c0@mrv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101c6838e$437abdf0$9d0ba8c0@mrv>
User-Agent: Mutt/1.4.1i
Return-Path: <linville@tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips

On Tue, May 30, 2006 at 11:10:45AM +0900, Roman Mashak wrote:

> I try to compile BCM5700 driver of gigabit ethernet card for MIPS target. I 
> used both toolchains (from PMC-sierra and self-made following 
> http://www.kegel.com/crosstool recommendations). Get same errors:

I really can't help you w/ the bcm5700 driver.  But, I am wondering
why are you not using tg3 instead?

John
-- 
John W. Linville
linville@tuxdriver.com
