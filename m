Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2006 14:11:08 +0000 (GMT)
Received: from orca.ele.uri.edu ([131.128.51.63]:26591 "EHLO orca.ele.uri.edu")
	by ftp.linux-mips.org with ESMTP id S8133603AbWCIOK6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Mar 2006 14:10:58 +0000
Received: from [192.168.1.4] (c-71-192-62-254.hsd1.ma.comcast.net [71.192.62.254])
	(authenticated bits=0)
	by orca.ele.uri.edu (8.13.4/8.13.4) with ESMTP id k29EJQiB030734
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 9 Mar 2006 09:19:26 -0500
Subject: Re: [Iscsitarget-devel] RE: mips kernel 2.6.16rc1 + IET 0.4.13 - 
	/dev/ietctl - ioctl unknown command
From:	Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To:	"Shanthi Kiran Pendyala (skiranp)" <skiranp@cisco.com>
Cc:	Frederic Temporelli <frederic.temporelli@tele2.fr>,
	iet-dev <iscsitarget-devel@lists.sourceforge.net>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <5547014632ED654F971D7E1E0C2E0C3E016546DF@xmb-sjc-215.amer.cisco.com>
References: <5547014632ED654F971D7E1E0C2E0C3E016546DF@xmb-sjc-215.amer.cisco.com>
Content-Type: text/plain
Date:	Thu, 09 Mar 2006 09:19:21 -0500
Message-Id: <1141913962.7361.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.52 on 131.128.51.63
Return-Path: <mingz@ele.uri.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingz@ele.uri.edu
Precedence: bulk
X-list: linux-mips

thanks. i guess this is the reason.

@Frederic, could you confirm this? also if you compile u user space as
64bit, it should be ok then.

ming

On Wed, 2006-03-08 at 10:18 -0800, Shanthi Kiran Pendyala (skiranp)
wrote:
> I have seen such error messages when userspace app is built in 32bit
> mode
> And kernel is built in 64 bit mode. Does this apply to your setup ?
> 
> The way to fix this is to register a ioctl32 conversion routine in
> The driver. Google is your friend..
> 
> Thx
> Kiran  
> 
> >-----Original Message-----
> >From: linux-mips-bounce@linux-mips.org 
> >[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of 
> >Frederic Temporelli
> >Sent: Wednesday, March 08, 2006 10:13 AM
> >To: iet-dev; linux-mips
> >Subject: mips kernel 2.6.16rc1 + IET 0.4.13 - /dev/ietctl - 
> >ioctl unknown command
> >
> >Hello,
> >
> >I would like to report an ioctl issue using IET 0.4.13 (iSCSI 
> >target) and kernel 2.6.16-rc1, running on mips / SGI O2
> >
> >The driver seems to load nicely, but there was no way to do 
> >ioctl on the userspace device /dev/ietctl.
> >I got such messages in syslog:
> >Mar  4 16:47:16 o2 kernel: [4303606.514000] 
> >ioctl32(ietd:3448): Unknown cmd fd(4) cmd(81046900){01} 
> >arg(7f942ab0) on /dev/ietctl
> >
> >=> I've been able to resolve the issue by adding a by-pass (goto
> >do_ioctl) in kernel compat_sys_ioctl function (fs/compat.c)  
> >and all is working fine now.
> >
> >I don't know if such issue is related to mips only or is due to changes
> >2.6.16 kernel
> >I've also did some tries on x86 with linux 2.6.15.5, all was 
> >working fine without needing to change anything in the kernel.
> >
> >Did somebody report such issue with IET and recent kernel ?
> >May some people from linux-mips tell if such issue is mips specific ?
> >
> >Best regards.
> >--
> >Fred
> >
> >
> >--
> >No virus found in this outgoing message.
> >Checked by AVG Free Edition.
> >Version: 7.1.375 / Virus Database: 268.2.1/277 - Release Date: 
> >08/03/2006
> >
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid0944&bid$1720&dat1642
> _______________________________________________
> Iscsitarget-devel mailing list
> Iscsitarget-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/iscsitarget-devel
