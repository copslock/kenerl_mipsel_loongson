Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f71BRCO01173
	for linux-mips-outgoing; Wed, 1 Aug 2001 04:27:12 -0700
Received: from fe070.worldonline.dk (fe070.worldonline.dk [212.54.64.208])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f71BRBV01170
	for <linux-mips@oss.sgi.com>; Wed, 1 Aug 2001 04:27:11 -0700
Received: (qmail 30967 invoked by uid 0); 1 Aug 2001 11:22:36 -0000
Received: from unknown (HELO tuxedo.skovlyporten.dk) (213.237.49.98)
  by fe070.worldonline.dk with SMTP; 1 Aug 2001 11:22:36 -0000
Received: by tuxedo.skovlyporten.dk (Postfix, from userid 501)
	id 51A09C438; Wed,  1 Aug 2001 13:22:33 +0200 (CEST)
Date: Wed, 1 Aug 2001 13:22:33 +0200
From: Lars Munch Christensen <c948114@student.dtu.dk>
To: linux-mips@oss.sgi.com
Subject: Remote debug Malta
Message-ID: <20010801132233.A12343@tuxedo.skovlyporten.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all

As I have mentioned previously on this list, I'm writing
a small mips64 microkernel for the malta board. The malta
has a remote gdb interface in YAMON, but I have not succeeded
in remote debugging my kernel yet. Is there a recommended
gdb version that I should use to debug mips64 code?

I have got it as far as downloading the kernel and jumping to the
kernel entry, but from there I'm only able to execute the
program, but not single step or anything else. 

Thanks
-- Lars Munch
