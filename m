Received:  by oss.sgi.com id <S42274AbQJKErS>;
	Tue, 10 Oct 2000 21:47:18 -0700
Received: from hq.fsmlabs.com ([209.155.42.197]:30727 "EHLO hq.fsmlabs.com")
	by oss.sgi.com with ESMTP id <S42215AbQJKEq5>;
	Tue, 10 Oct 2000 21:46:57 -0700
Received: (from cort@localhost)
	by hq.fsmlabs.com (8.9.3/8.9.3) id WAA02674;
	Tue, 10 Oct 2000 22:43:17 -0600
Date:   Tue, 10 Oct 2000 22:43:17 -0600
From:   Cort Dougan <cort@fsmlabs.com>
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Cc:     Ralf Baechle <ralf@uni-koblenz.de>
Subject: modutils bug?  'if' clause executes incorrectly
Message-ID: <20001010224317.I733@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I'm finding that in a Linux/MIPS module the test case attached executes the
'if' clause in

if A
  B
else
  C

in the order A, C, B when A is false and correctly (A, B) when A is true.

This is with GCC version egcs-2.90.29 980515 (egcs-1.0.3 release) and
binutils 2.8.1 (with BFD 2.8.1).

The asm in this routine looks good and I can keep the code from failing by
removing the request_irq() and replacing it with something else that
doesn't call into the kernel.  I can't reproduce this in user-code or in
kernel code.

Does anyone have any suggestions?  Perhaps a suggestion for modutils
version?
