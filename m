Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2O0MsJ21783
	for linux-mips-outgoing; Sat, 23 Mar 2002 16:22:54 -0800
Received: from vasquez.zip.com.au (vasquez.zip.com.au [203.12.97.41])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2O0Mnq21779
	for <linux-mips@oss.sgi.com>; Sat, 23 Mar 2002 16:22:49 -0800
Received: from zip.com.au (root@zipperii.zip.com.au [61.8.0.87])
	by vasquez.zip.com.au (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id LAA16327;
	Sun, 24 Mar 2002 11:23:17 +1100
X-Authentication-Warning: vasquez.zip.com.au: Host root@zipperii.zip.com.au [61.8.0.87] claimed to be zip.com.au
Message-ID: <3C9D1C1D.E30B9B4B@zip.com.au>
Date: Sat, 23 Mar 2002 16:21:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: tytso@thunk.org, linux-mips@oss.sgi.com
Subject: Re: Does e2fsprogs-1.26 work on mips?
References: <20020323140728.A4306@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:
> 
> I got
> 
> [root@localhost e2fsprogs-1.26]# ./e2fsck/e2fsck -f /dev/hda1
> e2fsck 1.26 (3-Feb-2002)
> Pass 1: Checking inodes, blocks, and sizes
> File size limit exceeded
> 
> on Linux/mipsel. /dev/hda1 is a 7GB ext3 partition. e2fsprogs-1.23
> works fine. Strace
> 
> 

Common problem - it's due to internal API changes in resource
limits.  You need to ensure that your maximum file size
is set to `unlimited'.  Kernel is currently applying file
size limits to block devices (which is broken) and I
think e2fsprogs' attempt to set sile size limits to
RLIM_INFINITY gets broken by a consipiracy between the
kernel change and glibc headers.
