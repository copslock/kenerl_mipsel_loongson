Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 16:16:36 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:46243 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024587AbZESPQa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 May 2009 16:16:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 7C28C340B4;
	Tue, 19 May 2009 22:35:42 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OKpgHnpZqZYX; Tue, 19 May 2009 22:35:21 +0800 (CST)
Received: from localhost.localdomain (unknown [172.16.2.66])
	by lemote.com (Postfix) with ESMTP id E854B340AD;
	Tue, 19 May 2009 22:35:20 +0800 (CST)
Message-ID: <4A12C3FB.4010704@lemote.com>
Date:	Tue, 19 May 2009 22:36:43 +0800
From:	=?UTF-8?B?6IOh5rSq5YW1?= <huhb@lemote.com>
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
MIME-Version: 1.0
To:	Erwan Lerale <erwan@thiscow.com>
CC:	wuzhangjin@gmail.com, loongson-dev@googlegroups.com,
	yanh@lemote.com, zhangfx@lemote.com, penglj@lemote.com,
	taohl@lemote.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [loongson-dev] Re: a pre-release of merging loongson patchs to
 linux-2.6.29.1
References: <1240501332.28136.24.camel@falcon>	 <49F0AFA3.6080408@thiscow.com> <1240535343.25824.14.camel@falcon>	 <49F16061.9010207@thiscow.com> <1240556617.23345.10.camel@falcon>	 <49F217E1.8080808@thiscow.fr> <1240640248.25540.27.camel@falcon> <49F497E9.7080803@thiscow.com> <4A12A289.4070102@thiscow.com>
In-Reply-To: <4A12A289.4070102@thiscow.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <huhb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: huhb@lemote.com
Precedence: bulk
X-list: linux-mips

Erwan Lerale 写道:
> Erwan Lerale a écrit :
>
>> Now, let's talk about the cpufreq stuff :)
>>
>> cpufrequtils 005: cpufreq-info (C) Dominik Brodowski 2004-2006
>> Report errors and bugs to cpufreq@vger.kernel.org, please.
>> analyzing CPU 0:
>>  driver: loongson2f
>>  CPUs which need to switch frequency at the same time: 0
>>  hardware limits: 199 MHz - 797 MHz
>>  available frequency steps: 199 MHz, 299 MHz, 398 MHz, 498 MHz, 598 
>> MHz, 697 MHz, 797 MHz
>>  available cpufreq governors: conservative, ondemand, userspace, 
>> powersave, performance
>>  current policy: frequency should be within 199 MHz and 797 MHz.
>>                  The governor "ondemand" may decide which speed to use
>>                  within this range.
>>  current CPU frequency is 797 MHz (asserted by call to hardware).
>>  cpufreq stats: 199 MHz:0.00%, 299 MHz:0.00%, 398 MHz:0.00%, 498 
>> MHz:0.00%, 598 MHz:0.00%, 697 MHz:0.00%, 797 MHz:100.00%
>>
>> It seems to be working but it's weird. When I start X and gnome 
>> (cpufreq applet). I can see
>> that's the system is using the ondemand performance but is stuck at 
>> 797 Mhz if I don't do anything.
>> If i start working (yeah it's happening sometimes), the frequency is 
>> moving from 199Mhz to 797Mhz.
>>
>> The other thing which is weird is that I don't have this problem with 
>> the Loonux stock kernel.
>
> Hello,
>
> I've switched from the ondemand governor to the conservative one and 
> it seems
> to be working properly.
>
Yes, the conservative governor  is better than the ondemand.
> I have also noticed that the fans seems to be running at full speed 
> all the time.
> Any comment, on this issue ?
>
we test that it only  save  power  about  1~2w   when the cpufreq  is  min.
So the temperature will be reduced a little.
when the temp is the some section,
eg. the  60°C and 65°C  are the same section when the section is 60°C~70°C，
the speed of  fans will be the same.

> Is there a way to query the sensors ?
Please insmod  ec_ftd which is one of the ec modules.
And then type  "cat  /proc/ft" ,  the output: "1.31 0x01 4705 0x00 56"

the 4705 means  the speed of fans,   56 stands for  the  temperature

the ec_modules  source  URL:
http://dev.lemote.com/code/ec_module

git URL:
git://dev.lemote.com/ec_module.git
> Cheers
> r1
>
>
>
>


-- 
---------------------------------------------------------
Hongbing,Hu (Software Department)
Tel:    0512-52308631
E-mail:	huhb@lemote.com
MSN:	[huhb04@gmail.com]
JiangSu Lemote Corp. Ltd.
MengLan, Yushan, Changshu, JiangSu Province, China
---------------------------------------------------------
