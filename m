Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 23:20:10 +0000 (GMT)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:3940 "EHLO avtrex.com")
	by linux-mips.org with ESMTP id <S8225592AbUAVXUJ>;
	Thu, 22 Jan 2004 23:20:09 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 22 Jan 2004 15:20:06 -0800
Message-ID: <40105A6F.3060009@avtrex.com>
Date: Thu, 22 Jan 2004 15:19:11 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Lossage do to #ifndef __ASSEMBLY__ in mipsregs.h
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2004 23:20:06.0115 (UTC) FILETIME=[452AA330:01C3E13E]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

I am using gcc 3.3.1 to compile the linux_2_4 kernel obtained from cvs a 
couple of days ago.

My gcc defines these assemble related macros:

[daney@dl xilleon]$ mipsel-linux-gcc -D__KERNEL__ 
-I/newdisk/programs/linux-mips.org/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -I 
/newdisk/programs/linux-mips.org/linux/include/asm/gcc -G 0 
-mno-abicalls -fno-pic -finline-limit=100000 -mabi=32 -march=mips32 
-mips32 -Wa,-32 -Wa,-march=mips32 -Wa,-mips32 -Wa,--trap  
-DLINUX_RAM_START=0x80100000 -dM -E -c xilleonIRQ.S | grep ASS
#define __ASSEMBLER__ 1
#define LANGUAGE_ASSEMBLY 1
#define __LANGUAGE_ASSEMBLY 1
#define __LANGUAGE_ASSEMBLY__ 1
#define _LANGUAGE_ASSEMBLY 1

Now in mipsregs.h we have:
.
.
.
#ifndef __ASSEMBLY__
.
.
.

So I get a ton of errors trying to assemble the file.

Now back on 2002/06/27 we have:

===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mipsregs.h,v
retrieving revision 1.30.2.8
retrieving revision 1.30.2.9
diff -u -p -r1.30.2.8 -r1.30.2.9
--- linux/include/asm-mips/mipsregs.h	2002/06/27 09:53:37	1.30.2.8
+++ linux/include/asm-mips/mipsregs.h	2002/06/27 14:21:23	1.30.2.9
@@ -445,7 +445,7 @@
 #define CEB_KERNEL	2	/* Count events in kernel mode EXL = ERL = 0 */
 #define CEB_EXL		1	/* Count events with EXL = 1, ERL = 0 */
 
-#ifndef _LANGUAGE_ASSEMBLY
+#ifndef __ASSEMBLY__
 
 /*
  * Functions to access the r10k performance counter and control registers
@@ -1023,6 +1023,6 @@ do {									\
 		__disable_fpu();					\
 } while (0)
 
-#endif /* !defined (_LANGUAGE_ASSEMBLY) */
+#endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_MIPSREGS_H */

Why the change?

I will fix my local mipsregs.h so that I can continue, but it seems like 
the sources in CVS should be changed to allow gcc 3.3.1 to work.

David Daney.
