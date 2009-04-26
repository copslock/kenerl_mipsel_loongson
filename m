Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Apr 2009 18:21:26 +0100 (BST)
Received: from mail.rennes.fr.clara.net ([62.240.254.62]:56293 "EHLO
	rennes.fr.clara.net" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20024643AbZDZRVS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 26 Apr 2009 18:21:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by rennes.fr.clara.net (Postfix) with ESMTP id 69F843A452;
	Sun, 26 Apr 2009 19:21:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from rennes.fr.clara.net ([127.0.0.1])
	by localhost (rennes.fr.clara.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id He4cRSnM64Jx; Sun, 26 Apr 2009 19:20:42 +0200 (CEST)
Received: from [192.168.0.7] (chl35-1-88-163-125-22.fbx.proxad.net [88.163.125.22])
	by rennes.fr.clara.net (Postfix) with ESMTP id 9303139B20;
	Sun, 26 Apr 2009 19:20:41 +0200 (CEST)
Message-ID: <49F497E9.7080803@thiscow.com>
Date:	Sun, 26 Apr 2009 19:20:41 +0200
From:	Erwan Lerale <erwan@thiscow.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com
CC:	loongson-dev@googlegroups.com, yanh@lemote.com, zhangfx@lemote.com,
	penglj@lemote.com, huhb@lemote.com, taohl@lemote.com,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [loongson-dev] Re: a pre-release of merging loongson patchs to
 linux-2.6.29.1
References: <1240501332.28136.24.camel@falcon>	 <49F0AFA3.6080408@thiscow.com> <1240535343.25824.14.camel@falcon>	 <49F16061.9010207@thiscow.com> <1240556617.23345.10.camel@falcon>	 <49F217E1.8080808@thiscow.fr> <1240640248.25540.27.camel@falcon>
In-Reply-To: <1240640248.25540.27.camel@falcon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <erwan@thiscow.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erwan@thiscow.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin a écrit :
>> I don't understand why some stuff are not included in
>> arch/mips/configs/yeeloong2f_defconfig,
>> for example the sound chip or the v4l stuff for the webcam.
>>
>>     
>
> I just updated the default kernel configuration file for loongson2f
> based machines, hope it can help you :-)
>   

Yeap you have include many things now, it takes more time to compile
but at least some basic stuff are not missing anymore :)


>> - compile external wifi modules from
>>  
>> http://www.lemote.com/upfiles/wifi/rtl8187B_linux_26.1049.1215.2008_release2.tar.gz
>>
>>   to get proper Wifi performances (or I had to sit on the access point)
>>     

Does everybody has the same issue, I mean bad performances when using the
rtl8187 module that is included in the kernel ?


>> - get and compile the ec_module stuff from git
>>     

Cool, i could even break my box from the CLI now :

Flash flash device: 80000 at 1fc00000
flash device: Found 1 x8 devices at 0x0 in 8-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 1 MTD partitions on "flash device":
0x000000000000-0x000000080000 : "Bootloader"
pmon flash device initialized

:)


>> The box is also complaining when it boots and try to set time :
>>
>> xiwen ~ (n32) # hwclock  --debug
>> hwclock from util-linux-ng 2.14.2
>> hwclock: Open of /dev/rtc failed, errno=2: No such file or directory.
>> No usable clock interface found.
>> Cannot access the Hardware Clock via any known method.
>>
>>     
>
> the previous kernel configuration file not include the "Real Time
> Clock", so, no /dev/rtc there, so sorry :-)   
>   

Yeah i'm stupid i should have config that...


>> What has to be included in the config tree to get suspend/hibernate and 
>> cpu_freq working  ?
>>     
>
> * try the following configuration options:
>
> Machine selection  --->
>              [*] Using cs5536's MFGPT as system clock
>
> Power management options  --->
>              [*] Power Management support 
>              [*] Suspend to RAM and standby
>              [*] Hibernation (aka 'suspend to disk')              
>              (/dev/hda3) Default resume partition               
>
> CPU Frequency scaling  --->
>              [*] CPU Frequency scaling
>              [*]   Loongson-2F CPU Frequency driver            
>              
>
> * basic user manual(from www.lemote.com):
>
> 1. install a shell script 
>
> # apt-get install hibernate
>
> 2. modify the configuration file /etc/hibernate/common.conf
>
> * find the "UnloadModules" section, modify it like this
>
> UnloadModules r8187 usbhid ohci_hcd ehci_hcd
>
> remove the # before "LoadModules auto"
>
> * modify the "network" section
>
> DownInterfaces eth0
> UpInterfaces auto
>
> * modify the "hardware_tweaks" section
>
> remove the # before "FullSpeedCPU yes"
>
> 3. prepare a swap partition, by default, it is configured in kernel
> as /dev/hda3
>
> change it to yours swap partition in kernel or configure it
> via /sys/power/resume, for example:
>
> # fdisk -l | grep swap | cut -d' ' -f1
> /dev/sda5
> # ls -l /dev/sda5
> brw-rw---- 1 root disk 8, 5 2009-04-10 10:26 /dev/sda5
> # echo 8:5 > /sys/power/resume
>
> 4. resume
>
> pass an argument "resume=/dev/hdaX" to kernel, /dev/hdaX is your swap
> partition.
>
> 5. try STD
>
> # hibernate-disk
>   
emerge hibernate-script and configure the system like you have said. The 
box is reacting now.

