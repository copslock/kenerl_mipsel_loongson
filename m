Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78EwSH10704
	for linux-mips-outgoing; Wed, 8 Aug 2001 07:58:28 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78EwQV10693
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 07:58:26 -0700
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15UUmv-0003jj-00; Wed, 08 Aug 2001 16:58:25 +0200
Date: Wed, 8 Aug 2001 16:58:25 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
Message-ID: <20010808165825.B25627@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips <linux-mips@oss.sgi.com>
References: <20010808154246.A25205@gandalf.physik.uni-konstanz.de> <Pine.OSF.4.33.0108081039480.6638-100000@grover.WPI.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.OSF.4.33.0108081039480.6638-100000@grover.WPI.EDU>; from ian@WPI.EDU on Wed, Aug 08, 2001 at 10:46:24AM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 10:46:24AM -0400, Ian wrote:
> > You simply need to recreate a sgi partition table which is no problem
> > with a current fdisk. That's all you need  to make linux bootable from
> > harddisk.
> 
> Right.  But how to I get to that point?  There is NO bootloader?  I have
> no Irix 6.x media available to restore those partitions.
E.g. use the base system at:
 ftp://ftp.uni-mainz.de/pub/Linux/debian-local/mips/
with a kernel from:
 ftp://ftp.rfc822.org/pub/local/debian-mips/kernel
or the debian "bootdisks" consisting of a small nfs-root and kernel at:
 http://honk.physik.uni-konstanz.de/linux-mips/debian/bootdisks/
these contain fdisk & dvhtool, so hopefully everything to get your
disk "back into shape".
 -- Guido
