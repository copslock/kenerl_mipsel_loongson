Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6BHubP15668
	for linux-mips-outgoing; Wed, 11 Jul 2001 10:56:37 -0700
Received: from myth1.Stanford.EDU (myth1.Stanford.EDU [171.64.15.14])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6BHuaV15663
	for <linux-mips@oss.sgi.com>; Wed, 11 Jul 2001 10:56:36 -0700
Received: (from johnd@localhost)
	by myth1.Stanford.EDU (8.11.1/8.11.1) id f6BHuQZ03814;
	Wed, 11 Jul 2001 10:56:26 -0700 (PDT)
Date: Wed, 11 Jul 2001 10:56:26 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: <debian-mips@lists.debian.org>, <linux-mips@oss.sgi.com>
Subject: Illegal Instruction with 2.4.2 and 2.4.3
Message-ID: <Pine.GSO.4.31.0107111049350.2834-100000@myth1.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have been able to natively build kernels 2.4.0,2,3,4,5 on an Indy with
without the CD-ROM support. I have only been able to boot 2.4.2 and 2.4.3.
Previously, I was running 2.4.0-test9. 2.4.4 and 5 have ext2_fs inode
problems. 2.4.0 hangs at cleaning the /tmp directory.

Extracting tar files causes an illegal instruction on 2.4.2 and 3.  Is
there a patch for this.  Furthermore, are there patches available for all
the various kernel versions and how do I get them for each version of the
kernel.  Finally, I have read some email on stress tests.  Are those
publicly available?

thank you for your time,
john
