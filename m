Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAMJHwv22920
	for linux-mips-outgoing; Thu, 22 Nov 2001 11:17:58 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAMJHro22897
	for <linux-mips@oss.sgi.com>; Thu, 22 Nov 2001 11:17:53 -0800
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id 4DA75125C3; Thu, 22 Nov 2001 10:17:52 -0800 (PST)
Received: by lucon.org (Postfix, from userid 1000)
	id 78DB7EBC9; Thu, 22 Nov 2001 10:17:51 -0800 (PST)
Date: Thu, 22 Nov 2001 10:17:51 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Cross Compiler again
Message-ID: <20011122101751.A1682@lucon.org>
References: <86048F07C015D311864100902760F1DD01B5E3CE@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E3CE@dlfw003a.dus.infineon.com>; from Andre.Messerschmidt@infineon.com on Thu, Nov 22, 2001 at 01:42:32PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 22, 2001 at 01:42:32PM +0100, Andre.Messerschmidt@infineon.com wrote:
> 
> > May I ask why you want dwarf? FWIW, gcc 2.96 in my RedHat 7.1 mips port
> > supports dwarf, but not as default. I don't know how well it works with
> > dwarf. Yes, both cross compiler running on RedHat/x86 7.1/7.2 and
> > native compiler are provided in my mips port.
> > 
> I need dwarf support because my debugger only supports dwarf. (It is an
> integrated simulation environment, where I cannot change the debugger to
> gdb).
> 
> Do you have a download link for your mips port?
> 
> regards
> Andre

My mini-port of RedHat 7.1 is at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

you should be able to put a small RedHat 7.1 on the mips/mipsel box and
compile the rest of RedHat 7.1 yourselves.

Here are something you should know:

1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included. You may need glibc 2.2.3-11 or above to use those
rpms. The glibc x86 binary rpms under RPMS/i386 should be ok.
2. You have to find a way to put those rpms on your machine. I use
network boot and NFS root to do it.
3. install.tar.bz2 has some scripts to prepare NFS root and install
RedHat 7.1 on a hard drive.
4. baseline.tar.bz2 contains the cross build tree.
5. Since everything is cross compiled from x86, which is little endian,
many data files for mips, which is big endian, are either missing or
wrong. To get those data files for mips, you have to rebuild/install
the folowing rpms:

cracklib
glibc

natively on Linux/mips.

Thanks.


H.J.
