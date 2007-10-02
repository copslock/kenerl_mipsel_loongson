Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 20:14:38 +0100 (BST)
Received: from mx0.towertech.it ([213.215.222.73]:44942 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S20022204AbXJBTO3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 20:14:29 +0100
Received: (qmail 6675 invoked from network); 2 Oct 2007 21:13:19 +0200
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 2 Oct 2007 21:13:19 +0200
Date:	Tue, 2 Oct 2007 15:16:24 +0200
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	rtc-linux@googlegroups.com
Cc:	anemo@mba.ocn.ne.jp, rongkai.zhan@windriver.com,
	i2c@lm-sensors.org, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [rtc-linux] Re: [PATCH 2/4] RTC: make m41t80 driver can work
 with the SMBus adapters
Message-ID: <20071002151624.24ff7bb1@i1501.lan.towertech.it>
In-Reply-To: <20071002.000616.31638007.anemo@mba.ocn.ne.jp>
References: <46FF726E.4020200@windriver.com>
	<20071002.000616.31638007.anemo@mba.ocn.ne.jp>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alessandro.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Tue, 02 Oct 2007 00:06:16 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> 
> On Sun, 30 Sep 2007 17:54:54 +0800, Mark Zhan <rongkai.zhan@windriver.com> wrote:
> > This patch makes m41t80 RTC driver also can work with the SMBus adapters,
> > which doesn't i2c_transfer() method.
> > 
> > Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
> 
> As Jean already said, your mailer corrupted your patch.
> Also, please keep in mind the 80 column rule.

 [...]

 fwiw, I agree with Atsushi's comments.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
