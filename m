Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2011 18:05:21 +0200 (CEST)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:33279 "EHLO
        mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493808Ab1HZQFQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2011 18:05:16 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id BBDEE56421D;
        Sat, 27 Aug 2011 01:05:11 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Sat, 27 Aug 2011 01:05:11 +0900 (JST)
Date:   Sat, 27 Aug 2011 01:05:06 +0900 (JST)
Message-Id: <20110827.010506.17266154.anemo@mba.ocn.ne.jp>
To:     mattst88@gmail.com
Cc:     johnstul@us.ibm.com, linux-mips@linux-mips.org,
        rtc-linux@googlegroups.com, a.zummo@towertech.it
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <CAEdQ38G7csFL61Ye1h-3Jszh2nDHytm1ms0rS4nGBC1E0QEfzQ@mail.gmail.com>
References: <1313788912.2970.152.camel@work-vm>
        <CAEdQ38Gg2FWJNacoa51+=eu8JQRr2mSA7jCjosOGbv8FKPFDpw@mail.gmail.com>
        <CAEdQ38G7csFL61Ye1h-3Jszh2nDHytm1ms0rS4nGBC1E0QEfzQ@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 31001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20077

On Thu, 25 Aug 2011 13:30:02 -0400, Matt Turner <mattst88@gmail.com> wrote:
> I looked through the datasheet and tried to find a place where we're
> doing something wrong in the driver, but I didn't see anything.
> 
> http://www.datasheetcatalog.com/datasheets_pdf/M/4/1/T/M41T80.shtml

Excuse me for slow response.

As you and John discovered, this driver do not support alarm
completely.  This driver just can set/read alarm date/time, but RTC
interrupt is not implemented yet.

So possible solutions would be:

* Implement RTC irq handler. (Now we have threaded-irq so it would be
easier than the past)
* Drop .set_alarm function. (i.e. drop whole alarm codes)

I cannot test this driver by myself, but I will take a look if you had
any fix.  Thank you.

---
Atsushi Nemoto
