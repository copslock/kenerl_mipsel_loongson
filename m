Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADGGUJ08479
	for linux-mips-outgoing; Tue, 13 Nov 2001 08:16:30 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADGGO008470
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 08:16:24 -0800
Received: from [192.168.1.179] (192.168.1.179 [192.168.1.179]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2448.0)
	id QMJCN591; Tue, 13 Nov 2001 11:16:17 -0500
Subject: Re: BE Toolchain
From: Marc Karasek <marc_karasek@ivivity.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Dan Temple <dant@mips.com>, Linux MIPS <linux-mips@oss.sgi.com>
In-Reply-To: <20011113075543.A30676@lucon.org>
References: <1004708261.31067.6.camel@localhost.localdomain>
	<3BE2A852.AFF0D905@mips.com>
	<1005662974.10352.2.camel@localhost.localdomain> 
	<20011113075543.A30676@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 13 Nov 2001 11:17:09 -0500
Message-Id: <1005668252.19178.52.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I was refering to a formal (supported) release from RH.  Something I can
pay RH to get support for.

On Tue, 2001-11-13 at 10:55, H . J . Lu wrote:
> On Tue, Nov 13, 2001 at 09:49:20AM -0500, Marc Karasek wrote:
> > I have one question:  I did not know that RH had a MIPS dist for 7.1. 
> > Is this something MIPS has done from the RH sources?  Or is RH planning
> > on supporting MIPS now?
> > 
> 
> Red Hat doesn't have a mips port. It is me who ported RedHat 7.1 to
> mips.
> 
> 
> H.J.
> ---
> My mini-port of RedHat 7.1 is at
> 
> ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/
> 
> you should be able to put a small RedHat 7.1 on the mips/mipsel box and
> compile the rest of RedHat 7.1 yourselves.
> 
> Here are something you should know:
> 
> 1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
> toolchain rpm. The binary rpms for the mips and mipsel cross compilers
> are included. You may need glibc 2.2.3-11 or above to use those
> rpms. The glibc x86 binary rpms under RPMS/i386 should be ok.
> 2. You have to find a way to put those rpms on your machine. I use
> network boot and NFS root to do it.
> 3. install.tar.bz2 has some scripts to prepare NFS root and install
> RedHat 7.1 on a hard drive.
> 4. baseline.tar.bz2 contains the cross build tree.
> 5. Since everything is cross compiled from x86, which is little endian,
> many data files for mips, which is big endian, are either missing or
> wrong. To get those data files for mips, you have to rebuild/install
> the folowing rpms:
> 
> cracklib
> glibc
> 
> natively on Linux/mips.
> 
> Thanks.
> 
> 
> H.J.
-- 
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
