Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49CsJi24231
	for linux-mips-outgoing; Wed, 9 May 2001 05:54:19 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49CnaF24139
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 05:49:38 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA07695;
	Wed, 9 May 2001 14:41:10 +0200 (MET DST)
Date: Wed, 9 May 2001 14:41:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Michael Shmulevich <michaels@jungo.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.4: mmap() fails for certain legal requests
In-Reply-To: <3AF93224.6080304@jungo.com>
Message-ID: <Pine.GSO.3.96.1010509142432.2489B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 9 May 2001, Michael Shmulevich wrote:

> As a side question: does this patch apply to 2.2.x kernel too?

 Feel free to backport it. ;-)  One hunk fails for 2.2.19, but it can be
applied by hand (note the vma variable is named vmm in 2.2). 

> While working on ld.so.1-9 port on MIPS I seen there's a try to mmap() 
> some address > 0x80000000 which fails due to the same 
> if(...TASK_SIZE...) mentioned in the patch.

 Yep, that's the exact problem, assuming MAP_FIXED is not set in flags
(something is screwed if it is). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
