Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Nov 2002 22:35:59 +0100 (MET)
Received: from [IPv6:::ffff:206.31.31.227] ([IPv6:::ffff:206.31.31.227]:49331
	"EHLO mx2.mips.com") by ralf.linux-mips.org with ESMTP
	id <S870769AbSK3Vfs>; Sat, 30 Nov 2002 22:35:48 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gAULbDNf003534
	for <linux-mips@linux-mips.org>; Sat, 30 Nov 2002 13:37:14 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id NAA16621
	for <linux-mips@linux-mips.org>; Sat, 30 Nov 2002 13:37:14 -0800 (PST)
Received: from coplin09.mips.com (IDENT:root@coplin09 [192.168.205.79])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gAULbDb20749
	for <linux-mips@linux-mips.org>; Sat, 30 Nov 2002 22:37:14 +0100 (MET)
Received: (from hartvige@localhost)
	by coplin09.mips.com (8.11.6/8.11.6) id gAULbDi30499
	for linux-mips@linux-mips.org; Sat, 30 Nov 2002 22:37:13 +0100
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200211302137.gAULbDi30499@coplin09.mips.com>
Subject: Re: New 7.3 installation kit for MIPS dev boards (fwd)
To: linux-mips@linux-mips.org
Date: Sat, 30 Nov 2002 22:37:13 +0100 (CET)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvige@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvige@mips.com
Precedence: bulk
X-list: linux-mips

Hello Sadik,

your mail address bounces, so I took the liberty to post the reply to
your question on the list. Maybe somebody else could use the answer anyway.

/Hartvig

Forwarded message:
> From hartvige Sat Nov 30 22:32:16 2002
> Subject: Re: New 7.3 installation kit for MIPS dev boards
> To: pallathu.sadik@attbi.com (Pallathu.Sadik)
> Date: Sat, 30 Nov 2002 22:32:16 +0100 (CET)
> In-Reply-To: <no.id> from "Pallathu.Sadik" at Dec 01, 2002 12:02:14 
> X-Mailer: ELM [version 2.5 PL5]
> Content-Length: 1822      
> 
> Hi Sadik,
> 
> it is included in the installation tar file (or iso file). If you
> download one of these, you will find a "kernel" and "installation" tree.
> The cross compiler is located in the kernel tree (together with the
> kernel sources). These RPMs are called:
> 
> /u/hartvige/cdrom7.3/linux> ll kernel/toolchain/
> total 13500
> -rw-r--r--    1 hartvige mips      7123453 Nov 19 11:00 sdelinux-5.01-4eb.i386.rpm
> -rw-r--r--    1 hartvige mips      6670206 Nov 19 11:00 sdelinux-5.01-4.i386.
> 
> The native version is located together will all the other RPMs automatically
> installed on the system:
> 
> /u/hartvige/cdrom7.3/linux> ll installation/RedHat7.3/RPMS/mips*/contrib/sde*
> -rw-r--r--    1 hartvige mips     11607824 Nov 26 09:43 installation/RedHat7.3/RPMS/mips/contrib/sdelinux-5.01-11.mips.rpm
> -rw-r--r--    1 hartvige mips     11567531 Nov 26 09:43 installation/RedHat7.3/RPMS/mipsel/contrib/sdelinux-5.01-11.mipsel.rpm
> 
> These 4 RPMs are currently not separately available on the FTP site, if that
> was what you were looking for?
> 
> /Hartvig
> 
> 
> Pallathu.Sadik writes:
> > 
> > Hello,
> >  
> > > It also includes the new SDE/Linux compiler provided by MIPS, both 
> > > as a native toolchain, as well as a x86 cross version which has been
> > > used for generating the kernels (kernels provided both as precompiled
> > > binaries and complete source tree).
> > > 
> >  
> >   I would appreciate, if you could inform me where the compiler is
> > located.  I did look into the readme files, but couldn't find the info
> > regarding toolchain.
> > 
> > Thanks and regards,
> > 
> > Sadik.
