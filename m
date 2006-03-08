Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2006 19:54:47 +0000 (GMT)
Received: from orca.ele.uri.edu ([131.128.51.63]:36301 "EHLO orca.ele.uri.edu")
	by ftp.linux-mips.org with ESMTP id S8133867AbWCHTyg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2006 19:54:36 +0000
Received: from [192.168.1.4] (c-71-192-62-254.hsd1.ma.comcast.net [71.192.62.254])
	(authenticated bits=0)
	by orca.ele.uri.edu (8.13.4/8.13.4) with ESMTP id k28K2xgq032119
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Wed, 8 Mar 2006 15:03:00 -0500
Subject: RE: [Iscsitarget-devel] mips kernel 2.6.16rc1 + IET 0.4.13 -
	/dev/ietctl - ioctl unknown command
From:	Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To:	"Shanthi Kiran Pendyala (skiranp)" <skiranp@cisco.com>
Cc:	Frederic Temporelli <frederic.temporelli@tele2.fr>,
	iet-dev <iscsitarget-devel@lists.sourceforge.net>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <5547014632ED654F971D7E1E0C2E0C3E01654777@xmb-sjc-215.amer.cisco.com>
References: <5547014632ED654F971D7E1E0C2E0C3E01654777@xmb-sjc-215.amer.cisco.com>
Content-Type: text/plain; charset=utf-8
Date:	Wed, 08 Mar 2006 15:02:54 -0500
Message-Id: <1141848174.11406.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.52 on 131.128.51.63
Return-Path: <mingz@ele.uri.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingz@ele.uri.edu
Precedence: bulk
X-list: linux-mips

we use unlock_ioctl and we only have u32 u64 like data in the
structures.

anyway i dig out this email
http://sourceforge.net/mailarchive/message.php?msg_id=13230597

u might meet same issue.

Ming


On Wed, 2006-03-08 at 11:52 -0800, Shanthi Kiran Pendyala (skiranp)
wrote:
> If kernel is 64bit and app is 32bit the size of ioctl structures exchanged
> Between userspace and kernel space will be different if you use data types
> Like pointer, long, size_t etc.,
> 
> Here is LWN article which explains the register_ioctl32_conversion routine
> That you need to use.
> 
> http://lwn.net/Articles/115651/
> 
> Thx
> Kiran 
>  
> 
> >-----Original Message-----
> >From: Frederic Temporelli [mailto:frederic.temporelli@tele2.fr] 
> >Sent: Wednesday, March 08, 2006 11:42 AM
> >To: mingz@ele.uri.edu
> >Cc: iet-dev; linux-mips; Shanthi Kiran Pendyala (skiranp)
> >Subject: Re: [Iscsitarget-devel] mips kernel 2.6.16rc1 + IET 
> >0.4.13 - /dev/ietctl - ioctl unknown command
> >
> >Hi,
> >
> >
> >Here's the bypass (really ugly, just skip the following cmd 
> >test and directly go to the vfs_ioctl call later in the func).
> >And yes, I'm using a 64bits kernel and app is 32 bits...
> >
> >= 8< ==========================
> >--- compat.c.git        2006-03-08 20:31:27.000000000 +0100
> >+++ compat.c    2006-03-08 20:30:10.000000000 +0100
> >@@ -400,6 +400,7 @@ asmlinkage long compat_sys_ioctl(unsigne
> >        } else {
> >                static int count;
> >
> >+               goto do_ioctl;
> >                if (++count <= 50)
> >                        compat_ioctl_error(filp, fd, cmd, arg);
> >                error = -EINVAL;
> >= 8< ==========================
> >
> >Regards
> >--
> >Fred
> >
> >
> >Ming Zhang a écrit :
> >
> >>thanks for the catch.
> >>
> >>could u show us how u did that bypass? thanks.
> >>
> >>ming
> >>
> >>
> >>
> >>On Wed, 2006-03-08 at 19:13 +0100, Frederic Temporelli wrote:
> >>  
> >>
> >>>Hello,
> >>>
> >>>I would like to report an ioctl issue using IET 0.4.13 
> >(iSCSI target) 
> >>>and kernel 2.6.16-rc1, running on mips / SGI O2
> >>>
> >>>The driver seems to load nicely, but there was no way to do ioctl on 
> >>>the userspace device /dev/ietctl.
> >>>I got such messages in syslog:
> >>>Mar  4 16:47:16 o2 kernel: [4303606.514000] ioctl32(ietd:3448): 
> >>>Unknown cmd fd(4) cmd(81046900){01} arg(7f942ab0) on /dev/ietctl
> >>>
> >>>=> I've been able to resolve the issue by adding a by-pass (goto
> >>>do_ioctl) in kernel compat_sys_ioctl function (fs/compat.c)  and all 
> >>>is working fine now.
> >>>
> >>>I don't know if such issue is related to mips only or is due to 
> >>>changes
> >>>2.6.16 kernel
> >>>I've also did some tries on x86 with linux 2.6.15.5, all was working 
> >>>fine without needing to change anything in the kernel.
> >>>
> >>>Did somebody report such issue with IET and recent kernel ?
> >>>May some people from linux-mips tell if such issue is mips specific ?
> >>>
> >>>Best regards.
> >>>--
> >>>Fred
> >>>
> >>>
> >>>    
> >>>
> >>
> >>
> >>
> >>-------------------------------------------------------
> >>This SF.Net email is sponsored by xPML, a groundbreaking scripting 
> >>language that extends applications into web and mobile media. Attend 
> >>the live webcast and join the prime developer group breaking 
> >into this new coding territory!
> >>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&
> >dat=12164
> >>2 _______________________________________________
> >>Iscsitarget-devel mailing list
> >>Iscsitarget-devel@lists.sourceforge.net
> >>https://lists.sourceforge.net/lists/listinfo/iscsitarget-devel
> >>
> >>  
> >>
> >
> >
> >
> >--
> >No virus found in this outgoing message.
> >Checked by AVG Free Edition.
> >Version: 7.1.375 / Virus Database: 268.2.1/277 - Release Date: 
> >08/03/2006
> >
