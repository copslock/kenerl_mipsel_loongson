Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9UELD723177
	for linux-mips-outgoing; Tue, 30 Oct 2001 06:21:13 -0800
Received: from hood.tvd.be (hood.tvd.be [195.162.196.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9UELA023174
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 06:21:10 -0800
Received: from Chickadee (cable-213-132-155-161.upc.chello.be [213.132.155.161])
	by hood.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id PAA24475
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 15:20:39 +0100 (MET)
Received: from kristof by Chickadee with local (Exim 3.12 #1 (Debian))
	id 15yZjt-0000a0-00
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 15:19:37 +0100
Date: Tue, 30 Oct 2001 15:19:37 +0100
From: Kristof Vanbecelaere <kristof.vanbecelaere@sonycom.com>
To: linux-mips@oss.sgi.com
Subject: cross development tools
Message-ID: <20011030151936.B1603@Chickadee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

A while ago H.J. Lu adviced to use -march/-mtune instead of -mcpu
options. But I wonder which front-end you need to use? It looks like
gcc-3.0.2 lists the option as a target-specific one but does not
accept it when you pass it.

I then decided to track down the port H.J. made and found it on the
ftp server but only in rpm form. I run a debian host for
development. I assume/hope the binaries will probably run on my host
if only I could get to their content. I know about alien but the
version of rpm (3.0.3) on my host does not accept the rpm packages
from the ftp site:

only packages with major numbers <= 3 are supported by this version of
RPM

And a newer version of rpm is available but in rpm form. A bit of a
problem. Why this bias towards Red Hat? Why not just tar files?

Also, I notice the compiler in H.J.'s port is something like
gcc-2.96.something. Assuming this is also the version of the
cross-compiler, how come I don't see this release on the official gcc
web page? How do his tools relate to the gcc releases?

I may be missing some historical background here,
Kristof
