Received:  by oss.sgi.com id <S42219AbQGZPyG>;
	Wed, 26 Jul 2000 08:54:06 -0700
Received: from mailout1-0.nyroc.rr.com ([24.92.226.81]:39364 "EHLO
        mailout1-1.nyroc.rr.com") by oss.sgi.com with ESMTP
	id <S42210AbQGZPxk>; Wed, 26 Jul 2000 08:53:40 -0700
Received: from hork (d185d0f81.rochester.rr.com [24.93.15.129])
	by mailout1-1.nyroc.rr.com (8.9.3/8.9.3) with ESMTP id LAA02639;
	Wed, 26 Jul 2000 11:51:02 -0400 (EDT)
Received: from molotov (helo=localhost)
	by hork with local-esmtp (Exim 3.12 #1 (Debian))
	id 13HTUX-0000HD-00; Wed, 26 Jul 2000 11:53:05 -0400
Date:   Wed, 26 Jul 2000 11:53:04 -0400 (EDT)
From:   Chris Ruvolo <csr6702@grace.rit.edu>
X-Sender: molotov@hork
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
cc:     linux-mips@oss.sgi.com
Subject: big endian Debian root image
In-Reply-To: <Pine.SGI.4.10.10007191041270.6330-100000@thor.tetracon-eng.net>
Message-ID: <Pine.LNX.4.21.0007201012560.12096-100000@hork>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 19 Jul 2000, J. Scott Kasten wrote:

> Would like to
>try the debian distro, but cannot find a big endian root image to install
>with,

I've put one together.  Its rather limited and a bit outdated now (doesn't
have perl 5.005 nor debconf), but you might want to take a look at it.  
It has a working dpkg & apt.  I plan on updating this within the next week
or two.

http://ftp.rfc822.org/pub/local/debian-mips/experimental/debian-mips-base-test_0.3.tar

-Chris
