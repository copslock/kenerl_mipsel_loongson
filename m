Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 08:53:44 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:37903 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225278AbTDPHxM>;
	Wed, 16 Apr 2003 08:53:12 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id AFAC2B4E4
	for <linux-mips@linux-mips.org>; Wed, 16 Apr 2003 09:53:05 +0200 (CEST)
Message-ID: <3E9D0C34.38FE2749@ekner.info>
Date: Wed, 16 Apr 2003 09:54:28 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: MIPS32 cache functions now using c-r4k?
Content-Type: multipart/alternative;
 boundary="------------3F31D38311D1520593E361CC"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips


--------------3F31D38311D1520593E361CC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On a MIPS32 CPU (Au1500), I now end up in:

Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x802d0ab8
Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x44000000
Reserved instruction in kernel code in traps.c::do_ri, line 650:
$0 : 00000000 810e4000 802d0000 80109654 810e3000 802c4754 00000000 80000000
$8 : 8102e720 00000001 8010b98c c0000000 001fffff c0000000 fffffff4 00000010
$16: 810e3000 802d1340 802b9800 802bc000 00000000 00000000 00101000 00000000
$24: ffffffff 810ebde7                   810ea000 810ebd68 00000000 80121adc
Hi : 00000000
Lo : 000000c0
epc  : 8010965c    Not tainted
Status: 1000fc02
Cause : 00800028
Process swapper (pid: 1, stackpage=810ea000)

Which is:

80109654 <r4k_clear_page_d32>:
80109654:       24811000        addiu   $at,$a0,4096
80109658:       bc8d0000        cache   0xd,0($a0)
8010965c:       fc800000        sdc3    $0,0($a0)
80109660:       fc800008        sdc3    $0,8($a0)
80109664:       fc800010        sdc3    $0,16($a0)
80109668:       fc800018        sdc3    $0,24($a0)
8010966c:       24840040        addiu   $a0,$a0,64
80109670:       bc8dffe0        cache   0xd,-32($a0)
80109674:       fc80ffe0        sdc3    $0,-32($a0)
80109678:       fc80ffe8        sdc3    $0,-24($a0)
8010967c:       fc80fff0        sdc3    $0,-16($a0)
80109680:       1424fff5        bne     $at,$a0,80109658 <r4k_clear_page_d32+0x4>
80109684:       fc80fff8        sdc3    $0,-8($a0)
80109688:       03e00008        jr      $ra

It seems much of the r4k cache code assumes the presence of SD - which breaks on all MIPS32 CPU's?

/Hartvig


--------------3F31D38311D1520593E361CC
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<tt>On a MIPS32 CPU (Au1500), I&nbsp;now end up in:</tt><tt></tt>
<p><tt>Mount cache hash table entries: 512 (order: 0, 4096 bytes)</tt>
<br><tt>Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)</tt>
<br><tt>Page-cache hash table entries: 16384 (order: 4, 65536 bytes)</tt>
<br><tt>Checking for 'wait' instruction...&nbsp; available.</tt>
<br><tt>POSIX conformance testing by UNIFIX</tt>
<br><tt>Autoconfig PCI channel 0x802d0ab8</tt>
<br><tt>Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x44000000</tt>
<br><tt>Reserved instruction in kernel code in traps.c::do_ri, line 650:</tt>
<br><tt>$0 : 00000000 810e4000 802d0000 80109654 810e3000 802c4754 00000000
80000000</tt>
<br><tt>$8 : 8102e720 00000001 8010b98c c0000000 001fffff c0000000 fffffff4
00000010</tt>
<br><tt>$16: 810e3000 802d1340 802b9800 802bc000 00000000 00000000 00101000
00000000</tt>
<br><tt>$24: ffffffff 810ebde7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
810ea000 810ebd68 00000000 80121adc</tt>
<br><tt>Hi : 00000000</tt>
<br><tt>Lo : 000000c0</tt>
<br><tt>epc&nbsp; : 8010965c&nbsp;&nbsp;&nbsp; Not tainted</tt>
<br><tt>Status: 1000fc02</tt>
<br><tt>Cause : 00800028</tt>
<br><tt>Process swapper (pid: 1, stackpage=810ea000)</tt><tt></tt>
<p><tt>Which is:</tt><tt></tt>
<p><tt>80109654 &lt;r4k_clear_page_d32>:</tt>
<br><tt>80109654:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24811000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
addiu&nbsp;&nbsp; $at,$a0,4096</tt>
<br><tt>80109658:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bc8d0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
cache&nbsp;&nbsp; 0xd,0($a0)</tt>
<br><tt>8010965c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fc800000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
sdc3&nbsp;&nbsp;&nbsp; $0,0($a0)</tt>
<br><tt>80109660:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fc800008&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
sdc3&nbsp;&nbsp;&nbsp; $0,8($a0)</tt>
<br><tt>80109664:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fc800010&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
sdc3&nbsp;&nbsp;&nbsp; $0,16($a0)</tt>
<br><tt>80109668:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fc800018&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
sdc3&nbsp;&nbsp;&nbsp; $0,24($a0)</tt>
<br><tt>8010966c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24840040&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
addiu&nbsp;&nbsp; $a0,$a0,64</tt>
<br><tt>80109670:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bc8dffe0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
cache&nbsp;&nbsp; 0xd,-32($a0)</tt>
<br><tt>80109674:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fc80ffe0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
sdc3&nbsp;&nbsp;&nbsp; $0,-32($a0)</tt>
<br><tt>80109678:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fc80ffe8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
sdc3&nbsp;&nbsp;&nbsp; $0,-24($a0)</tt>
<br><tt>8010967c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fc80fff0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
sdc3&nbsp;&nbsp;&nbsp; $0,-16($a0)</tt>
<br><tt>80109680:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1424fff5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
bne&nbsp;&nbsp;&nbsp;&nbsp; $at,$a0,80109658 &lt;r4k_clear_page_d32+0x4></tt>
<br><tt>80109684:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fc80fff8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
sdc3&nbsp;&nbsp;&nbsp; $0,-8($a0)</tt>
<br><tt>80109688:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 03e00008&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
jr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ra</tt><tt></tt>
<p><tt>It seems much of the r4k cache code assumes the presence of SD&nbsp;-
which breaks on all MIPS32 CPU's?</tt><tt></tt>
<p><tt>/Hartvig</tt>
<br><tt></tt>&nbsp;</html>

--------------3F31D38311D1520593E361CC--
