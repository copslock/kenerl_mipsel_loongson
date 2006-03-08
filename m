Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2006 19:44:36 +0000 (GMT)
Received: from orca.ele.uri.edu ([131.128.51.63]:5836 "EHLO orca.ele.uri.edu")
	by ftp.linux-mips.org with ESMTP id S8133884AbWCHTn5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2006 19:43:57 +0000
Received: from [192.168.1.4] (c-71-192-62-254.hsd1.ma.comcast.net [71.192.62.254])
	(authenticated bits=0)
	by orca.ele.uri.edu (8.13.4/8.13.4) with ESMTP id k28JqK3u029168
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Wed, 8 Mar 2006 14:52:21 -0500
Subject: Re: [Iscsitarget-devel] mips kernel 2.6.16rc1 + IET 0.4.13 -
	/dev/ietctl - ioctl unknown command
From:	Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To:	Frederic Temporelli <frederic.temporelli@tele2.fr>
Cc:	iet-dev <iscsitarget-devel@lists.sourceforge.net>,
	linux-mips <linux-mips@linux-mips.org>, skiranp@cisco.com
In-Reply-To: <440F337E.3080506@tele2.fr>
References: <440F1EB2.8050605@tele2.fr>
	 <1141842284.11406.69.camel@localhost.localdomain>
	 <440F337E.3080506@tele2.fr>
Content-Type: text/plain; charset=utf-8
Date:	Wed, 08 Mar 2006 14:52:14 -0500
Message-Id: <1141847534.11406.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.52 on 131.128.51.63
Return-Path: <mingz@ele.uri.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingz@ele.uri.edu
Precedence: bulk
X-list: linux-mips

just tested, iet works on 

Linux dopteron.localdomain 2.6.16-rc5 #1 SMP PREEMPT Wed Mar 8 14:11:41
EST 2006 i686 athlon i386 GNU/Linux

so i would think this is a mips specific issue.

ming


On Wed, 2006-03-08 at 20:41 +0100, Frederic Temporelli wrote:
> Hi,
> 
> 
> Here's the bypass (really ugly, just skip the following cmd test and 
> directly go to the vfs_ioctl call later in the func).
> And yes, I'm using a 64bits kernel and app is 32 bits...
> 
> = 8< ==========================
> --- compat.c.git        2006-03-08 20:31:27.000000000 +0100
> +++ compat.c    2006-03-08 20:30:10.000000000 +0100
> @@ -400,6 +400,7 @@ asmlinkage long compat_sys_ioctl(unsigne
>         } else {
>                 static int count;
> 
> +               goto do_ioctl;
>                 if (++count <= 50)
>                         compat_ioctl_error(filp, fd, cmd, arg);
>                 error = -EINVAL;
> = 8< ==========================
> 
> Regards
> --
> Fred
> 
> 
> Ming Zhang a écrit :
> 
> >thanks for the catch.
> >
> >could u show us how u did that bypass? thanks.
> >
> >ming
> >
> >
> >
> >On Wed, 2006-03-08 at 19:13 +0100, Frederic Temporelli wrote:
> >  
> >
> >>Hello,
> >>
> >>I would like to report an ioctl issue using IET 0.4.13 (iSCSI target) 
> >>and kernel 2.6.16-rc1, running on mips / SGI O2
> >>
> >>The driver seems to load nicely, but there was no way to do ioctl on the 
> >>userspace device /dev/ietctl.
> >>I got such messages in syslog:
> >>Mar  4 16:47:16 o2 kernel: [4303606.514000] ioctl32(ietd:3448): Unknown 
> >>cmd fd(4) cmd(81046900){01} arg(7f942ab0) on /dev/ietctl
> >>
> >>=> I've been able to resolve the issue by adding a by-pass (goto 
> >>do_ioctl) in kernel compat_sys_ioctl function (fs/compat.c)  and all is 
> >>working fine now.
> >>
> >>I don't know if such issue is related to mips only or is due to changes 
> >>2.6.16 kernel
> >>I've also did some tries on x86 with linux 2.6.15.5, all was working 
> >>fine without needing to change anything in the kernel.
> >>
> >>Did somebody report such issue with IET and recent kernel ?
> >>May some people from linux-mips tell if such issue is mips specific ?
> >>
> >>Best regards.
> >>--
> >>Fred
> >>
> >>
> >>    
> >>
> >
> >
> >
> >-------------------------------------------------------
> >This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> >that extends applications into web and mobile media. Attend the live webcast
> >and join the prime developer group breaking into this new coding territory!
> >http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> >_______________________________________________
> >Iscsitarget-devel mailing list
> >Iscsitarget-devel@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/iscsitarget-devel
> >
> >  
> >
> 
> 
> 
