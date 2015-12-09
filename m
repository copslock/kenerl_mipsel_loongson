Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 06:40:04 +0100 (CET)
Received: from col004-omc4s12.hotmail.com ([65.55.34.214]:64135 "EHLO
        COL004-OMC4S12.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013510AbbLIFkCyBKcj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Dec 2015 06:40:02 +0100
Received: from COL125-W1 ([65.55.34.201]) by COL004-OMC4S12.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
         Tue, 8 Dec 2015 21:39:56 -0800
X-TMN:  [2FAUjYVg4BT7P/DomSor8DSa7POfzCiE]
X-Originating-Email: [james_mcmechan@hotmail.com]
Message-ID: <COL125-W1B4749BC1353F985C5262E2E80@phx.gbl>
From:   James McMechan <james_mcmechan@hotmail.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Octeon3 switching from vendor->vanilla
Date:   Tue, 8 Dec 2015 21:39:55 -0800
Importance: Normal
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 09 Dec 2015 05:39:56.0149 (UTC) FILETIME=[090D5A50:01D13244]
Return-Path: <james_mcmechan@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james_mcmechan@hotmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello,
I have been playing with a octeon3 (MIPS64r2 ITUS Shield) box I got the other day and I seem to almost have the vanilla kernel going.
The vendor SDK has a 3.10.20-rt14 kernel with apparently a fair stack of patches, I can recompile their kernel and it boots ok.
I of course would be happier with a vanilla kernel so I have been trying to get 4.3 up.
To me it looks like most of the patches they had have already been unstreamed.
4.3 boots and seems to get to pci bus initialization before dying.
The documentation I googled up seems to be talking about the new pci stuff for 2.6 and I have been getting hits from 2009 and 2011 which seem to be when the first Octeon processors were being ported.
Specifically I think my problem is in this part of the boot log

Enabling Octeon big bar support
PCI Status: PCI 64-bit                                                          
vgaarb: loaded                                  
SCSI subsystem initialized            
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0x11b00f0000000-0x11b0130000000] (bus address [0xf0000000-0x130000000])
pci_bus 0000:00: root bus resource [io  0x4000-0xffffffff]
pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
Data bus error, epc == ffffffff8148fb20, ra == ffffffff813c8750
Oops[#1]:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.3.0 #2                              
task: 800000004ec52c08 ti: 800000004ec54000 task.ti: 800000004ec54000           
$ 0   : 0000000000000000 0000000014109ce1 8001190400000000 0000000000000001     
$ 4   : 0000000000000000 0000000000000000 0000000000000000 0000000000000004     
$ 8   : 800000004ec57bc0 ffffffff8174c1c8 ffffffff817c0000 ffffffff81740000     
$12   : 0000000000000020 ffffffff8139b66c ffffffff817c0000 0000000000000000     
$16   : 800000004ee09400 800000004ec57c50 ffffffff827d0000 0000000000000001     
$20   : 0000000000000000 ffffffff817692a0 0000000000000000 ffffffff81797758     
$24   : ffffffffffffffff ffffffff8116e438                                       
$28   : 800000004ec54000 800000004ec57bc0 ffffffff817b0000 ffffffff813c8750     
Hi    : 0000000000000000                                                        
Lo    : 08d4a84676000000                                                        
epc   : ffffffff8148fb20 octeon_read_config+0x60/0x90                           
ra    : ffffffff813c8750 pci_bus_read_config_dword+0x88/0xc0                    
Status: 14109ce2        KX SX UX KERNEL EXL                                     
Cause : 4080801c (ExcCode 07)                                                   
PrId  : 000d9602 (Cavium Octeon III)                                            
Modules linked in:                                                              
Process swapper/0 (pid: 1, threadinfo=800000004ec54000, task=800000004ec52c08, t
Stack : 0000000000000001 ffffffff81166f24 0000000000000000 0000000000000000     
          ffffffff8174c550 0000000000000000 800000004ec57c50 000000000000ea60   
          800000004ee09400 ffffffff813cabc0 0000000000000000 0000000000000000   
          800000004ee09400 0000000000000000 0000000000000000 ffffffff817692a0   
          ffffffff816f56d8 ffffffff813cc494 800000004ec57c78 ffffffff815cf3f0   
          800000004ed9c320 0000000000000000 800000004ee09400 0000000000000100   
          0000000000000000 ffffffff813cc594 ffffffff817c0000 0000000000000000   
          800000004ee09400 0000000000000100 0000000000000000 ffffffff813cd66c
          ffffffff8174c1c8 800000004ee09400 0000000000000000 0000000000000000   
          0000000000000000 0000000000000000 ffffffff817692a0 ffffffff813cd984   
          ...                                                                   
Call Trace:                                                                     
[<ffffffff8148fb20>] octeon_read_config+0x60/0x90                               
[<ffffffff813c8750>] pci_bus_read_config_dword+0x88/0xc0                        
[<ffffffff813cabc0>] pci_bus_read_dev_vendor_id+0x40/0x180                      
[<ffffffff813cc494>] pci_scan_single_device+0x6c/0x100                          
[<ffffffff813cc594>] pci_scan_slot+0x6c/0x140                                   
[<ffffffff813cd66c>] pci_scan_child_bus+0x3c/0x100                              
[<ffffffff813cd984>] pci_scan_root_bus_msi+0xbc/0xe8                            
[<ffffffff8148f568>] pcibios_scanbus+0x98/0x168                                 
[<ffffffff817899ec>] pcibios_init+0x5c/0x98                                     
[<ffffffff81100530>] do_one_initcall+0x98/0x1b8                                 
[<ffffffff81769cec>] kernel_init_freeable+0x168/0x23c                           
[<ffffffff815c9ddc>] kernel_init+0x14/0x110                                     
[<ffffffff8111d8ac>] ret_from_kernel_thread+0x14/0x1c

I am especially suspicious of the line

pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]

where it has not selected either memory or io space

Is there a more proper place to ask this sort of question?

I did look at https://www.linux-mips.org/wiki/PCI_Subsystem but it seems quite dated.
The section -- PCI startup sequence (line 4) starts with "somewhere inside of pcibios_init" which seems to be where 4.3 is crashing but does not expand on it very much.
I am sort of familiar with how PCI works on x86 with config space & BARs and have written userspace and kernel drivers, but I usually let Linux configure the BARs for me.

Is there something I should be studying up on?

Thank you,

Jim McMechan
 		 	   		  
From Matt.Redfearn@imgtec.com Wed Dec  9 10:43:30 2015
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 10:43:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25069 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013533AbbLIJnatu04S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 10:43:30 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 4E449C4F0C33A;
        Wed,  9 Dec 2015 09:43:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 9 Dec 2015 09:43:24 +0000
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 9 Dec 2015 09:43:24 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <james.hogan@imgtec.com>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: malta-time: Fix logic inversion waiting for RTC
Date:   Wed, 9 Dec 2015 09:43:15 +0000
Message-ID: <1449654195-18034-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Content-Length: 1443
Lines: 41

When estimating the clock frequency based on the RTC, the Update In
Progress flag is used to wait one second. However, the logic waiting for
the falling edge of this signal was inverted such that any read of the
RTC registers may actually occur during the update window and be
undefined.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mti-malta/malta-time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 67eff9ed157c..3b97cfd0cf4c 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -84,8 +84,8 @@ static void __init estimate_frequencies(void)
 	local_irq_save(flags);
 
 	/* Start counter exactly on falling edge of update flag. */
-	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
+	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 
 	/* Initialize counters. */
 	start = read_c0_count();
@@ -96,8 +96,8 @@ static void __init estimate_frequencies(void)
 	secs1 = CMOS_READ(RTC_SECONDS);
 
 	/* Read counter exactly on falling edge of update flag. */
-	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
+	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 
 	count = read_c0_count();
 	if (gic_present)
-- 
2.1.4
