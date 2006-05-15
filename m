Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 23:36:22 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:57778 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133723AbWEOVgN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 May 2006 23:36:13 +0200
Received: (qmail 10810 invoked from network); 16 May 2006 01:42:43 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 16 May 2006 01:42:43 -0000
Message-ID: <4468F40F.80902@ru.mvista.com>
Date:	Tue, 16 May 2006 01:35:11 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Clem Taylor <clem.taylor@gmail.com>
CC:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: CONFIG_PRINTK_TIME and initial value for jiffies?
References: <ecb4efd10605151341l33f491f1ueca8a0ce609c989d@mail.gmail.com> <4468EE9B.4000009@ru.mvista.com>
In-Reply-To: <4468EE9B.4000009@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.
> 
> Clem Taylor wrote:
> 
>> I just switched to 2.6.16.16 from 2.6.14 on a Au1550. I enabled
>> CONFIG_PRINTK_TIME, and for some reason jiffies doesn't start out near
>> zero like it does on x86. The first printk() always seems to have a
>> time of 4284667.296000.

>> jiffies_64 and wall_jiffies gets initialized to INITIAL_JIFFIES, but
>> I'm not sure where jiffies is initialized. INITIAL_JIFFIES is -300*HZ
>> (with some weird casting)

    Yes, the casting is weird. I somewat doubt that:

#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

u64 jiffies_64 = INITIAL_JIFFIES;

can do the trick of wrapping around 5 mins after boot on x86... :-/

MBR, Sergei
