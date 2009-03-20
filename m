Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2009 23:45:44 +0000 (GMT)
Received: from mail.kernelconcepts.de ([212.60.202.196]:6573 "EHLO
	mail.kernelconcepts.de") by ftp.linux-mips.org with ESMTP
	id S21367165AbZCTXph (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Mar 2009 23:45:37 +0000
Received: from [92.227.178.70] (helo=[192.168.178.35])
	by mail.kernelconcepts.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nils.faerber@kernelconcepts.de>)
	id 1LkogM-0003Ed-TG
	for linux-mips@linux-mips.org; Sat, 21 Mar 2009 01:03:23 +0100
Message-ID: <49C42A9B.5050103@kernelconcepts.de>
Date:	Sat, 21 Mar 2009 00:45:31 +0100
From:	Nils Faerber <nils.faerber@kernelconcepts.de>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Need help iterpreting reg-dump
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <nils.faerber@kernelconcepts.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nils.faerber@kernelconcepts.de
Precedence: bulk
X-list: linux-mips

Hello all!
By some (unlucky :) coincidence I recently came into posession of a
Ingenic JZ4730 based subnotebook and am since trying to get a more
recent kernel to boot. The only base I have at hand is 2.6.24.3 - sorry
for that. I already described most of the details in an earlier post
"Ingenic JZ4730 - illegal instruction".
Anyway I chased the issue further an now found at lteast a single point
in the kernel where the SIGILL for the applicaiton is generated, it is
arch/mips/kernel/unaligned.c

When I set the action to UNALIGNED_ACTION_SHOW I get the following dump
whenever an application causes the fault to happen:

[42949562.570000] Cpu 0
[42949562.570000] $ 0   : 00000000 10000400 ffffff93 00000020
[42949562.580000] $ 4   : 00000001 0000006d 000000c0 2aad225d
[42949562.580000] $ 8   : 00000040 fffffffe 0000000c 0000000c
[42949562.590000] $12   : 0000006d 00000003 00000003 00000000
[42949562.590000] $16   : 2aad2ee8 2aad2ef0 005ab1d8 005ab1e0
[42949562.600000] $20   : 7f8faae0 2b2a6340 7f8faa40 2aad2ee8
[42949562.610000] $24   : 00000000 2b283010
[42949562.610000] $28   : 2b2ae420 7f8faa08 00000001 2b27bda0
[42949562.620000] Hi    : 00000002
[42949562.620000] Lo    : 0f02cdc0
[42949562.620000] epc   : 7f8faa00 0x7f8faa00     Not tainted
[42949562.630000] ra    : 2b27bda0 0x2b27bda0
[42949562.630000] Status: 00000413    USER EXL IE
[42949562.640000] Cause : 00800010
[42949562.640000] BadVA : 00000001
[42949562.640000] PrId  : 02d0024f (Ingenic JZRISC)
[42949562.650000] Modules linked in:
[42949562.650000] Process gpe-info (pid: 1476, threadinfo=87cac000,
task=87dc29d
8)
[42949562.660000] Stack : 2b2ae420 7f8faa58 00000000 2b665794 2b2ae420
2b665794
2b27b8a0 2b27b8d8
[42949562.670000]         2b750950 004b6ab8 2b74a75c 00000010 2b2ae420
2aad2e30
00000003 00000005
[42949562.680000]         2aad2250 005a27d0 a2879f2e 547d42ae 2aad2e40
00000001
00598ad0 2aad2e30
[42949562.680000]         005a27d0 7f8faae0 7f8faad8 2b27b72c 7f8faaf0
2b27c8ec
00000000 40237200
[42949562.690000]         eb851eb8 401c0051 7ff80000 7ff80000 7ff80000
7ff80000
7ff80000 7ff80000
[42949562.700000]         ...
[42949562.710000] Call Trace:
[42949562.710000]
[42949562.710000]
[42949562.710000] Code: 2aad2ef0  8fbc0010  8c000001 <0000bd36> 2b27bd7c
 2b2ae4
20  7f8faa58  00000000  2b665794


The interesting point for me is now that I always end up in the
unaligned handler and never in some other random handler. This tells me
that the cache is probably not the faulty part (since then different
illegal instrcustion should occur) but rather the unalignement handling.
I am not familiar enough with MIPS to decipher the dump into something
useful.
So could someone maybe give me at least a hint in which direction to
look? A little bit more specific than just "CPU manual" would be great ;)

Many thanks in advance!

Cheers
  nils faerber

-- 
kernel concepts GbR      Tel: +49-271-771091-12
Sieghuetter Hauptweg 48  Fax: +49-271-771091-19
D-57072 Siegen           Mob: +49-176-21024535
--
