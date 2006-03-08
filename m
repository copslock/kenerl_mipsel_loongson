Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2006 19:33:40 +0000 (GMT)
Received: from mailfe01.tele2.fr ([212.247.154.12]:31117 "EHLO swip.net")
	by ftp.linux-mips.org with ESMTP id S8133879AbWCHTd1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2006 19:33:27 +0000
X-T2-Posting-ID: g63wq726D5fsXb2UbU6LU0KOXzHnTHjCzHZ35sC2MDs=
X-Cloudmark-Score: 0.000000 []
Received: from [83.179.129.29] (HELO [192.168.0.32])
  by mailfe01.swip.net (CommuniGate Pro SMTP 5.0.8)
  with ESMTP id 126917820; Wed, 08 Mar 2006 20:41:51 +0100
Received: from 127.0.0.1 (AVG SMTP 7.1.375 [268.2.1/277]); Wed, 08 Mar 2006 20:41:50 +0100
Message-ID: <440F337E.3080506@tele2.fr>
Date:	Wed, 08 Mar 2006 20:41:50 +0100
From:	Frederic Temporelli <frederic.temporelli@tele2.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.7.12) Gecko/20050915
X-Accept-Language: fr, en
To:	mingz@ele.uri.edu
CC:	iet-dev <iscsitarget-devel@lists.sourceforge.net>,
	linux-mips <linux-mips@linux-mips.org>, skiranp@cisco.com
Subject: Re: [Iscsitarget-devel] mips kernel 2.6.16rc1 + IET 0.4.13 - 	/dev/ietctl
 - ioctl unknown command
References: <440F1EB2.8050605@tele2.fr> <1141842284.11406.69.camel@localhost.localdomain>
In-Reply-To: <1141842284.11406.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-Path: <frederic.temporelli@tele2.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frederic.temporelli@tele2.fr
Precedence: bulk
X-list: linux-mips

Hi,


Here's the bypass (really ugly, just skip the following cmd test and 
directly go to the vfs_ioctl call later in the func).
And yes, I'm using a 64bits kernel and app is 32 bits...

= 8< ==========================
--- compat.c.git        2006-03-08 20:31:27.000000000 +0100
+++ compat.c    2006-03-08 20:30:10.000000000 +0100
@@ -400,6 +400,7 @@ asmlinkage long compat_sys_ioctl(unsigne
        } else {
                static int count;

+               goto do_ioctl;
                if (++count <= 50)
                        compat_ioctl_error(filp, fd, cmd, arg);
                error = -EINVAL;
= 8< ==========================

Regards
--
Fred


Ming Zhang a écrit :

>thanks for the catch.
>
>could u show us how u did that bypass? thanks.
>
>ming
>
>
>
>On Wed, 2006-03-08 at 19:13 +0100, Frederic Temporelli wrote:
>  
>
>>Hello,
>>
>>I would like to report an ioctl issue using IET 0.4.13 (iSCSI target) 
>>and kernel 2.6.16-rc1, running on mips / SGI O2
>>
>>The driver seems to load nicely, but there was no way to do ioctl on the 
>>userspace device /dev/ietctl.
>>I got such messages in syslog:
>>Mar  4 16:47:16 o2 kernel: [4303606.514000] ioctl32(ietd:3448): Unknown 
>>cmd fd(4) cmd(81046900){01} arg(7f942ab0) on /dev/ietctl
>>
>>=> I've been able to resolve the issue by adding a by-pass (goto 
>>do_ioctl) in kernel compat_sys_ioctl function (fs/compat.c)  and all is 
>>working fine now.
>>
>>I don't know if such issue is related to mips only or is due to changes 
>>2.6.16 kernel
>>I've also did some tries on x86 with linux 2.6.15.5, all was working 
>>fine without needing to change anything in the kernel.
>>
>>Did somebody report such issue with IET and recent kernel ?
>>May some people from linux-mips tell if such issue is mips specific ?
>>
>>Best regards.
>>--
>>Fred
>>
>>
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
Version: 7.1.375 / Virus Database: 268.2.1/277 - Release Date: 08/03/2006
