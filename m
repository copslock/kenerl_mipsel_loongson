Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HFJFv14505
	for linux-mips-outgoing; Thu, 17 Jan 2002 07:19:15 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HFJ5P14502
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 07:19:05 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA25783
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 06:18:56 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA08691
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 06:18:55 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g0HEIaA19758
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 15:18:37 +0100 (MET)
Message-ID: <3C46DD4F.225E134E@mips.com>
Date: Thu, 17 Jan 2002 15:18:55 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: EJTAG patch
Content-Type: multipart/mixed;
 boundary="------------3876C11FE88E3C3D432B94EB"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------3876C11FE88E3C3D432B94EB
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I have attached a patch for EJTAG exception support on MIPS32 CPUs.
I send these patches to everyone and not just Ralf, because I've got
questions from various people about MIPS32 CPUs and Malta board support
in the 2.4.17 kernel.
Sorry to disturb the rest of you.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------3876C11FE88E3C3D432B94EB
Content-Type: text/plain; charset=iso-8859-15;
 name="ejtag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ejtag.patch"

Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.96.2.4
diff -u -r1.96.2.4 setup.c
--- arch/mips/kernel/setup.c	2002/01/07 03:33:54	1.96.2.4
+++ arch/mips/kernel/setup.c	2002/01/17 15:11:23
@@ -150,6 +150,10 @@
 	case CPU_NEVADA:
 	case CPU_RM7000:
 	case CPU_TX49XX:
+	case CPU_4KC:
+	case CPU_4KEC:
+	case CPU_4KSC:
+	case CPU_5KC:
 		cpu_wait = r4k_wait;
 		printk(" available.\n");
 		break;
@@ -435,7 +439,7 @@
 			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_4KEX | 
 				           MIPS_CPU_4KTLB | MIPS_CPU_COUNTER | 
 				           MIPS_CPU_DIVEC | MIPS_CPU_WATCH |
-			                   MIPS_CPU_MCHECK;
+			                   MIPS_CPU_MCHECK | MIPS_CPU_EJTAG;
 			config1 = read_mips32_cp0_config1();
 			if (config1 & (1 << 3))
 				mips_cpu.options |= MIPS_CPU_WATCH;
@@ -452,7 +456,7 @@
 			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_4KEX | 
 				           MIPS_CPU_4KTLB | MIPS_CPU_COUNTER | 
 				           MIPS_CPU_DIVEC | MIPS_CPU_WATCH |
-			                   MIPS_CPU_MCHECK;
+			                   MIPS_CPU_MCHECK | MIPS_CPU_EJTAG;
 			config1 = read_mips32_cp0_config1();
 			if (config1 & (1 << 3))
 				mips_cpu.options |= MIPS_CPU_WATCH;
Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.99.2.3
diff -u -r1.99.2.3 traps.c
--- arch/mips/kernel/traps.c	2001/12/29 05:37:49	1.99.2.3
+++ arch/mips/kernel/traps.c	2002/01/17 15:11:23
@@ -853,7 +853,7 @@
 	 * destination.
 	 */
 	if (mips_cpu.options & MIPS_CPU_EJTAG)
-		memcpy((void *)(KSEG0 + 0x200), &except_vec_ejtag_debug, 0x80);
+		memcpy((void *)(KSEG0 + 0x300), &except_vec_ejtag_debug, 0x80);
 
 	/*
 	 * Only some CPUs have the watch exceptions or a dedicated

--------------3876C11FE88E3C3D432B94EB--
