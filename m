Received:  by oss.sgi.com id <S553829AbRB1Vmo>;
	Wed, 28 Feb 2001 13:42:44 -0800
Received: from stereotomy.lineo.com ([64.50.107.151]:38162 "HELO
        stereotomy.lineo.com") by oss.sgi.com with SMTP id <S553773AbRB1Vm1>;
	Wed, 28 Feb 2001 13:42:27 -0800
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP id DD36F4C92B
	for <linux-mips@oss.sgi.com>; Wed, 28 Feb 2001 14:42:26 -0700 (MST)
Message-ID: <3A9D70C2.6010504@Lineo.COM>
Date:   Wed, 28 Feb 2001 14:42:26 -0700
From:   Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Patch allowing GDB to ignore misaligned data faults
References: <000a01c0a0cf$849efbe0$dde0490a@BANANA>
Content-Type: multipart/mixed;
 boundary="------------040204030603060306000202"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------040204030603060306000202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

When using gdb on the kernel, I've found it helpful to allow
misaligned exceptions to be emulated instead of being
intercepted by gdb.  The following patch does this.  But is
there a better way?  Perhaps a config.in option?

Or is this a case of treating the symptom?  Maybe there are
far too many altogether.  The network stack seems to
be littered with them--is skbuf alignment bad or something?

Ouch, I just looked and after a couple of days there have
been a lot!  This machine is running with nfs root, so every
time you breathe there's a lot of network I/O.

What kind of "unaligned accesses" counts are others seeing?

/ # cat /proc/cpuinfo
cpu                     : MIPS
cpu model               : RC32300 V0.0
system type             : IDT 79S334
BogoMIPS                : 149.91
byteorder               : little endian
unaligned accesses      : 329630
wait instruction        : no
microsecond timers      : no
extra interrupt vector  : yes
hardware watchpoint     : yes
VCED exceptions         : not available
VCEI exceptions         : not available

/ # uptime
   2:07pm  up 1 day, 21:07, load average: 0.00, 0.00, 0.00

Quinn






--------------040204030603060306000202
Content-Type: text/plain;
 name="patch-gdb-stub"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-gdb-stub"

diff -bpBuN -r -X - linux-sgi-cvs/arch/mips/kernel/gdb-stub.c linux+4/arch/mips/kernel/gdb-stub.c
--- linux-sgi-cvs/arch/mips/kernel/gdb-stub.c	Sun Dec  3 21:04:09 2000
+++ linux+4/arch/mips/kernel/gdb-stub.c	Mon Feb 26 14:56:05 2001
@@ -399,8 +399,11 @@ void set_debug_traps(void)
 	unsigned char c;
 
 	save_and_cli(flags);
-	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
+	for (ht = hard_trap_info; ht->tt && ht->signo; ht++) {
+		/* let the emulator handle adel and ades */
+		if (ht->tt == 4 || ht->tt == 5) continue;
 		set_except_vector(ht->tt, trap_low);
+	}
   
 	/*
 	 * In case GDB is started before us, ack any packets

--------------040204030603060306000202--
