Received:  by oss.sgi.com id <S554057AbQLBM3i>;
	Sat, 2 Dec 2000 04:29:38 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:61706 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554050AbQLBM32>;
	Sat, 2 Dec 2000 04:29:28 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2B2E8804; Sat,  2 Dec 2000 13:29:20 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 765118F74; Sat,  2 Dec 2000 13:27:48 +0100 (CET)
Date:   Sat, 2 Dec 2000 13:27:48 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: [PATCH] DEC init_cycle_counter
Message-ID: <20001202132748.A2002@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Comments ?

Index: time.c
===================================================================
RCS file: /cvs/linux/arch/mips/dec/time.c,v
retrieving revision 1.11
diff -u -r1.11 arch/mips/dec/time.c
--- arch/mips/dec/time.c	2000/11/23 02:00:49	1.11
+++ arch/mips/dec/time.c	2000/12/02 12:20:09
@@ -423,46 +423,6 @@
 	timer_interrupt(irq, dev_id, regs);
 }
 
-char cyclecounter_available;
-
-static inline void init_cycle_counter(void)
-{
-	switch (mips_cputype) {
-	case CPU_UNKNOWN:
-	case CPU_R2000:
-	case CPU_R3000:
-	case CPU_R3000A:
-	case CPU_R3041:
-	case CPU_R3051:
-	case CPU_R3052:
-	case CPU_R3081:
-	case CPU_R3081E:
-	case CPU_R6000:
-	case CPU_R6000A:
-	case CPU_R8000:	/* Not shure about that one, play safe */
-		cyclecounter_available = 0;
-		break;
-	case CPU_R4000PC:
-	case CPU_R4000SC:
-	case CPU_R4000MC:
-	case CPU_R4200:
-	case CPU_R4400PC:
-	case CPU_R4400SC:
-	case CPU_R4400MC:
-	case CPU_R4600:
-	case CPU_R10000:
-	case CPU_R4300:
-	case CPU_R4650:
-	case CPU_R4700:
-	case CPU_R5000:
-	case CPU_R5000A:
-	case CPU_R4640:
-	case CPU_NEVADA:
-		cyclecounter_available = 1;
-		break;
-	}
-}
-
 struct irqaction irq0 = {timer_interrupt, SA_INTERRUPT, 0,
 			 "timer", NULL, NULL};
 
@@ -513,8 +473,6 @@
 	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
 	xtime.tv_usec = 0;
 	write_unlock_irq(&xtime_lock);
-
-	init_cycle_counter();
 
 	if (cyclecounter_available) {
 		write_32bit_cp0_register(CP0_COUNT, 0);


-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
