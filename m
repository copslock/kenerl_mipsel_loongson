Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g07Hu3m19802
	for linux-mips-outgoing; Mon, 7 Jan 2002 09:56:03 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g07Htvg19798
	for <linux-mips@oss.sgi.com>; Mon, 7 Jan 2002 09:55:57 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id EBC47125CB; Mon,  7 Jan 2002 08:55:54 -0800 (PST)
Date: Mon, 7 Jan 2002 08:55:54 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Wu Qingbo <wu_qingbo2000@yahoo.com.cn>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: where can I get cross compiler and glibc for mipsel linux
Message-ID: <20020107085554.B2284@lucon.org>
References: <200201071019.g07AJZg31103@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201071019.g07AJZg31103@oss.sgi.com>; from wu_qingbo2000@yahoo.com.cn on Mon, Jan 07, 2002 at 05:20:25PM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 07, 2002 at 05:20:25PM +0800, Wu Qingbo wrote:
> Hi, all,
> 
> I want to install cross compiler on my X86 linux system for mipsel linux.
> Where can I get them? And how to install them?
> Thanks in advance!
> 

You can try my RedHat 7.1.


H.J.
----
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
