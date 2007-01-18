Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 08:45:30 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:45742 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S20043418AbXARIpY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2007 08:45:24 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1H7Ste-0008Ct-35
	for linux-mips@linux-mips.org; Thu, 18 Jan 2007 00:45:22 -0800
Message-ID: <8426876.post@talk.nabble.com>
Date:	Thu, 18 Jan 2007 00:45:22 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Install Headers Target
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips


I have been trying to build a kernel, toolchain and rootfs using buildroot.

Buildroot uses the install-headers target of the kernel to get the headers
to build a toolchain.
I tried to build a the uClibc-gcc toolchain combo was missing 2 header files
to do the build.
This I fixed by patching Kbuild in asm-mips dir
See below:
diff -urN overlay_orig/include/asm-mips/Kbuild
overlay/include/asm-mips/Kbuild
--- a/include/asm-mips/Kbuild	2007-01-17 12:57:20.000000000 +0000
+++b/include/asm-mips/Kbuild	2007-01-17 12:53:46.000000000 +0000
@@ -1,3 +1,3 @@
 include include/asm-generic/Kbuild.asm

-header-y += cachectl.h sgidefs.h sysmips.h
+header-y += asm.h cachectl.h regdef.h sgidefs.h sysmips.h

Is it possible for this to go in? (Any one any problems with this patch)
Is this mailing list the correct one for this patch?

Hope it helps
Daniel Laird

-- 
View this message in context: http://www.nabble.com/Install-Headers-Target-tf3032928.html#a8426876
Sent from the linux-mips main mailing list archive at Nabble.com.
