Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 19:56:55 +0200 (CEST)
Received: from office.office.sutus.com ([207.81.158.121]:11924 "HELO
	localhost.office.sutus.com") by ftp.linux-mips.org with SMTP
	id S8133828AbWEZR4o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 19:56:44 +0200
Received: from [192.168.237.228] (burden.office.sutus.com [192.168.237.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by localhost.office.sutus.com (Postfix) with ESMTP id D51A0F2C15D;
	Fri, 26 May 2006 10:56:34 -0700 (PDT)
Message-ID: <4477415A.8070607@sutus.com>
Date:	Fri, 26 May 2006 10:56:42 -0700
From:	Braden Marr <bmarr@sutus.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
CC:	Roman Mashak <mrv@corecom.co.kr>, linux-mips@linux-mips.org
Subject: Re: booting with NFS root
References: <C28979E4F697C249ABDA83AC0C33CDF80DE0F2@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <C28979E4F697C249ABDA83AC0C33CDF80DE0F2@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: multipart/mixed;
 boundary="------------000101080607090706010200"
Return-Path: <bmarr@sutus.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bmarr@sutus.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000101080607090706010200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kiran Thota wrote:
> Roman,
>   You have an older version of the linux kernel. I can send you latest snapshot.
> There was a software bug. I don't know your source version to send patch but I am
> attaching the source titan_ge.c
>
> Regards,
> Kiran
Kiran,

I noticed in this driver update that the INTMSG vector is set after 
interrupts are enabled.

We have confirmed that if the Titan GE's INTMSG vector is configured 
instead to point to the Interrupt Controller's INTMSG register before 
the interrupts are enabled, then the chance of this exception occurring 
is reduced or removed.

I have attached a patch against your earlier titan_ge.c attachment that 
illustrates this change.

As I understand it, if an interrupt is pending from some previous use of 
the Titan GE block, such as in PMON (which uses a polling interrupt 
handler), where tftp is used to load the kernel into RAM via an Ethernet 
port, then when the interrupts are enabled in the kernel's titan_ge.c 
driver, a pending interrupt (from Ethernet packets received before while 
the kernel is booting, for example) could cause the Titan GE block to 
send the interrupt status message to a undetermined address within the 
RM9150 core! Since there is likely no conventional way to trap this type 
of exception, an erroneous do_cpu exception is the result.

Conceivably, any core block that attempts to use an INTMSG vector with 
an undetermined value could cause the same conditions.

cheers,

Braden Marr.  (email to: bmarr at sutus dot com)

>
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Roman Mashak
> Sent: Thursday, May 25, 2006 5:50 PM
> To: linux-mips@linux-mips.org
> Subject: booting with NFS root
>
> Hello!
>
> I have evaluation board from PMC-sierra, their CPU is using E9000 core. 
> Kernel (2.4.26), root FS are provided by them. I set up NFS and TFTP servers on my linux box, kernel loads into board but fails to boot woth the following message (I skipped some lines of kernel):
>
> =====================
> PMC-Sierra TITAN 10/100/1000 Ethernet Driver Device Id : 206014,  Version : 0
> eth0: port 0 with MAC address 30:30:3a:31:31:3a Rx NAPI supported, Tx Coalescing ON
> eth1: port 1 with MAC address 30:30:3a:31:31:3b Rx NAPI supported, Tx Coalescing ON
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 1024 buckets, 8Kbytes
> TCP: Hash tables configured (established 8192 bind 16384)
> IP-Config: Entered.
> ipconfig.c 1194
> dev.c 1998
> dev.c 2013
> dev.c 750
> irq.c 539
> irq.c 571
> irq.c 840
> irq.c 879
> handler->startup 80259d14
> irq.c 892
> irq.c 576
> Assigned IRQ 6 to port 0
> titan_ge.c 2256
> titan_ge.c 2278
> titan_ge.c 2316
> titan_ge.c 2359
> titan_ge.c 1614
> titan_ge.c 1659
> titan_ge.c 1698
> titan_ge.c 1717
> titan_ge.c 1837
> titan_ge.c 2025
> titan_ge.c 2118
> titan_ge.c 2177
> dev_addr=       1, reg_addr=      11
> val=    4111
> val=       1
> titan_ge.c 2184
> titan_ge.c 2397
> dev_addr=       1, reg_addr=      11
> val=    4112
> val=       1
> dev.c 788
> dev.c 2034
> dev.c 2043
> dev.c 2059
> IP-Config: eth0 UP (able=1, xid=57c63687) dev.c 1998 dev.c 2013 dev.c 750 irq.c 539 irq.c 571 irq.c 840 irq.c 879 irq.c 892 irq.c 576 Assigned IRQ 6 to port 1 titan_ge.c 2256 titan_ge.c 2278 titan_ge.c 2316 titan_ge.c 2359 titan_ge.c 1659 titan_ge.c 1698 titan_ge.c 1717 titan_ge.c 1837 titan_ge.c 2025 titan_ge.c 2118 titan_ge.c 2177
> dev_addr=       2, reg_addr=      11
> val=    4111
> val=       1
> titan_ge.c 2184
> titan_ge.c 2397
> dev_addr=       2, reg_addr=      11
> val=    4212
> val=       1
> eth1: Error opening interface
> dev.c 788
> dev.c 2034
> dev.c 2043
> dev.c 2059
> IP-Config: Failed to open eth1
> ipconfig.c 1199
> IP-Config: Guessing netmask 255.255.255.0
> IP-Config: Complete:
>       device=eth0, addr=192.168.11.42, mask=255.255.255.0, gw=255.255.255.255,
>      host=192.168.11.42, domain=, nis-domain=(none),
>      bootserver=255.255.255.255, rootserver=192.168.11.43, rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 192.168.11.43 Looking up port of RPC 100005/1 on 192.168.11.43
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 104k freed do_cpu invoked from kernel context! in traps.c::do_cpu, line 676:
> $0 : 00000000 9004a000 2ab03fe0 2ab03fe0 2ab01560 00000000 00000ae0 00000ae0
> $8 : 00000020 2ab01fe0 2ab01520 00001000 00000019 00000080 811d7b18 00000c62
> $16: 2ab010c0 811d7c58 87f8cfe0 00000003 00000080 2ab01520 87f841a0 00000001
> $24: 00000000 00000080                   811d6000 811d7ba0 2aaa8000 8015f414
> Hi : 00000000
> Lo : 00000000
> epc   : 80256e14    Not tainted
> Status: 9004a003
> Cause : 1000002c
> PrId  : 000034c1
> Process init (pid: 1, stackpage=811d6000)
> Stack:    8015f8a8 8015f9a8 87f71180 8012b2fc 00000000 80135330 00002012
>  00000019 87f8cf60 2ab019e4 00000004 00002012 000590c0 2ab01000 10000000
>  811d7d88 87ff5740 00000000 811d7ef8 81164e80 00000000 00000002 87f841a0
>  8015ffd8 811d7c20 811d6000 811d7cbc 801975a4 00006012 0000000a 811d7c18
>  811d7c18 7f454c46 01020100 00000000 00000000 00020008 00000001 00401980
>  00000034 ...
> Call Trace:   [<8015f8a8>] [<8015f9a8>] [<8012b2fc>] [<80135330>] 
> [<8015ffd8>]
>  [<801975a4>] [<8015fbc0>] [<801493ac>] [<801007b8>] [<8014889c>] [<801495bc>]  [<801495a8>] [<801007b8>] [<80108f80>] [<801007b8>] [<8014fcc4>] [<801095c0>]  [<8025ad30>] [<801007b8>] [<8025ad30>] [<8014af50>] [<801007b8>] [<80117888>]  [<801194a0>] [<80100884>] [<801007b8>] [<8010079c>] [<8025de14>] [<80104320>]  [<80117aec>] [<8026b7a8>] [<801b2054>] [<80104310>]
>
> Code: 30c8003c  01244821  24840040 <ac85ffc0> ac85ffc4  ac85ffc8  ac85ffcc ac85ffd0  ac85ffd4 Kernel panic: Attempted to kill init!
> =====================
>
> I load kernel with the following parameters:
> tftp://192.168.11.43/vmlinux ip=192.168.11.42 root=/dev/nfs nfsroot=192.168.11.43:/export/linux/mips-fs-be
>
> What may be the problem here?
>
> Thanks in advance!
>
> With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
>
>
>


--------------000101080607090706010200
Content-Type: text/plain;
 name="titan_ge-intmsg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="titan_ge-intmsg.patch"

--- titan_ge.c.pmc	2006-05-25 20:10:29.000000000 -0700
+++ titan_ge.c	2006-05-25 20:12:34.000000000 -0700
@@ -2094,6 +2094,28 @@
 
 	udelay(30);
 
+#ifdef CONFIG_PMC_SEQUOIA
+
+// XD_OOD_INTSMSG = 0x61, XD_INTSMSG = 0x62, 
+// XD_RX_INTSMSG = XD_TX_INTSMSG = 0x60
+		TITAN_GE_WRITE(0x0060, RM9150_GCIC_INTMSG  >> 4);
+
+                reg_data = 0x61626060;
+		TITAN_GE_WRITE(0x0044, reg_data);
+		reg_data = TITAN_GE_READ(0x0080);
+		reg_data |= 0x1;		
+		TITAN_GE_WRITE(0x0080, reg_data);
+
+#else
+#ifdef TITAN_GE_12
+		TITAN_GE_WRITE(0x0024, 0x04844424);
+#else
+		TITAN_GE_WRITE(0x0024, 0x04000024);	/* IRQ vector */
+#endif
+		TITAN_GE_WRITE(0x0020, 0x000fb000);	/* INTMSG base */
+#endif // CONFIG_PMC_SEQUOIA
+	}
+
 	/* 
 	 * Enable the Interrupts for Tx and Rx 
 	 */
@@ -2128,28 +2150,6 @@
 		TITAN_GE_WRITE(0x003c, 0x00300);
 #endif
 
-#ifdef CONFIG_PMC_SEQUOIA
-
-// XD_OOD_INTSMSG = 0x61, XD_INTSMSG = 0x62, 
-// XD_RX_INTSMSG = XD_TX_INTSMSG = 0x60
-		TITAN_GE_WRITE(0x0060, RM9150_GCIC_INTMSG  >> 4);
-
-                reg_data = 0x61626060;
-		TITAN_GE_WRITE(0x0044, reg_data);
-		reg_data = TITAN_GE_READ(0x0080);
-		reg_data |= 0x1;		
-		TITAN_GE_WRITE(0x0080, reg_data);
-
-#else
-#ifdef TITAN_GE_12
-		TITAN_GE_WRITE(0x0024, 0x04844424);
-#else
-		TITAN_GE_WRITE(0x0024, 0x04000024);	/* IRQ vector */
-#endif
-		TITAN_GE_WRITE(0x0020, 0x000fb000);	/* INTMSG base */
-#endif // CONFIG_PMC_SEQUOIA
-	}
-
 	/* Priority */
 	reg_data = TITAN_GE_READ(0x1038 + (port_num << 12));
 	reg_data &= ~(0x00f00000);

--------------000101080607090706010200--
