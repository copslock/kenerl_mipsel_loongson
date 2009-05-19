Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 13:14:04 +0100 (BST)
Received: from mail.rennes.fr.clara.net ([62.240.254.62]:51071 "EHLO
	rennes.fr.clara.net" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20024549AbZESMNz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2009 13:13:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by rennes.fr.clara.net (Postfix) with ESMTP id 2A7FA3A519;
	Tue, 19 May 2009 14:13:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from rennes.fr.clara.net ([127.0.0.1])
	by localhost (rennes.fr.clara.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ewyq7HeOlFOJ; Tue, 19 May 2009 14:13:48 +0200 (CEST)
Received: from [10.0.1.235] (unknown [10.0.1.235])
	by rennes.fr.clara.net (Postfix) with ESMTP id 2A13E38FEB;
	Tue, 19 May 2009 14:13:48 +0200 (CEST)
Message-ID: <4A12A289.4070102@thiscow.com>
Date:	Tue, 19 May 2009 14:14:01 +0200
From:	Erwan Lerale <erwan@thiscow.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com
CC:	loongson-dev@googlegroups.com, yanh@lemote.com, zhangfx@lemote.com,
	penglj@lemote.com, huhb@lemote.com, taohl@lemote.com,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [loongson-dev] Re: a pre-release of merging loongson patchs to
 linux-2.6.29.1
References: <1240501332.28136.24.camel@falcon>	 <49F0AFA3.6080408@thiscow.com> <1240535343.25824.14.camel@falcon>	 <49F16061.9010207@thiscow.com> <1240556617.23345.10.camel@falcon>	 <49F217E1.8080808@thiscow.fr> <1240640248.25540.27.camel@falcon> <49F497E9.7080803@thiscow.com>
In-Reply-To: <49F497E9.7080803@thiscow.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <erwan@thiscow.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erwan@thiscow.com
Precedence: bulk
X-list: linux-mips

Erwan Lerale a écrit :

> Now, let's talk about the cpufreq stuff :)
>
> cpufrequtils 005: cpufreq-info (C) Dominik Brodowski 2004-2006
> Report errors and bugs to cpufreq@vger.kernel.org, please.
> analyzing CPU 0:
>  driver: loongson2f
>  CPUs which need to switch frequency at the same time: 0
>  hardware limits: 199 MHz - 797 MHz
>  available frequency steps: 199 MHz, 299 MHz, 398 MHz, 498 MHz, 598 
> MHz, 697 MHz, 797 MHz
>  available cpufreq governors: conservative, ondemand, userspace, 
> powersave, performance
>  current policy: frequency should be within 199 MHz and 797 MHz.
>                  The governor "ondemand" may decide which speed to use
>                  within this range.
>  current CPU frequency is 797 MHz (asserted by call to hardware).
>  cpufreq stats: 199 MHz:0.00%, 299 MHz:0.00%, 398 MHz:0.00%, 498 
> MHz:0.00%, 598 MHz:0.00%, 697 MHz:0.00%, 797 MHz:100.00%
>
> It seems to be working but it's weird. When I start X and gnome 
> (cpufreq applet). I can see
> that's the system is using the ondemand performance but is stuck at 
> 797 Mhz if I don't do anything.
> If i start working (yeah it's happening sometimes), the frequency is 
> moving from 199Mhz to 797Mhz.
>
> The other thing which is weird is that I don't have this problem with 
> the Loonux stock kernel.

Hello,

I've switched from the ondemand governor to the conservative one and it 
seems
to be working properly.

I have also noticed that the fans seems to be running at full speed all 
the time.
Any comment, on this issue ?

Is there a way to query the sensors ?

Cheers
r1
