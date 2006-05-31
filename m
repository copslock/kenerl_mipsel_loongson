Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 05:42:36 +0200 (CEST)
Received: from sigrand.ru ([80.66.88.167]:36282 "HELO mail.sigrand.com")
	by ftp.linux-mips.org with SMTP id S8133396AbWEaDm2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 05:42:28 +0200
Received: from develop (unknown [192.168.2.238])
	by mail.sigrand.com (Postfix) with ESMTP id 232AE12A0010
	for <linux-mips@linux-mips.org>; Wed, 31 May 2006 10:42:26 +0700 (NOVST)
Date:	Wed, 31 May 2006 10:42:27 +0700
From:	art <art@sigrand.ru>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <18446.060531@sigrand.ru>
To:	linux-mips@linux-mips.org
Subject: Problem with TLB mcheck!
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <art@sigrand.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: art@sigrand.ru
Precedence: bulk
X-list: linux-mips

Sorry for resending, but I find out that I wasn't subscribed!
I use 2.6.16 kernel from linux-mips.org (from tarrball).
When I execute:
# cat /bin/busybox > box
Got mcheck at 800f9b68
Cpu 0
$ 0   : 00000000 10008400 c00216bc c00316bc
$ 4   : c00116bc 00004000 00000005 00008000
$ 8   : c00356bc c003d6bc c00016bc 00010000
$12   : 0000000f 00008000 00007fff 00007fff
$16   : 00000003 8024da80 00000008 c0000000
$20   : 00000000 803d7000 8118c000 80240000
$24   : 0000000f 00000000
$28   : 81200000 81201b80 00001000 800f9c0c
Hi    : 0000000b
Lo    : 5555555b
epc   : 800f9b68 zlib_deflateInit2_+0x184/0x200     Not tainted
ra    : 800f9c0c zlib_deflateInit_+0x28/0x34
Status: 10208403    KERNEL EXL IE
Cause : 00800060
PrId  : 0001800b
Hi    : 0000000b
Pagemask: ffffffff
EntryHi : c0000096
EntryLo0: 0000a05f
EntryLo1: 0000a09f

Index:  3 pgmask=4kb va=00468000 asid=96
                        [pa=00378000 c=3 d=0 v=1 g=0]
                        [pa=00000000 c=0 d=0 v=0 g=0]

Index:  6 pgmask=4kb va=7fa0a000 asid=96
                        [pa=012f7000 c=3 d=1 v=1 g=0]
                        [pa=01244000 c=3 d=1 v=1 g=0]

Index:  7 pgmask=4kb va=004f0000 asid=96
                        [pa=012f4000 c=3 d=1 v=1 g=0]
                        [pa=00000000 c=0 d=0 v=0 g=0]

Index: 10 pgmask=4kb va=0046e000 asid=96
                        [pa=00310000 c=3 d=0 v=1 g=0]
                        [pa=00311000 c=3 d=0 v=1 g=0]

Index: 11 pgmask=4kb va=0046a000 asid=96
                        [pa=0030c000 c=3 d=0 v=1 g=0]
                        [pa=00000000 c=0 d=0 v=0 g=0]

Index: 15 pgmask=4kb va=0048c000 asid=96
                        [pa=0032e000 c=3 d=0 v=1 g=0]
                        [pa=0032f000 c=3 d=0 v=1 g=0]


Code: 00684021  00055880  ae33001c <ae640038> a272001d  ae740018 
ae6e002c  ae6f004c  ae660050
Kernel panic - not syncing: Caught Machine Check exception - caused
by multiple matching entries in the TLB.

This thig happens, as I noted, when work with relatively big amounts
of memory ( more than 10-60Kb). busybox for example 700Kb


-- 
Best regards,
 art                            mailto:art@sigrand.ru
