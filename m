Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2006 18:10:45 +0000 (GMT)
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:59581 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8133835AbWCHSKf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2006 18:10:35 +0000
Received: from sj-core-1.cisco.com ([171.71.177.237])
  by sj-iport-2.cisco.com with ESMTP; 08 Mar 2006 10:19:01 -0800
X-IronPort-AV: i="4.02,176,1139212800"; 
   d="scan'208"; a="312671743:sNHT31492536"
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com [128.107.191.63])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id k28IITwP000803;
	Wed, 8 Mar 2006 10:19:00 -0800 (PST)
Received: from xmb-sjc-215.amer.cisco.com ([171.70.151.169]) by xbh-sjc-221.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 8 Mar 2006 10:18:59 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: mips kernel 2.6.16rc1 + IET 0.4.13 -  /dev/ietctl - ioctl unknown command
Date:	Wed, 8 Mar 2006 10:18:57 -0800
Message-ID: <5547014632ED654F971D7E1E0C2E0C3E016546DF@xmb-sjc-215.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mips kernel 2.6.16rc1 + IET 0.4.13 -  /dev/ietctl - ioctl unknown command
Thread-Index: AcZC3Be9zDsVQbxHQv2UPWDtxWtjMwAAF3YQ
From:	"Shanthi Kiran Pendyala \(skiranp\)" <skiranp@cisco.com>
To:	"Frederic Temporelli" <frederic.temporelli@tele2.fr>,
	"iet-dev" <iscsitarget-devel@lists.sourceforge.net>,
	"linux-mips" <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 08 Mar 2006 18:18:59.0828 (UTC) FILETIME=[C5600340:01C642DC]
Return-Path: <skiranp@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skiranp@cisco.com
Precedence: bulk
X-list: linux-mips

I have seen such error messages when userspace app is built in 32bit
mode
And kernel is built in 64 bit mode. Does this apply to your setup ?

The way to fix this is to register a ioctl32 conversion routine in
The driver. Google is your friend..

Thx
Kiran  

>-----Original Message-----
>From: linux-mips-bounce@linux-mips.org 
>[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of 
>Frederic Temporelli
>Sent: Wednesday, March 08, 2006 10:13 AM
>To: iet-dev; linux-mips
>Subject: mips kernel 2.6.16rc1 + IET 0.4.13 - /dev/ietctl - 
>ioctl unknown command
>
>Hello,
>
>I would like to report an ioctl issue using IET 0.4.13 (iSCSI 
>target) and kernel 2.6.16-rc1, running on mips / SGI O2
>
>The driver seems to load nicely, but there was no way to do 
>ioctl on the userspace device /dev/ietctl.
>I got such messages in syslog:
>Mar  4 16:47:16 o2 kernel: [4303606.514000] 
>ioctl32(ietd:3448): Unknown cmd fd(4) cmd(81046900){01} 
>arg(7f942ab0) on /dev/ietctl
>
>=> I've been able to resolve the issue by adding a by-pass (goto
>do_ioctl) in kernel compat_sys_ioctl function (fs/compat.c)  
>and all is working fine now.
>
>I don't know if such issue is related to mips only or is due to changes
>2.6.16 kernel
>I've also did some tries on x86 with linux 2.6.15.5, all was 
>working fine without needing to change anything in the kernel.
>
>Did somebody report such issue with IET and recent kernel ?
>May some people from linux-mips tell if such issue is mips specific ?
>
>Best regards.
>--
>Fred
>
>
>--
>No virus found in this outgoing message.
>Checked by AVG Free Edition.
>Version: 7.1.375 / Virus Database: 268.2.1/277 - Release Date: 
>08/03/2006
>
