Received:  by oss.sgi.com id <S553694AbQJSQtz>;
	Thu, 19 Oct 2000 09:49:55 -0700
Received: from gandalf1.physik.uni-konstanz.de ([134.34.144.69]:23053 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553663AbQJSQtc>; Thu, 19 Oct 2000 09:49:32 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 13mIsd-00063d-00; Thu, 19 Oct 2000 18:49:23 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13mIsc-0007sJ-00; Thu, 19 Oct 2000 18:49:22 +0200
Date:   Thu, 19 Oct 2000 18:49:22 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     Dave Garnier <dgarnier@openport.com>,
        SGI news group <linux-mips@oss.sgi.com>
Subject: Re: Indigo2 setup
Message-ID: <20001019184922.A29608@bilbo.physik.uni-konstanz.de>
References: <39EE2D79.D55CA9A7@openport.com> <Pine.SGI.4.10.10010191122440.27617-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.SGI.4.10.10010191122440.27617-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Thu, Oct 19, 2000 at 11:48:47AM -0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 19, 2000 at 11:48:47AM -0300, J. Scott Kasten wrote:
> 
> The issue is slightly more complicated than yes or no.
> 
> It is possible to install and run linux on an SGI without any Irix
> assistance at all.  But you will be stuck netbooting the kernel from a
> bootp/tftp server and then mounting the local disk after receiving the
> kernel from another machine over the network.
Not true anymore. You can partition with a patched fdisk(from Keith) and
put the kernel into the volume-header with a patched dvhtool(patch posted
a few days ago on this list) + a small kernel-patch to parse the
OSLoadPartition prom-variable. See
	http://honk.physik.uni-konstanz.de/~agx/mipslinux/dvhtool/
I could only test this on an Indy since I don't have a hd in my I2. On
the Indy I put 4 kernels into the volume header and could choose freely
between them by using the OSLoader-option in the prom.
Regards,
 -- Guido
