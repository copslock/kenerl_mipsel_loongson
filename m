Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57FAFr16830
	for linux-mips-outgoing; Thu, 7 Jun 2001 08:10:15 -0700
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57F9uh16782;
	Thu, 7 Jun 2001 08:09:57 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id TAA06655;
	Thu, 7 Jun 2001 19:10:05 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id TAA02870; Thu, 7 Jun 2001 19:00:58 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id TAA22173; Thu, 7 Jun 2001 19:08:35 +0400 (MSD)
Message-ID: <3B200A11.3020805@niisi.msk.ru>
Date: Thu, 07 Jun 2001 19:11:13 -0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Troubles in r2300.c
References: <3B1EDB4A.4080803@niisi.msk.ru> <20010606215545.A6079@bacchus.dhis.org>
Content-Type: multipart/mixed;
 boundary="------------090809030606070008010108"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------090809030606070008010108
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:

> Alexandr,
>
> your MUA has garbled your patch, so I was forced to apply it manually.
> Mozilla is known to be evil in that respect like a few more mailers.
> For future patches please use a mailer that doesn't change patches in
> creative ways. Thanks for your patch,
>
> Ralf
>
Oh, I'm sorry, i forgot to substitute one save_and_cli() and restore ...
Please, apply new patch.




--------------090809030606070008010108
Content-Type: text/plain;
 name="r2300_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="r2300_patch"

Index: arch/mips/mm/r2300.c
===================================================================
RCS file: /share/cvs/root/linux/arch/mips/mm/r2300.c,v
retrieving revision 1.12
diff -u -r1.12 r2300.c
--- arch/mips/mm/r2300.c	2001/05/31 14:27:32	1.12
+++ arch/mips/mm/r2300.c	2001/06/07 14:28:29
@@ -125,7 +125,7 @@
 
 	p = (volatile unsigned long *) KSEG0;
 
-	save_and_cli(flags);
+	flags = read_32bit_cp0_register(CP0_STATUS);
 
 	/* isolate cache space */
 	write_32bit_cp0_register(CP0_STATUS, (ca_flags|flags)&~ST0_IEC);
@@ -147,7 +147,7 @@
 		if (size > 0x40000)
 			size = 0;
 	}
-	restore_flags(flags);
+	write_32bit_cp0_register(CP0_STATUS, flags);
 
 	return size * sizeof(*p);
 }
@@ -170,7 +170,7 @@
 	if (size > icache_size)
 		size = icache_size;
 
-	save_and_cli(flags);
+	flags = read_32bit_cp0_register(CP0_STATUS);
 
 	/* isolate cache space */
 	write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|ST0_SWC|flags)&~ST0_IEC);
@@ -212,7 +212,7 @@
 		p += 0x080;
 	}
 
-	restore_flags(flags);
+	write_32bit_cp0_register(CP0_STATUS, flags);
 }
 
 static void r3k_flush_dcache_range(unsigned long start, unsigned long end)
@@ -224,7 +224,7 @@
 	if (size > dcache_size)
 		size = dcache_size;
 
-	save_and_cli(flags);
+	flags = read_32bit_cp0_register(CP0_STATUS);
 
 	/* isolate cache space */
 	write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|flags)&~ST0_IEC);
@@ -266,7 +266,7 @@
 		p += 0x080;
 	}
 
-	restore_flags(flags);
+	write_32bit_cp0_register(CP0_STATUS, flags);
 }
 
 static inline unsigned long get_phys_page (unsigned long addr,
@@ -389,7 +389,7 @@
 	printk("csigtramp[%08lx]", addr);
 #endif
 
-	save_and_cli(flags);
+	flags = read_32bit_cp0_register(CP0_STATUS);
 
 	write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|ST0_SWC|flags)&~ST0_IEC);
 
@@ -398,7 +398,7 @@
 		"sb\t$0,0x008(%0)\n\t"
 		: : "r" (addr) );
 
-	restore_flags(flags);
+	write_32bit_cp0_register(CP0_STATUS, flags);
 }
 
 static void r3k_dma_cache_wback_inv(unsigned long start, unsigned long size)
@@ -714,6 +714,7 @@
 		case CPU_R3000:
 		case CPU_R3000A:
 		case CPU_R3081:
+		case CPU_R3081E:
 
 			r3k_probe_cache();
 

--------------090809030606070008010108--
