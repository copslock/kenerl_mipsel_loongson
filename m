Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADJcXj23159
	for linux-mips-outgoing; Tue, 13 Nov 2001 11:38:33 -0800
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADJcQ023152
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 11:38:26 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA09684
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 11:38:18 -0800 (PST)
	mail_from (ppopov@mvista.com)
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fADJT7B14108;
	Tue, 13 Nov 2001 11:29:08 -0800
Subject: Re: BE Toolchain
From: Pete Popov <ppopov@mvista.com>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: "H . J . Lu" <hjl@lucon.org>, Dan Temple <dant@mips.com>,
   Linux MIPS
	 <linux-mips@oss.sgi.com>
In-Reply-To: <1005668252.19178.52.camel@localhost.localdomain>
References: <1004708261.31067.6.camel@localhost.localdomain>
	<3BE2A852.AFF0D905@mips.com>
	<1005662974.10352.2.camel@localhost.localdomain>
	<20011113075543.A30676@lucon.org> 
	<1005668252.19178.52.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 13 Nov 2001 11:30:21 -0800
Message-Id: <1005679821.29107.23.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2001-11-13 at 08:17, Marc Karasek wrote:
> I was refering to a formal (supported) release from RH.  Something I can
> pay RH to get support for.

It's hard to make money off of a $60 distribution if you don't have
enough volume, and there isn't enough volume for a mips desktop
distribution.  If you're talking about embedded linux support, Hard Hat
Linux from MontaVista runs on mips, sh, x86, ppc, xscale, and SA. But
we're talking about thousands of dollars for a product subscription.  If
you don't want to pay that type of money for support, I think H.J. Lu
has done a tremendous job in porting rh71, and you always have the
mailing lists.

Pete
 
> On Tue, 2001-11-13 at 10:55, H . J . Lu wrote:
> > On Tue, Nov 13, 2001 at 09:49:20AM -0500, Marc Karasek wrote:
> > > I have one question:  I did not know that RH had a MIPS dist for 7.1. 
> > > Is this something MIPS has done from the RH sources?  Or is RH planning
> > > on supporting MIPS now?
> > > 
> > 
> > Red Hat doesn't have a mips port. It is me who ported RedHat 7.1 to
> > mips.
> > 
> > 
> > H.J.
> > ---
> > My mini-port of RedHat 7.1 is at
> > 
> > ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/
> > 
> > you should be able to put a small RedHat 7.1 on the mips/mipsel box and
> > compile the rest of RedHat 7.1 yourselves.
> > 
> > Here are something you should know:
> > 
> > 1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
> > toolchain rpm. The binary rpms for the mips and mipsel cross compilers
> > are included. You may need glibc 2.2.3-11 or above to use those
> > rpms. The glibc x86 binary rpms under RPMS/i386 should be ok.
> > 2. You have to find a way to put those rpms on your machine. I use
> > network boot and NFS root to do it.
> > 3. install.tar.bz2 has some scripts to prepare NFS root and install
> > RedHat 7.1 on a hard drive.
> > 4. baseline.tar.bz2 contains the cross build tree.
> > 5. Since everything is cross compiled from x86, which is little endian,
> > many data files for mips, which is big endian, are either missing or
> > wrong. To get those data files for mips, you have to rebuild/install
> > the folowing rpms:
> > 
> > cracklib
> > glibc
> > 
> > natively on Linux/mips.
> > 
> > Thanks.
> > 
> > 
> > H.J.
> -- 
> /*************************
> Marc Karasek
> Sr. Firmware Engineer
> iVivity Inc.
> marc_karasek@ivivity.com
> (770) 986-8925
> (770) 986-8926 Fax
> *************************/
> 
