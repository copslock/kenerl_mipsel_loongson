Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 23:04:56 +0200 (CEST)
Received: from mail.esstech.com ([64.152.86.3]:4940 "HELO [64.152.86.3]")
	by linux-mips.org with SMTP id <S1123909AbSI0VEz>;
	Fri, 27 Sep 2002 23:04:55 +0200
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for mail.linux-mips.org [80.63.7.146]) with SMTP; Fri, 27 Sep 2002 14:04:54 -0700
Received: from venus (venus.esstech.com [193.5.205.5])
	by mail.esstech.com (8.12.2/8.12.2) with SMTP id g8RL5f0A016591
	for <linux-mips@linux-mips.org>; Fri, 27 Sep 2002 14:05:41 -0700 (PDT)
Received: from bud.austin.esstech.com by venus (SMI-8.6/SMI-SVR4)
	id OAA02930; Fri, 27 Sep 2002 14:03:53 -0700
Received: from [193.5.206.150] by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id PAA24976; Fri, 27 Sep 2002 15:55:19 -0500
Subject: Re: [PATCH] show register names in show_regs
From: Gerald Champagne <gerald.champagne@esstech.com>
To: Linux Mips Mailing List <linux-mips@linux-mips.org>
In-Reply-To: <1033159633.26894.50.camel@localhost.localdomain>
References: <1033159633.26894.50.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-8UcRJplF+BLpBd2GsULP"
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Sep 2002 15:55:11 -0500
Message-Id: <1033160116.26894.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Virus-Scanned: by AMaViS-perl11-milter (http://amavis.org/)
Return-Path: <gerald.champagne@esstech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerald.champagne@esstech.com
Precedence: bulk
X-list: linux-mips


--=-8UcRJplF+BLpBd2GsULP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Oops, the last patch has a stupid mistake displaying r1-r3.  Fixed patch
attached.

Gerald

On Fri, 2002-09-27 at 15:47, Gerald Champagne wrote:
> The following trivial patch makes show_regs display register names
> before each value.  I find this format much faster to read when
> comparing register dumps to assembly code.  The results look like this:
> 
>  $0:             at=00000000 v0=90008400 v1=00000037
>  $4: a0=8023a934 a1=00000001 a2=81275e64 a3=00000562
>  $8: t0=00000562 t1=81275d38 t2=7a797877 t3=4a494847
> $12: t4=80268356 t5=fffffffe t6=00000010 t7=4e4d4c4b
> $16: s0=ffffffff s1=b8000800 s2=802647b0 s3=00000000
> $20: s4=00000000 s5=00000000 s6=00000004 s7=000000ff
> $24: t8=ffffffff t9=00000001 k0=........ k1=........
> $28: gp=81274000 sp=81275e20 fp=00000000 ra=80211c6c
> 
> Is this acceptable, or do people prefer the existing method without the
> register names?
> 
> Gerald
> 
> 
> ----
> 

> --- linux.orig/arch/mips/kernel/traps.c	Sun Dec  2 05:34:38 2001
> +++ linux/arch/mips/kernel/traps.c	Fri Sep 27 15:28:08 2002
> @@ -291,17 +291,21 @@
>  	/*
>  	 * Saved main processor registers
>  	 */
> -	printk("$0 : %08x %08lx %08lx %08lx %08lx %08lx %08lx %08lx\n",
> -	       0,             regs->regs[1], regs->regs[2], regs->regs[3],
> +	printk(" $0:             at=%08lx v0=%08lx v1=%08lx\n",
> +	       0,             regs->regs[1], regs->regs[2], regs->regs[3]);
> +	printk(" $4: a0=%08lx a1=%08lx a2=%08lx a3=%08lx\n",
>  	       regs->regs[4], regs->regs[5], regs->regs[6], regs->regs[7]);
> -	printk("$8 : %08lx %08lx %08lx %08lx %08lx %08lx %08lx %08lx\n",
> -	       regs->regs[8],  regs->regs[9],  regs->regs[10], regs->regs[11],
> +	printk(" $8: t0=%08lx t1=%08lx t2=%08lx t3=%08lx\n",
> +	       regs->regs[8],  regs->regs[9],  regs->regs[10], regs->regs[11]);
> +	printk("$12: t4=%08lx t5=%08lx t6=%08lx t7=%08lx\n",
>                 regs->regs[12], regs->regs[13], regs->regs[14], regs->regs[15]);
> -	printk("$16: %08lx %08lx %08lx %08lx %08lx %08lx %08lx %08lx\n",
> -	       regs->regs[16], regs->regs[17], regs->regs[18], regs->regs[19],
> +	printk("$16: s0=%08lx s1=%08lx s2=%08lx s3=%08lx\n",
> +	       regs->regs[16], regs->regs[17], regs->regs[18], regs->regs[19]);
> +	printk("$20: s4=%08lx s5=%08lx s6=%08lx s7=%08lx\n",
>                 regs->regs[20], regs->regs[21], regs->regs[22], regs->regs[23]);
> -	printk("$24: %08lx %08lx                   %08lx %08lx %08lx %08lx\n",
> -	       regs->regs[24], regs->regs[25],
> +	printk("$24: t8=%08lx t9=%08lx k0=........ k1=........\n",
> +	       regs->regs[24], regs->regs[25]);
> +	printk("$28: gp=%08lx sp=%08lx fp=%08lx ra=%08lx\n",
>  	       regs->regs[28], regs->regs[29], regs->regs[30], regs->regs[31]);
>  	printk("Hi : %08lx\n", regs->hi);
>  	printk("Lo : %08lx\n", regs->lo);


--=-8UcRJplF+BLpBd2GsULP
Content-Disposition: attachment; filename=show_regs.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=show_regs.patch; charset=ISO-8859-1

--- linux.orig/arch/mips/kernel/traps.c	Sun Dec  2 05:34:38 2001
+++ linux/arch/mips/kernel/traps.c	Fri Sep 27 15:51:06 2002
@@ -291,17 +291,21 @@
 	/*
 	 * Saved main processor registers
 	 */
-	printk("$0 : %08x %08lx %08lx %08lx %08lx %08lx %08lx %08lx\n",
-	       0,             regs->regs[1], regs->regs[2], regs->regs[3],
+	printk(" $0:             at=3D%08lx v0=3D%08lx v1=3D%08lx\n",
+	                      regs->regs[1], regs->regs[2], regs->regs[3]);
+	printk(" $4: a0=3D%08lx a1=3D%08lx a2=3D%08lx a3=3D%08lx\n",
 	       regs->regs[4], regs->regs[5], regs->regs[6], regs->regs[7]);
-	printk("$8 : %08lx %08lx %08lx %08lx %08lx %08lx %08lx %08lx\n",
-	       regs->regs[8],  regs->regs[9],  regs->regs[10], regs->regs[11],
+	printk(" $8: t0=3D%08lx t1=3D%08lx t2=3D%08lx t3=3D%08lx\n",
+	       regs->regs[8],  regs->regs[9],  regs->regs[10], regs->regs[11]);
+	printk("$12: t4=3D%08lx t5=3D%08lx t6=3D%08lx t7=3D%08lx\n",
                regs->regs[12], regs->regs[13], regs->regs[14], regs->regs[=
15]);
-	printk("$16: %08lx %08lx %08lx %08lx %08lx %08lx %08lx %08lx\n",
-	       regs->regs[16], regs->regs[17], regs->regs[18], regs->regs[19],
+	printk("$16: s0=3D%08lx s1=3D%08lx s2=3D%08lx s3=3D%08lx\n",
+	       regs->regs[16], regs->regs[17], regs->regs[18], regs->regs[19]);
+	printk("$20: s4=3D%08lx s5=3D%08lx s6=3D%08lx s7=3D%08lx\n",
                regs->regs[20], regs->regs[21], regs->regs[22], regs->regs[=
23]);
-	printk("$24: %08lx %08lx                   %08lx %08lx %08lx %08lx\n",
-	       regs->regs[24], regs->regs[25],
+	printk("$24: t8=3D%08lx t9=3D%08lx k0=3D........ k1=3D........\n",
+	       regs->regs[24], regs->regs[25]);
+	printk("$28: gp=3D%08lx sp=3D%08lx fp=3D%08lx ra=3D%08lx\n",
 	       regs->regs[28], regs->regs[29], regs->regs[30], regs->regs[31]);
 	printk("Hi : %08lx\n", regs->hi);
 	printk("Lo : %08lx\n", regs->lo);

--=-8UcRJplF+BLpBd2GsULP--
