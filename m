Received:  by oss.sgi.com id <S553659AbRBGNtY>;
	Wed, 7 Feb 2001 05:49:24 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:17422 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553647AbRBGNs7>;
	Wed, 7 Feb 2001 05:48:59 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B2BB27D9; Wed,  7 Feb 2001 14:48:43 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 671F8EEAC; Wed,  7 Feb 2001 14:48:58 +0100 (CET)
Date:   Wed, 7 Feb 2001 14:48:58 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Cc:     ralf@oss.sgi.com
Subject: NON FPU cpus - way to go
Message-ID: <20010207144857.B24485@paradigm.rfc822.org>
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
i would like to know the way to go for NON-FPU cpus - Currently its
partly an Compile Time thing and partly run time config. 

I stumbled over the current tree as on the 3912 we dont have a FPU
so we cant use the default "exit_thread" which simply causes the
CPU to halt (not even an cpu reset works)

arch/mips/process.c

     55 void exit_thread(void)
     56 {
     57         /* Forget lazy fpu state */
     58         if (last_task_used_math == current) {
     59                 set_cp0_status(ST0_CU1, ST0_CU1);
     60                 __asm__ __volatile__("cfc1\t$0,$31");
     61                 last_task_used_math = NULL;
     62         }
     63 }

The Linux-vr people IFDEFed this with CONFIG_NO_FPU which is an option
but then we could even remove the whole cpu probing as everything
would be compile time.

A question here - Which way to go - Compile or Run time config for
CPUs and is 

if(!(mips_cpu.options & MIPS_CPU_FPU))

this also valid for R3k CPU cores ? From my reading it is not as it doesnt
get initialized for R3000 ? As a lot architectures have the R3010
so this should get detected. The R3081 definitly has an FPU from
what i found on the web so this should be correct.

Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.49
diff -u -r1.49 setup.c
--- arch/mips/kernel/setup.c	2001/02/05 01:33:01	1.49
+++ arch/mips/kernel/setup.c	2001/02/07 13:39:16
@@ -182,15 +182,16 @@
 		mips_cpu.tlbsize = 64;
 		break;
 	case PRID_IMP_R3000:
+		mips_cpu.options = MIPS_CPU_TLB;
 		if ((mips_cpu.processor_id & 0xff) == PRID_REV_R3000A)
-			if (cpu_has_confreg())
+			if (cpu_has_confreg()) {
 				mips_cpu.cputype = CPU_R3081E;
-			else
+				mips_cpu.options |= MIPS_CPU_FPU;
+			} else
 				mips_cpu.cputype = CPU_R3000A;
 		else
 			 mips_cpu.cputype = CPU_R3000;
 		mips_cpu.isa_level = MIPS_CPU_ISA_I;
-		mips_cpu.options = MIPS_CPU_TLB;
 		mips_cpu.tlbsize = 64;
 		break;
 	case PRID_IMP_R4000:


Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
