Received:  by oss.sgi.com id <S42366AbQHEXOy>;
	Sat, 5 Aug 2000 16:14:54 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:23823 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42228AbQHEXOU>;
	Sat, 5 Aug 2000 16:14:20 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA09427
	for <linux-mips@oss.sgi.com>; Sat, 5 Aug 2000 16:06:16 -0700 (PDT)
	mail_from (philloc@janus.lsd.ornl.gov)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA81498
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 5 Aug 2000 16:13:32 -0700 (PDT)
	mail_from (philloc@janus.lsd.ornl.gov)
Received: from janus.lsd.ornl.gov (janus.lsd.ornl.gov [160.91.102.96]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05973
	for <linux@cthulhu.engr.sgi.com>; Sat, 5 Aug 2000 16:13:15 -0700 (PDT)
	mail_from (philloc@janus.lsd.ornl.gov)
Received: from localhost (philloc@localhost)
	by janus.lsd.ornl.gov (8.9.3/8.9.3) with ESMTP id TAA00954;
	Sat, 5 Aug 2000 19:13:15 -0400
Date:   Sat, 5 Aug 2000 19:13:15 -0400 (EDT)
From:   phil <philloc@janus.lsd.ornl.gov>
Reply-To: i15@ornl.gov
To:     linux-fbdev@vuser.vu.union.edu
cc:     linux@cthulhu.engr.sgi.com
Subject: SGI VW 540, fbdev and pot pourii of faults and evidence..:-)
Message-ID: <Pine.LNX.4.21.0008051851230.943-100000@janus.lsd.ornl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

	Hi Folks,

I have presented below a small list of "features" with the SGI kernel
driver for fbdev (no particular order) , and would like to know if any of
the symptoms, indicate general frame buffer problems, or specific hardware
implementation issues.

I would also like to ask, if SGI is likely to make the hardware specs OSS
(for cobalt etc.), so that those with the skill (this is not my forte, but
I will try...), can stabilise this otherwise competent port.

1. After boot , no matter what video mode one is in, the text console is
zippy. After using X (or changing modes using fbset) the text scrolling is
*painfully* slow. There is no apparent difference in the kernel mechanism
when switching, so is it just the boot state that works?



2.In X(4.01)  all video modes (800x600,1024x768,1280x1024,1600x1200) work
in 8 bit and 16 bit colour.

In Depth 24 (-fbbpp 32) , 1280x1024 is stable, but tinted green.

In Depth 24 (-fbbpp 32) , 1600x1200 is "shivering, left-right", and
tinted green.


	Empirical observations (i.e. writing known patterns to the
/dev/fb0 device) indicate that SGI reverse RGB for 888 format, compared to
RGB565. That is red offset=0, green=8,blue=16 rather than red=24 etc.. I
have reversed the assignment in the "var" structure (in sgivwfb_set_var )
and in setcolreg the offsets are used, but to no effect. What else needs
changing?


	Kind Regards

	PHiL
