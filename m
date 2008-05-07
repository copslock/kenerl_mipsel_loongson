Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 07:57:45 +0100 (BST)
Received: from mx0.towertech.it ([213.215.222.73]:58349 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S20044493AbYEGG5m (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2008 07:57:42 +0100
Received: (qmail 5386 invoked from network); 7 May 2008 08:57:40 +0200
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 7 May 2008 08:57:40 +0200
Date:	Wed, 7 May 2008 08:57:39 +0200
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	rtc-linux@googlegroups.com
Cc:	macro@linux-mips.org, Jean Delvare <khali@linux-fr.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] [RFC][PATCH 0/4] RTC: Use class devices as a
 persistent clock
Message-ID: <20080507085739.4f538d2e@i1501.lan.towertech.it>
In-Reply-To: <Pine.LNX.4.55.0805062333390.16173@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805062333390.16173@cliff.in.clinika.pl>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alessandro.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Wed, 7 May 2008 01:39:59 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> 
> Hello,
> 
>  While investigating why Linux on the MIPS64 Broadcom BCM91250A board (the
> SWARM, based on the SiByte BCM1250A SOC) does not support an RTC device
> anymore I discovered the "wiring" of code to access /dev/rtc to the RTC
> device driver got removed with some changes that happened a while ago.  
> The board uses the ST M41T81 I2C chip with a driver buried within the
> architecture code.  There is a standard driver for this chip in our tree
> already, which is called rtc-m41t80, and which as a part of the RTC driver
> suite provides the necessary "wiring" to /dev/rtc.

 [...]


 Hi Maciej,

   you did a great work. you have my Acked-by on the rtc/ntp code, but
 I think we'd need some reports from current users of the m41t81 driver
 before pushing that one in.


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
