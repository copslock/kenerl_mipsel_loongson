Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 20:50:43 +0100 (BST)
Received: from zhongguo.thiscow.com ([88.191.99.114]:55440 "EHLO
	zhongguo.thiscow.com") by ftp.linux-mips.org with ESMTP
	id S20024182AbZDXTuf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 20:50:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by zhongguo.thiscow.com (Postfix) with ESMTP id D90E41AE19A;
	Fri, 24 Apr 2009 21:50:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at thiscow.com
Received: from zhongguo.thiscow.com ([127.0.0.1])
	by localhost (zhongguo.thiscow.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cUW-unwxmGgv; Fri, 24 Apr 2009 21:50:29 +0200 (CEST)
Received: from [192.168.0.5] (chl35-1-88-163-125-22.fbx.proxad.net [88.163.125.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: erwan@thiscow.fr)
	by zhongguo.thiscow.com (Postfix) with ESMTPSA id B4BCF1AE00B;
	Fri, 24 Apr 2009 21:50:28 +0200 (CEST)
Message-ID: <49F217E1.8080808@thiscow.fr>
Date:	Fri, 24 Apr 2009 21:49:53 +0200
From:	Erwan Lerale <erwan@thiscow.fr>
User-Agent: Thunderbird 2.0.0.21 (X11/20090321)
MIME-Version: 1.0
To:	loongson-dev@googlegroups.com
CC:	yanh@lemote.com, zhangfx@lemote.com, penglj@lemote.com,
	huhb@lemote.com, taohl@lemote.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [loongson-dev] Re: a pre-release of merging loongson patchs to
 linux-2.6.29.1
References: <1240501332.28136.24.camel@falcon> <49F0AFA3.6080408@thiscow.com> <1240535343.25824.14.camel@falcon> <49F16061.9010207@thiscow.com> <1240556617.23345.10.camel@falcon>
In-Reply-To: <1240556617.23345.10.camel@falcon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <erwan@thiscow.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erwan@thiscow.fr
Precedence: bulk
X-list: linux-mips


> a new branch for gcc 4.4 is created as linux-2.6.29-stable-loongson-gcc4.4, 
> welcome to pull it.
>
> $ git clone git://dev.lemote.com/rt4ls.git
> $ git checkout -b linux-2.6.29-stable-loongson-gcc4.4 --track origin/linux-2.6.29-stable-loongson-gcc4.4
>
> if you have cloned it, just update it and then checkout the branch
>
> $ git pull
> $ git checkout -b linux-2.6.29-stable-loongson-gcc4.4 --track origin/linux-2.6.29-stable-loongson-gcc4.4
>   


Hello,


The kernel is compiling fine now. I have been using it for a few hours.

I don't understand why some stuff are not included in
arch/mips/configs/yeeloong2f_defconfig,
for example the sound chip or the v4l stuff for the webcam.

I also had to :
- add INPUT_EDEV to get the mouse and the keyboard under X (1.6.99.1).
- compile external wifi modules from
 
http://www.lemote.com/upfiles/wifi/rtl8187B_linux_26.1049.1215.2008_release2.tar.gz

  to get proper Wifi performances (or I had to sit on the access point)
- get and compile the ec_module stuff from git
- had the PPP and bluetooth support for my 3G connection that's works
now with wvdial (thanks robert :))

The box is also complaining when it boots and try to set time :

xiwen ~ (n32) # hwclock  --debug
hwclock from util-linux-ng 2.14.2
hwclock: Open of /dev/rtc failed, errno=2: No such file or directory.
No usable clock interface found.
Cannot access the Hardware Clock via any known method.

I have seen some patches related to system clock in the git tree but i
don't understand.

What has to be included in the config tree to get suspend/hibernate and 
cpu_freq working  ? 
It seems to be linked to the clocking nope ?

Cheers
Erwan
