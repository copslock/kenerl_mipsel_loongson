Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2006 18:16:36 +0000 (GMT)
Received: from orca.ele.uri.edu ([131.128.51.63]:10430 "EHLO orca.ele.uri.edu")
	by ftp.linux-mips.org with ESMTP id S8133835AbWCHSQ1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2006 18:16:27 +0000
Received: from [192.168.1.4] (c-71-192-62-254.hsd1.ma.comcast.net [71.192.62.254])
	(authenticated bits=0)
	by orca.ele.uri.edu (8.13.4/8.13.4) with ESMTP id k28IOndI000501
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Wed, 8 Mar 2006 13:24:50 -0500
Subject: Re: [Iscsitarget-devel] mips kernel 2.6.16rc1 + IET 0.4.13 - 
	/dev/ietctl - ioctl unknown command
From:	Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To:	Frederic Temporelli <frederic.temporelli@tele2.fr>
Cc:	iet-dev <iscsitarget-devel@lists.sourceforge.net>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <440F1EB2.8050605@tele2.fr>
References: <440F1EB2.8050605@tele2.fr>
Content-Type: text/plain
Date:	Wed, 08 Mar 2006 13:24:44 -0500
Message-Id: <1141842284.11406.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.52 on 131.128.51.63
Return-Path: <mingz@ele.uri.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingz@ele.uri.edu
Precedence: bulk
X-list: linux-mips

thanks for the catch.

could u show us how u did that bypass? thanks.

ming



On Wed, 2006-03-08 at 19:13 +0100, Frederic Temporelli wrote:
> Hello,
> 
> I would like to report an ioctl issue using IET 0.4.13 (iSCSI target) 
> and kernel 2.6.16-rc1, running on mips / SGI O2
> 
> The driver seems to load nicely, but there was no way to do ioctl on the 
> userspace device /dev/ietctl.
> I got such messages in syslog:
> Mar  4 16:47:16 o2 kernel: [4303606.514000] ioctl32(ietd:3448): Unknown 
> cmd fd(4) cmd(81046900){01} arg(7f942ab0) on /dev/ietctl
> 
> => I've been able to resolve the issue by adding a by-pass (goto 
> do_ioctl) in kernel compat_sys_ioctl function (fs/compat.c)  and all is 
> working fine now.
> 
> I don't know if such issue is related to mips only or is due to changes 
> 2.6.16 kernel
> I've also did some tries on x86 with linux 2.6.15.5, all was working 
> fine without needing to change anything in the kernel.
> 
> Did somebody report such issue with IET and recent kernel ?
> May some people from linux-mips tell if such issue is mips specific ?
> 
> Best regards.
> --
> Fred
> 
> 
