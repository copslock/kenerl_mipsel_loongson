Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6KDPOW30423
	for linux-mips-outgoing; Fri, 20 Jul 2001 06:25:24 -0700
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6KDPMV30416
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 06:25:22 -0700
Received: by ATLOPS with Internet Mail Service (5.5.2448.0)
	id <PJLG2BQD>; Fri, 20 Jul 2001 09:25:14 -0400
Message-ID: <25369470B6F0D41194820002B328BDD27D2B@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
Reply-To: ppopov@pacbell.net
To: "'Pete Popov '" <ppopov@pacbell.net>,
   "'linux-mips-kernel@lists.sourceforge.net '"
	 <linux-mips-kernel@lists.sourceforge.net>,
   "'linux-mips@oss.sgi.com '"
	 <linux-mips@oss.sgi.com>
Subject: RE: hard hat linux 2.0
Date: Fri, 20 Jul 2001 09:25:13 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

 Is there somewhere I can grab the patch from Florian?  

-----Original Message-----
From: Pete Popov
To: linux-mips-kernel@lists.sourceforge.net; linux-mips@oss.sgi.com
Sent: 7/19/01 3:03 PM
Subject: hard hat linux 2.0

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
