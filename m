Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2008 16:21:57 +0000 (GMT)
Received: from mx0.towertech.it ([213.215.222.73]:33155 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S23793131AbYKTQVr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2008 16:21:47 +0000
Received: (qmail 31083 invoked from network); 20 Nov 2008 17:21:43 +0100
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 20 Nov 2008 17:21:43 +0100
Date:	Thu, 20 Nov 2008 17:21:38 +0100
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [rtc-linux] [PATCH 3/4] rtc: Add rtc-tx4939 driver
Message-ID: <20081120172138.2de2da58@i1501.lan.towertech.it>
In-Reply-To: <20081121.011744.103777651.anemo@mba.ocn.ne.jp>
References: <1227194815-16200-1-git-send-email-anemo@mba.ocn.ne.jp>
	<20081120164533.73ba1f7f@i1501.lan.towertech.it>
	<20081121.011744.103777651.anemo@mba.ocn.ne.jp>
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
X-archive-position: 21346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Fri, 21 Nov 2008 01:17:44 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> It is used to protect sysfs nvram access from rtc ops.
> 
> Hm, can I use rtc->ops_lock in sysfs read/write routine to achieve it?

 it should be doable, rtc-ds1305 uses it


> I will address all other issues.  Thanks.

 thanks!

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
