Received:  by oss.sgi.com id <S553862AbRA2Xwb>;
	Mon, 29 Jan 2001 15:52:31 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:64010 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553857AbRA2XwY>;
	Mon, 29 Jan 2001 15:52:24 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C05937DD; Tue, 30 Jan 2001 00:52:22 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 55698EE9C; Tue, 30 Jan 2001 00:52:50 +0100 (CET)
Date:   Tue, 30 Jan 2001 00:52:50 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: [PATCH] clean error in arch/mips/pmc/cp7000/irq.c:request_irq
Message-ID: <20010130005250.A11722@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
i think this is more correct - On failing of shared irqs one should
at least reenable interrupts and free the allocated buffer.

Apply before anyone copys this into his/her code ...


Index: arch/mips/pmc/cp7000/irq.c
===================================================================
RCS file: /cvs/linux/arch/mips/pmc/cp7000/irq.c,v
retrieving revision 1.1
diff -u -r1.1 irq.c
--- arch/mips/pmc/cp7000/irq.c	2000/12/13 21:07:34	1.1
+++ arch/mips/pmc/cp7000/irq.c	2001/01/29 23:50:34
@@ -327,8 +327,11 @@
 
 	if ((old = *p) != NULL) {
 		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & action->flags & SA_SHIRQ))
+		if (!(old->flags & action->flags & SA_SHIRQ)) {
+			restore_flags(flags);
+			kfree(action);
 			return -EBUSY;
+		}
 		/* add new interrupt at end of irq queue */
 		do {
 			p = &old->next;


-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
