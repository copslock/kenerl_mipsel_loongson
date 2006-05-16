Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 May 2006 08:06:59 +0200 (CEST)
Received: from h081217049130.dyn.cm.kabsi.at ([81.217.49.130]:9878 "EHLO
	phobos.hvrlab.org") by ftp.linux-mips.org with ESMTP
	id S8133371AbWEPGGw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 May 2006 08:06:52 +0200
Received: from mini.intra (dhcp-1432-30.blizz.at [213.143.126.4])
	(authenticated bits=0)
	by phobos.hvrlab.org (8.13.4/8.13.4/Debian-3sarge1) with ESMTP id k4G66ifh019167
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 16 May 2006 08:06:49 +0200
Subject: Re: CONFIG_PRINTK_TIME and initial value for jiffies?
From:	Herbert Valerio Riedel <hvr@gnu.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Clem Taylor <clem.taylor@gmail.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <4468F40F.80902@ru.mvista.com>
References: <ecb4efd10605151341l33f491f1ueca8a0ce609c989d@mail.gmail.com>
	 <4468EE9B.4000009@ru.mvista.com>  <4468F40F.80902@ru.mvista.com>
Content-Type: text/plain
Organization: Free Software Foundation
Date:	Tue, 16 May 2006 08:03:19 +0200
Message-Id: <1147759399.11301.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.88.2/1463/Mon May 15 12:55:22 2006 on phobos.hvrlab.org
X-Virus-Status:	Clean
Return-Path: <hvr@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@gnu.org
Precedence: bulk
X-list: linux-mips

hello!

On Tue, 2006-05-16 at 01:35 +0400, Sergei Shtylyov wrote:
> >> I just switched to 2.6.16.16 from 2.6.14 on a Au1550. I enabled
> >> CONFIG_PRINTK_TIME, and for some reason jiffies doesn't start out near
> >> zero like it does on x86. The first printk() always seems to have a
> >> time of 4284667.296000.
> 
> >> jiffies_64 and wall_jiffies gets initialized to INITIAL_JIFFIES, but
> >> I'm not sure where jiffies is initialized. INITIAL_JIFFIES is -300*HZ
> >> (with some weird casting)
> 
>     Yes, the casting is weird. I somewat doubt that:
> 
> #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> 
> u64 jiffies_64 = INITIAL_JIFFIES;
> 
> can do the trick of wrapping around 5 mins after boot on x86... :-/

jfyi, starting with an offset of -300 seconds is done on purpose, to
expose bugs in drivers which don't handle wrapping of the jiffies;

and the trick to get printk to start at offset 0 is either define a
arch-specific printk_clock() function (it's a weak symbol in
kernel/printk.c) or like more drivers to it, to provide a sched_clock()
(which is used by the default printk_clock() function) implementation
which starts at offset 0...

regards,
hvr
