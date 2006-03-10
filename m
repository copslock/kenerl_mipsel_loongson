Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2006 19:26:38 +0000 (GMT)
Received: from mailfe05.tele2.fr ([212.247.154.140]:58010 "EHLO swip.net")
	by ftp.linux-mips.org with ESMTP id S8133967AbWCJT02 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2006 19:26:28 +0000
X-T2-Posting-ID: g63wq726D5fsXb2UbU6LU0KOXzHnTHjCzHZ35sC2MDs=
X-Cloudmark-Score: 0.000000 []
Received: from [83.179.129.29] (HELO [192.168.0.32])
  by mailfe05.swip.net (CommuniGate Pro SMTP 5.0.8)
  with ESMTP id 49065700; Fri, 10 Mar 2006 20:35:04 +0100
Received: from 127.0.0.1 (AVG SMTP 7.1.375 [268.2.1/279]); Fri, 10 Mar 2006 20:35:05 +0100
Message-ID: <4411D4E8.4060001@tele2.fr>
Date:	Fri, 10 Mar 2006 20:35:04 +0100
From:	Frederic Temporelli <frederic.temporelli@tele2.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.7.12) Gecko/20050915
X-Accept-Language: fr, en
To:	mingz@ele.uri.edu
CC:	"Shanthi Kiran Pendyala (skiranp)" <skiranp@cisco.com>,
	iet-dev <iscsitarget-devel@lists.sourceforge.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [Iscsitarget-devel] RE: mips kernel 2.6.16rc1 + IET 0.4.13 -
 	/dev/ietctl - ioctl unknown command
References: <5547014632ED654F971D7E1E0C2E0C3E016546DF@xmb-sjc-215.amer.cisco.com> <1141913962.7361.39.camel@localhost.localdomain>
In-Reply-To: <1141913962.7361.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-Path: <frederic.temporelli@tele2.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frederic.temporelli@tele2.fr
Precedence: bulk
X-list: linux-mips

Hi,

Sorry, I'm not able to build 64 bits user space binaries (Debian distro, 
where all binaries are 32 bits... ld is reporting errors when I try to 
link using o64 and n64 ABIs, seems that only the kernel can be 64 bits).

But don't care, on my side it was just to do a test to IET.
I'll try do test it at work on IA64...
--
Fred

Ming Zhang a écrit :

>thanks. i guess this is the reason.
>
>@Frederic, could you confirm this? also if you compile u user space as
>64bit, it should be ok then.
>
>ming
>
>On Wed, 2006-03-08 at 10:18 -0800, Shanthi Kiran Pendyala (skiranp)
>wrote:
>  
>
>>I have seen such error messages when userspace app is built in 32bit
>>mode
>>And kernel is built in 64 bit mode. Does this apply to your setup ?
>>
>>The way to fix this is to register a ioctl32 conversion routine in
>>The driver. Google is your friend..
>>
>>Thx
>>Kiran  
>>
>>    
>>
>>>-----Original Message-----
>>>From: linux-mips-bounce@linux-mips.org 
>>>[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of 
>>>Frederic Temporelli
>>>Sent: Wednesday, March 08, 2006 10:13 AM
>>>To: iet-dev; linux-mips
>>>Subject: mips kernel 2.6.16rc1 + IET 0.4.13 - /dev/ietctl - 
>>>ioctl unknown command
>>>
>>>Hello,
>>>
>>>I would like to report an ioctl issue using IET 0.4.13 (iSCSI 
>>>target) and kernel 2.6.16-rc1, running on mips / SGI O2
>>>
>>>The driver seems to load nicely, but there was no way to do 
>>>ioctl on the userspace device /dev/ietctl.
>>>I got such messages in syslog:
>>>Mar  4 16:47:16 o2 kernel: [4303606.514000] 
>>>ioctl32(ietd:3448): Unknown cmd fd(4) cmd(81046900){01} 
>>>arg(7f942ab0) on /dev/ietctl
>>>
>>>=> I've been able to resolve the issue by adding a by-pass (goto
>>>do_ioctl) in kernel compat_sys_ioctl function (fs/compat.c)  
>>>and all is working fine now.
>>>
>>>I don't know if such issue is related to mips only or is due to changes
>>>2.6.16 kernel
>>>I've also did some tries on x86 with linux 2.6.15.5, all was 
>>>working fine without needing to change anything in the kernel.
>>>
>>>Did somebody report such issue with IET and recent kernel ?
>>>May some people from linux-mips tell if such issue is mips specific ?
>>>
>>>Best regards.
>>>--
>>>Fred
>>>
>>>
>>>--
>>>No virus found in this outgoing message.
>>>Checked by AVG Free Edition.
>>>Version: 7.1.375 / Virus Database: 268.2.1/277 - Release Date: 
>>>08/03/2006
>>>
>>>      
>>>
>>-------------------------------------------------------
>>This SF.Net email is sponsored by xPML, a groundbreaking scripting language
>>that extends applications into web and mobile media. Attend the live webcast
>>and join the prime developer group breaking into this new coding territory!
>>http://sel.as-us.falkag.net/sel?cmd=lnk&kid0944&bid$1720&dat1642
>>_______________________________________________
>>Iscsitarget-devel mailing list
>>Iscsitarget-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/iscsitarget-devel
>>    
>>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by xPML, a groundbreaking scripting language
>that extends applications into web and mobile media. Attend the live webcast
>and join the prime developer group breaking into this new coding territory!
>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
>_______________________________________________
>Iscsitarget-devel mailing list
>Iscsitarget-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/iscsitarget-devel
>
>  
>



-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.375 / Virus Database: 268.2.1/279 - Release Date: 10/03/2006
