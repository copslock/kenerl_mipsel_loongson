Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 10:59:48 +0000 (GMT)
Received: from mx0.towertech.it ([213.215.222.73]:56219 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S22570942AbYJ1K7l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 10:59:41 +0000
Received: (qmail 30861 invoked from network); 28 Oct 2008 11:59:37 +0100
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 28 Oct 2008 11:59:37 +0100
Date:	Tue, 28 Oct 2008 11:59:27 +0100
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	rtc-linux@googlegroups.com, Linux-MIPS <linux-mips@linux-mips.org>,
	Kevin Hickey <khickey@rmicorp.com>,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [rtc-linux] Re: [RFC PATCH] Au1xxx on-chip counter-as-RTC
 driver
Message-ID: <20081028115927.6996d07f@i1501.lan.towertech.it>
In-Reply-To: <20081028105220.GA1235@roarinelk.homelinux.net>
References: <20080809161402.15e24b2e@flagship.roarinelk.net>
	<20081021203815.1a0a246d@i1501.lan.towertech.it>
	<20081022073114.GA11169@roarinelk.homelinux.net>
	<20081028111704.2feb3b53@i1501.lan.towertech.it>
	<20081028105220.GA1235@roarinelk.homelinux.net>
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
X-archive-position: 21054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Tue, 28 Oct 2008 11:52:20 +0100
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> >  I'd need some feedback from linux-mips, otherwise
> >  I can only Sign-off for the entries in drivers/rtc .  
> 
> I stripped the alchemy board parts away from the patch; they can go in
> through the mips tree at a later time.

 ok.

> >  Btw why are you using a lock? the rtc class core
> >  already provides his own lock for the ops calls.  
> 
> Didn't know that; I mostly looked at rtc-sh.c for guidance which also
> uses its own locks.

 I think it's due to the interrupt handling in rtc-sh.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
