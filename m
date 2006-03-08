Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2006 19:43:49 +0000 (GMT)
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:37404 "EHLO
	sj-iport-3.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8133867AbWCHTnh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2006 19:43:37 +0000
Received: from sj-core-1.cisco.com ([171.71.177.237])
  by sj-iport-3.cisco.com with ESMTP; 08 Mar 2006 11:52:03 -0800
X-IronPort-AV: i="4.02,176,1139212800"; 
   d="scan'208"; a="413640878:sNHT32995212"
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id k28Jq0w3002637;
	Wed, 8 Mar 2006 11:52:02 -0800 (PST)
Received: from xmb-sjc-215.amer.cisco.com ([171.70.151.169]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 8 Mar 2006 11:52:01 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Iscsitarget-devel] mips kernel 2.6.16rc1 + IET 0.4.13 - 	/dev/ietctl - ioctl unknown command
Date:	Wed, 8 Mar 2006 11:52:01 -0800
Message-ID: <5547014632ED654F971D7E1E0C2E0C3E01654777@xmb-sjc-215.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Iscsitarget-devel] mips kernel 2.6.16rc1 + IET 0.4.13 - 	/dev/ietctl - ioctl unknown command
Thread-Index: AcZC6GDxfUYbB21ZRIS2AVseFJWRmwAAQq6g
From:	"Shanthi Kiran Pendyala \(skiranp\)" <skiranp@cisco.com>
To:	"Frederic Temporelli" <frederic.temporelli@tele2.fr>,
	<mingz@ele.uri.edu>
Cc:	"iet-dev" <iscsitarget-devel@lists.sourceforge.net>,
	"linux-mips" <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 08 Mar 2006 19:52:01.0914 (UTC) FILETIME=[C48EBDA0:01C642E9]
Return-Path: <skiranp@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skiranp@cisco.com
Precedence: bulk
X-list: linux-mips

If kernel is 64bit and app is 32bit the size of ioctl structures exchanged
Between userspace and kernel space will be different if you use data types
Like pointer, long, size_t etc.,

Here is LWN article which explains the register_ioctl32_conversion routine
That you need to use.

http://lwn.net/Articles/115651/

Thx
Kiran 
 

>-----Original Message-----
>From: Frederic Temporelli [mailto:frederic.temporelli@tele2.fr] 
>Sent: Wednesday, March 08, 2006 11:42 AM
>To: mingz@ele.uri.edu
>Cc: iet-dev; linux-mips; Shanthi Kiran Pendyala (skiranp)
>Subject: Re: [Iscsitarget-devel] mips kernel 2.6.16rc1 + IET 
>0.4.13 - /dev/ietctl - ioctl unknown command
>
>Hi,
>
>
>Here's the bypass (really ugly, just skip the following cmd 
>test and directly go to the vfs_ioctl call later in the func).
>And yes, I'm using a 64bits kernel and app is 32 bits...
>
>= 8< ==========================
>--- compat.c.git        2006-03-08 20:31:27.000000000 +0100
>+++ compat.c    2006-03-08 20:30:10.000000000 +0100
>@@ -400,6 +400,7 @@ asmlinkage long compat_sys_ioctl(unsigne
>        } else {
>                static int count;
>
>+               goto do_ioctl;
>                if (++count <= 50)
>                        compat_ioctl_error(filp, fd, cmd, arg);
>                error = -EINVAL;
>= 8< ==========================
>
>Regards
>--
>Fred
>
>
>Ming Zhang a écrit :
>
>>thanks for the catch.
>>
>>could u show us how u did that bypass? thanks.
>>
>>ming
>>
>>
>>
>>On Wed, 2006-03-08 at 19:13 +0100, Frederic Temporelli wrote:
>>  
>>
>>>Hello,
>>>
>>>I would like to report an ioctl issue using IET 0.4.13 
>(iSCSI target) 
>>>and kernel 2.6.16-rc1, running on mips / SGI O2
>>>
>>>The driver seems to load nicely, but there was no way to do ioctl on 
>>>the userspace device /dev/ietctl.
>>>I got such messages in syslog:
>>>Mar  4 16:47:16 o2 kernel: [4303606.514000] ioctl32(ietd:3448): 
>>>Unknown cmd fd(4) cmd(81046900){01} arg(7f942ab0) on /dev/ietctl
>>>
>>>=> I've been able to resolve the issue by adding a by-pass (goto
>>>do_ioctl) in kernel compat_sys_ioctl function (fs/compat.c)  and all 
>>>is working fine now.
>>>
>>>I don't know if such issue is related to mips only or is due to 
>>>changes
>>>2.6.16 kernel
>>>I've also did some tries on x86 with linux 2.6.15.5, all was working 
>>>fine without needing to change anything in the kernel.
>>>
>>>Did somebody report such issue with IET and recent kernel ?
>>>May some people from linux-mips tell if such issue is mips specific ?
>>>
>>>Best regards.
>>>--
>>>Fred
>>>
>>>
>>>    
>>>
>>
>>
>>
>>-------------------------------------------------------
>>This SF.Net email is sponsored by xPML, a groundbreaking scripting 
>>language that extends applications into web and mobile media. Attend 
>>the live webcast and join the prime developer group breaking 
>into this new coding territory!
>>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&
>dat=12164
>>2 _______________________________________________
>>Iscsitarget-devel mailing list
>>Iscsitarget-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/iscsitarget-devel
>>
>>  
>>
>
>
>
>--
>No virus found in this outgoing message.
>Checked by AVG Free Edition.
>Version: 7.1.375 / Virus Database: 268.2.1/277 - Release Date: 
>08/03/2006
>
