Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 19:22:41 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.200]:2574 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225351AbVAUTWg>;
	Fri, 21 Jan 2005 19:22:36 +0000
Received: by wproxy.gmail.com with SMTP id 69so161198wra
        for <linux-mips@linux-mips.org>; Fri, 21 Jan 2005 11:22:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QDH+kucW4Ytn+/o0vqm4c29Zrk8seyozo3Q1Fq0q9CzS8hXwi0PAtqfGO4LVl2OQ5fHsVFFHZFZXEdLzQDBrft5/psmkJwJ6YSfCBa17jkg2cckQQmP6s19jEqWeUWCGh7GGEL9m1MSyuOYYWjmDRPpFEnl0TM4dHX0K5BmlYJg=
Received: by 10.54.24.32 with SMTP id 32mr13092wrx;
        Fri, 21 Jan 2005 11:22:29 -0800 (PST)
Received: by 10.54.41.39 with HTTP; Fri, 21 Jan 2005 11:22:29 -0800 (PST)
Message-ID: <ecb4efd1050121112268e163ba@mail.gmail.com>
Date:	Fri, 21 Jan 2005 14:22:29 -0500
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: CONFIG_PM depends on CONFIG_MACH_AU1X00?
In-Reply-To: <ecb4efd10501210949db48ce1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <ecb4efd10501210949db48ce1@mail.gmail.com>
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

I guess I should recompile after making a change to a Kconfig file. It
turns out that the arch/mips/au1000/common/irq.c code doesn't compile
for the Au1550 with CONFIG_PM defined.

arch/mips/au1000/common/irq.c: In function `startup_match20_interrupt':
arch/mips/au1000/common/irq.c:302: error: `AU1000_TOY_MATCH2_INT'
undeclared (first use in this function)
arch/mips/au1000/common/irq.c:302: error: (Each undeclared identifier
is reported only once
arch/mips/au1000/common/irq.c:302: error: for each function it appears in.)
arch/mips/au1000/common/irq.c: In function `intc0_req1_irqdispatch':
arch/mips/au1000/common/irq.c:525: error: `AU1000_TOY_MATCH2_INT'
undeclared (first use in this function)

I fixe this with the following patch:
RCS file: /home/cvs/linux/include/asm-mips/mach-au1x00/au1000.h,v
retrieving revision 1.12
diff -U1 -r1.12 au1000.h
--- ./include/asm-mips/mach-au1x00/au1000.h     4 Dec 2004 18:16:09
-0000      1.12
+++ ./include/asm-mips/mach-au1x00/au1000.h     21 Jan 2005 19:13:36 -0000
@@ -513,3 +513,3 @@
 #define AU1550_PSC3_INT           13
-#define AU1550_TOY_INT                   14
+#define AU1550_TOY_INT            14
 #define AU1550_TOY_MATCH0_INT     15
@@ -517,2 +517,6 @@
 #define AU1550_TOY_MATCH2_INT     17
+#define AU1000_TOY_INT            AU1550_TOY_INT
+#define AU1000_TOY_MATCH0_INT     AU1550_TOY_MATCH0_INT
+#define AU1000_TOY_MATCH1_INT     AU1550_TOY_MATCH1_INT
+#define AU1000_TOY_MATCH2_INT     AU1550_TOY_MATCH2_INT
 #define AU1550_RTC_INT            18

But I then hit some additional errors in arch/mips/au1000/common/time.c:
arch/mips/au1000/common/time.c: In function `counter0_irq':
arch/mips/au1000/common/time.c:126: error: `kstat' undeclared (first
use in this function)
arch/mips/au1000/common/time.c:126: error: (Each undeclared identifier
is reported only once
arch/mips/au1000/common/time.c:126: error: for each function it appears in.)

kstat is only used in common/time.c in the arch/mips/au1000 code. I
don't enough exposure to the codebase to know the right way to fix
this.

                                          --Clem
