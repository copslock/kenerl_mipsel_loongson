Received:  by oss.sgi.com id <S553920AbRBMQSQ>;
	Tue, 13 Feb 2001 08:18:16 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:54417 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553852AbRBMQSC>;
	Tue, 13 Feb 2001 08:18:02 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA22691;
	Tue, 13 Feb 2001 16:00:28 +0100 (MET)
Date:   Tue, 13 Feb 2001 16:00:28 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>
cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: An IRQ handler fix for arch/mips/dec/irq.c (fwd)
Message-ID: <Pine.GSO.3.96.1010213155128.20214B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf,

 The fix does make crashes go away indeed.  Please apply.  Thanks.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

---------- Forwarded message ----------
Message-ID: <Pine.GSO.3.96.1010208131342.29177J-100000@delta.ds2.pg.gda.pl>
Date: Thu, 8 Feb 2001 13:34:36 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>, linux-mips@fnet.fr,
    linux-mips@oss.sgi.com
Subject: An IRQ handler fix for arch/mips/dec/irq.c

Hi,

 The epilogue for the DECstation's IRQ handler is buggy -- it permits
infinite interrupt recursion which may lead to a stack overflow.  I wasn't
able to check if that's the reason of random crashes I get when I run
strace at the console, yet, but it might be -- the load might be up to 10k
interrupts per second if data is available in time.

 Please apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.0-do_irq-0
diff -up --recursive --new-file linux-mips-2.4.0-20010126.macro/arch/mips/dec/irq.c linux-mips-2.4.0-20010126/arch/mips/dec/irq.c
--- linux-mips-2.4.0-20010126.macro/arch/mips/dec/irq.c	Sun Dec  3 05:26:46 2000
+++ linux-mips-2.4.0-20010126/arch/mips/dec/irq.c	Thu Feb  8 07:44:10 2001
@@ -136,8 +136,8 @@ asmlinkage void do_IRQ(int irq, struct p
 	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
 	    add_interrupt_randomness(irq);
-	unmask_irq(irq);
 	__cli();
+	unmask_irq(irq);
     }
     irq_exit(cpu, irq);
 
