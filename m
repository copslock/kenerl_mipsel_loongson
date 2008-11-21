Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 16:25:16 +0000 (GMT)
Received: from mx0.towertech.it ([213.215.222.73]:42125 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S23818060AbYKUQZI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2008 16:25:08 +0000
Received: (qmail 26906 invoked from network); 21 Nov 2008 17:25:01 +0100
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 21 Nov 2008 17:25:01 +0100
Date:	Fri, 21 Nov 2008 17:24:59 +0100
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	rtc-linux@googlegroups.com
Cc:	anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [rtc-linux] Re: [PATCH 3/4] rtc: Add rtc-tx4939 driver
Message-ID: <20081121172459.2617b4fc@i1501.lan.towertech.it>
In-Reply-To: <20081121.231206.96686926.anemo@mba.ocn.ne.jp>
References: <1227194815-16200-1-git-send-email-anemo@mba.ocn.ne.jp>
	<20081120164533.73ba1f7f@i1501.lan.towertech.it>
	<20081121.231206.96686926.anemo@mba.ocn.ne.jp>
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
X-archive-position: 21360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Fri, 21 Nov 2008 23:12:06 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Thu, 20 Nov 2008 16:45:33 +0100, Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
> >  AIE_ON an OFF are mapped to alarm_irq_enable, please see the latest patches
> >  on the rtc mailing list or here http://patchwork.ozlabs.org/patch/9676/  
> 
> This patch cause deadlock on RTC UIE emulation (again).
> 
> Please fold this fix into the rtc-add-alarm-update-irq-interfaces patch.

 thanks!

 done, with minor changes. available
 at http://patchwork.ozlabs.org/patch/10039/

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