There's no hibernate-disk on gentoo, just hibernate or hibernate-ram.

Starting suspend at Sun Apr 26 17:56:52 CEST 2009
hibernate: [01] Executing CheckLastResume ...
hibernate: [01] Executing CheckRunlevel ...
hibernate: [01] Executing LockFileGet ...
hibernate: [01] Executing NewKernelFileCheck ...
hibernate: [10] Executing EnsureSysfsPowerStateCapable ...
hibernate: [11] Executing XHacksSuspendHook1 ...
hibernate: [59] Executing RemountXFSBootRO ...
hibernate: [60] Executing NetworkStop ...
Bringing down interface eth0
* Bringing down interface eth0
*   Stopping ifplugd on eth0... [ ok ]
*   Removing addresses
Bringing down interface wlan0
* Bringing down interface wlan0
*   Stopping dhcpcd on wlan0... [ ok ]
*   Removing addresses
hibernate: [89] Executing SaveKernelModprobe ...
Saved /proc/sys/kernel/modprobe is /sbin/modprobe
hibernate: [90] Executing ModulesUnload ...
Unloading module r8187...Removing modules with rmmod.

Unloading module usbhid...not loaded.
Unloading module ohci_hcd...
Unloading module ehci_hcd...not loaded.
Unloading module r8187...not loaded.
Unloading module usbhid...not loaded.
Unloading module ohci_hcd...not loaded.
Unloading module ehci_hcd...not loaded.
hibernate: [91] Executing ModulesUnloadBlacklist ...
Unloading blacklisted modules listed /etc/hibernate/blacklisted-modules
Module version for ipw2100 is
Module version for ipw2200 is
Module version for snd_bt_sco is
Module version for ndiswrapper is
Unloading blacklisted module uvcvideo (and dependencies)
Unloading uvcvideo ...
hibernate: [91] Executing ModulesUnloadBlacklist ...
Unloading blacklisted modules listed /etc/hibernate/blacklisted-modules
Module version for ipw2100 is
Module version for ipw2200 is
Module version for snd_bt_sco is
Module version for ndiswrapper is
hibernate: [95] Executing XHacksSuspendHook2 ...
xhacks: changing console from 2 to 15
hibernate: [98] Executing CheckRunlevel ...
hibernate: [98] Executing FullSpeedCPUSuspend ...
Switched to performance, with min freq at 797000
hibernate: [99] Executing DoSysfsPowerStateSuspend ...
hibernate: Activating sysfs power state disk ...


But when the machine is rebooting, I can see :

hibernate: Activating sysfs power state disk...
+ '[' -n '' ']'
+ /bin/echo -n disk

and even switch from one vt to another but I cannot type anything.

The only solution is too reboot... Maybe I got to read more man 5 
hibernate.conf :)

If I try the hibernate-ram script, no more chance :

xiwen ~ (n32) # hibernate-ram
hibernate-ram: Trying method in sysfs-ram.conf...
hibernate-ram: Including configuration from common.conf
hibernate-ram: No suitable suspend methods were found on your machine.
hibernate-ram: You need to install a kernel with support for suspending to
hibernate-ram: disk or RAM and reboot, then try again.

or

xiwen ~ (n32) # echo -n mem > /sys/power/state
bash: echo: write error: No such device


Now, let's talk about the cpufreq stuff :)

cpufrequtils 005: cpufreq-info (C) Dominik Brodowski 2004-2006
Report errors and bugs to cpufreq@vger.kernel.org, please.
analyzing CPU 0:
  driver: loongson2f
  CPUs which need to switch frequency at the same time: 0
  hardware limits: 199 MHz - 797 MHz
  available frequency steps: 199 MHz, 299 MHz, 398 MHz, 498 MHz, 598 
MHz, 697 MHz, 797 MHz
  available cpufreq governors: conservative, ondemand, userspace, 
powersave, performance
  current policy: frequency should be within 199 MHz and 797 MHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 797 MHz (asserted by call to hardware).
  cpufreq stats: 199 MHz:0.00%, 299 MHz:0.00%, 398 MHz:0.00%, 498 
MHz:0.00%, 598 MHz:0.00%, 697 MHz:0.00%, 797 MHz:100.00%

It seems to be working but it's weird. When I start X and gnome (cpufreq 
applet). I can see
that's the system is using the ondemand performance but is stuck at 797 
Mhz if I don't do anything.
If i start working (yeah it's happening sometimes), the frequency is 
moving from 199Mhz to 797Mhz.

The other thing which is weird is that I don't have this problem with 
the Loonux stock kernel.

Btw, I have heard of an overcloking module ? is that working ? where's 
the source code ? I want
to reach the speed of 900 Mhz :)

What about the power button ? Even on Loonux, the box is not asking for 
shutdown when I press it.

Do you know where I can find the source code of the binary for the osd 
stuff to work (/usr/bin/fnkey) ?

Sorry for this big mail, all this question (more or less stupid) :)

Cheers
r1
