Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56HfHp07759
	for linux-mips-outgoing; Wed, 6 Jun 2001 10:41:17 -0700
Received: from t111.niisi.ras.ru (IDENT:root@t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56HfFh07753
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 10:41:16 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id VAA28711
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 21:41:25 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id VAA01483 for linux-mips@oss.sgi.com; Wed, 6 Jun 2001 21:31:02 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id VAA15938 for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 21:36:52 +0400 (MSD)
Message-ID: <3B1EDB4A.4080803@niisi.msk.ru>
Date: Wed, 06 Jun 2001 21:39:22 -0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Troubles in r2300.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.
In the r2300.c ,in some functions ( like the r3k_cache_size and so on ), 
the
CONFIG register is modified. To return this register to initial state, the
save_and_cli(flags) and the restore_flags(flags) functions are used. The
restore_flags do not modify whole STATUS register, but only the 
Interrupt Enable
bit. So we should use the read_32bit_cp0_register and the 
write_32bit_cp0_register
functions instead ( like it was in linux-2.4.1 ).
And also, this patch adds R3081E CPU support to the ld_mmu_r2300() function.

diff -u -r1.12 r2300.c
--- arch/mips/mm/r2300.c        2001/05/31 14:27:32     1.12
+++ arch/mips/mm/r2300.c        2001/06/06 17:10:47
@@ -125,7 +125,7 @@

       p = (volatile unsigned long *) KSEG0;

-       save_and_cli(flags);
+       flags = read_32bit_cp0_register(CP0_STATUS);

       /* isolate cache space */
       write_32bit_cp0_register(CP0_STATUS, (ca_flags|flags)&~ST0_IEC);
@@ -147,7 +147,7 @@
               if (size > 0x40000)
                       size = 0;
       }
-       restore_flags(flags);
+       write_32bit_cp0_register(CP0_STATUS, flags);

       return size * sizeof(*p);
}
@@ -170,7 +170,7 @@
       if (size > icache_size)
               size = icache_size;

-       save_and_cli(flags);
+       flags = read_32bit_cp0_register(CP0_STATUS);

       /* isolate cache space */
       write_32bit_cp0_register(CP0_STATUS, 
(ST0_ISC|ST0_SWC|flags)&~ST0_IEC);
@@ -212,7 +212,7 @@
               p += 0x080;
       }

-       restore_flags(flags);
+       write_32bit_cp0_register(CP0_STATUS,flags);
}

static void r3k_flush_dcache_range(unsigned long start, unsigned long end)
@@ -224,7 +224,7 @@
       if (size > dcache_size)
               size = dcache_size;

-       save_and_cli(flags);
+       flags = read_32bit_cp0_register(CP0_STATUS);

       /* isolate cache space */
       write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|flags)&~ST0_IEC);
@@ -266,7 +266,7 @@
               p += 0x080;
       }

-       restore_flags(flags);
+       write_32bit_cp0_register(CP0_STATUS,flags);
}

static inline unsigned long get_phys_page (unsigned long addr,
@@ -714,6 +714,7 @@
               case CPU_R3000:
               case CPU_R3000A:
               case CPU_R3081:
+               case CPU_R3081E:

                       r3k_probe_cache();
