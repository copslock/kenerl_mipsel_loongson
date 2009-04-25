Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Apr 2009 07:18:17 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.245]:52925 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20022070AbZDYGSH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Apr 2009 07:18:07 +0100
Received: by rv-out-0708.google.com with SMTP id k29so1109035rvb.24
        for <multiple recipients>; Fri, 24 Apr 2009 23:18:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ZKeery/k3vsnSDUzYgnkv/eKqia4gwtVqKa5Gv2gyDg=;
        b=vmNZo1/VIDS4LL3OT50fLMQq56QRvWVOvXbCdjmecnijf9w3dWMI/cWyIgcWqtc5+H
         Og1elJJckUt+x0F1k2Q2uigoGgzqMUNaooWScI88HiDeyOK2zYKwSBNxFEFH+ZQcEKME
         8xaBIngEk1zM+hkqdFmkQ/MebseD6DWqDN37w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=JW4m9v9H7ZD3rhOplFQdLTN+3M1vnLmDzUriSEdQXNp9+XxTJxy14EJGNTk3YOOmvY
         qwwheMQjuCJ9itCJ1Ycj07VlumRuRgpdHfBkx3x477Tw49ixrTtBUP+daaq8b0wztFVi
         yURkRW37adb/50DsOh+L1EdAzwcVCICbaJ2wM=
Received: by 10.140.134.10 with SMTP id h10mr1031855rvd.30.1240640281717;
        Fri, 24 Apr 2009 23:18:01 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id g22sm1850443rvb.16.2009.04.24.23.17.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 23:18:00 -0700 (PDT)
Subject: Re: [loongson-dev] Re: a pre-release of merging loongson patchs to
 linux-2.6.29.1
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Erwan Lerale <erwan@thiscow.fr>
Cc:	loongson-dev@googlegroups.com, yanh@lemote.com, zhangfx@lemote.com,
	penglj@lemote.com, huhb@lemote.com, taohl@lemote.com,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <49F217E1.8080808@thiscow.fr>
References: <1240501332.28136.24.camel@falcon>
	 <49F0AFA3.6080408@thiscow.com> <1240535343.25824.14.camel@falcon>
	 <49F16061.9010207@thiscow.com> <1240556617.23345.10.camel@falcon>
	 <49F217E1.8080808@thiscow.fr>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 25 Apr 2009 14:17:28 +0800
Message-Id: <1240640248.25540.27.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips


> Hello,
> 
> 
> The kernel is compiling fine now. I have been using it for a few hours.
> 

thanks for your work :-)

> I don't understand why some stuff are not included in
> arch/mips/configs/yeeloong2f_defconfig,
> for example the sound chip or the v4l stuff for the webcam.
> 

I just updated the default kernel configuration file for loongson2f
based machines, hope it can help you :-)

> I also had to :
> - add INPUT_EDEV to get the mouse and the keyboard under X (1.6.99.1).
> - compile external wifi modules from
>  
> http://www.lemote.com/upfiles/wifi/rtl8187B_linux_26.1049.1215.2008_release2.tar.gz
> 
>   to get proper Wifi performances (or I had to sit on the access point)
> - get and compile the ec_module stuff from git
> - had the PPP and bluetooth support for my 3G connection that's works
> now with wvdial (thanks robert :))
> 
> The box is also complaining when it boots and try to set time :
> 
> xiwen ~ (n32) # hwclock  --debug
> hwclock from util-linux-ng 2.14.2
> hwclock: Open of /dev/rtc failed, errno=2: No such file or directory.
> No usable clock interface found.
> Cannot access the Hardware Clock via any known method.
> 

the previous kernel configuration file not include the "Real Time
Clock", so, no /dev/rtc there, so sorry :-)   

> I have seen some patches related to system clock in the git tree but i
> don't understand.
> 
> What has to be included in the config tree to get suspend/hibernate and 
> cpu_freq working  ?

* try the following configuration options:

Machine selection  --->
             [*] Using cs5536's MFGPT as system clock

Power management options  --->
             [*] Power Management support 
             [*] Suspend to RAM and standby
             [*] Hibernation (aka 'suspend to disk')              
             (/dev/hda3) Default resume partition               

CPU Frequency scaling  --->
             [*] CPU Frequency scaling
             [*]   Loongson-2F CPU Frequency driver            
             

* basic user manual(from www.lemote.com):

1. install a shell script 

# apt-get install hibernate

2. modify the configuration file /etc/hibernate/common.conf

* find the "UnloadModules" section, modify it like this

UnloadModules r8187 usbhid ohci_hcd ehci_hcd

remove the # before "LoadModules auto"

* modify the "network" section

DownInterfaces eth0
UpInterfaces auto

* modify the "hardware_tweaks" section

remove the # before "FullSpeedCPU yes"

3. prepare a swap partition, by default, it is configured in kernel
as /dev/hda3

change it to yours swap partition in kernel or configure it
via /sys/power/resume, for example:

# fdisk -l | grep swap | cut -d' ' -f1
/dev/sda5
# ls -l /dev/sda5
brw-rw---- 1 root disk 8, 5 2009-04-10 10:26 /dev/sda5
# echo 8:5 > /sys/power/resume

4. resume

pass an argument "resume=/dev/hdaX" to kernel, /dev/hdaX is your swap
partition.

5. try STD

# hibernate-disk

>  
> It seems to be linked to the clocking nope ?
> 
> Cheers
> Erwan
> 
