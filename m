Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JJ3O513530
	for linux-mips-outgoing; Thu, 19 Jul 2001 12:03:24 -0700
Received: from snfc21.pbi.net (mta6.snfc21.pbi.net [206.13.28.240])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JJ3OV13527
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 12:03:24 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta6.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GGQ00MEBI9N1Z@mta6.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Thu, 19 Jul 2001 12:03:23 -0700 (PDT)
Date: Thu, 19 Jul 2001 12:03:24 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: hard hat linux 2.0
To: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com
Reply-to: ppopov@pacbell.net
Message-id: <3B572EFC.9090903@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Looks like ftp.mvista.com was updated last night to include the mips 
journeyman edition. The images of interest would be 
ftp.mvista.com:/pub/Journeyman/cdimages/{je-d1-hhl2.0.cdimage, 
je-src-hhl2.0.cdimage}.  They are rather large so it takes a while to 
download them.

In addition to the userland packages, there is an up to date cross 
toolchain which can build the kernel as well as useland apps. There is 
also a native toolchain.  The toolchain is 2.95.3 based; glibc is 2.2.3. 
  Since there was some perl interest recently, perl is included. 
Rebuilding any of the userland packages, for those interested in doing 
that, is pretty trivial (cross based building!).

This is an embedded linux distribution so it's not as large as a RedHat 
desktop system. For embedded work though, I think it's more than 
sufficient.  One note, to anyone trying it.  A number of binaries are 
linked with pthreads, so you'll need either the new sysmips fix that 
Ralf is working on, when he completes it, or the patch from Florian. 
Otherwise binaries like ls, tar, and many others will seg fault.

Pete
