Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2008 19:38:20 +0100 (BST)
Received: from mx0.towertech.it ([213.215.222.73]:10186 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S22034470AbYJUSiR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2008 19:38:17 +0100
Received: (qmail 15390 invoked from network); 21 Oct 2008 20:38:16 +0200
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 21 Oct 2008 20:38:16 +0200
Date:	Tue, 21 Oct 2008 20:38:15 +0200
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	rtc-linux@googlegroups.com
Cc:	mano@roarinelk.homelinux.net,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [rtc-linux] [RFC PATCH] Au1xxx on-chip counter-as-RTC driver
Message-ID: <20081021203815.1a0a246d@i1501.lan.towertech.it>
In-Reply-To: <20080809161402.15e24b2e@flagship.roarinelk.net>
References: <20080809161402.15e24b2e@flagship.roarinelk.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
X-This-Is-A-Real-Message: Yes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alessandro.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Sat, 9 Aug 2008 16:14:02 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> It works so far on the DB1200 board; however it takes up
> to 5 seconds until the written value actually hits the
> register, so the hardware clock is always off (the minimum
> seems to be 3 seconds on the DB1200).  I'd like to get
> some feedback on how to work around this "anomaly".

 Hi Manuel,

  any news on this driver? I'd need feedback from linux-mips
 to get it thru.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
