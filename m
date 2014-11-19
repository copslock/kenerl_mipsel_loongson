Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 22:14:57 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51676 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014044AbaKSVOzXmNJG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 22:14:55 +0100
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2812EA45;
        Wed, 19 Nov 2014 21:14:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yoichi Yuasa <yuasa@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Oliva <lxoliva@fsfla.org>
Subject: [PATCH 3.10 51/70] MIPS: Fix forgotten preempt_enable() when CPU has inclusive pcaches
Date:   Wed, 19 Nov 2014 12:52:42 -0800
Message-Id: <20141119205212.612724282@linuxfoundation.org>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <20141119205210.913169042@linuxfoundation.org>
References: <20141119205210.913169042@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoichi Yuasa <yuasa@linux-mips.org>

commit 5596b0b245fb9d2cefb5023b11061050351c1398 upstream.

[    1.904000] BUG: scheduling while atomic: swapper/1/0x00000002
[    1.908000] Modules linked in:
[    1.916000] CPU: 0 PID: 1 Comm: swapper Not tainted 3.12.0-rc2-lemote-los.git-5318619-dirty #1
[    1.920000] Stack : 0000000031aac000 ffffffff810d0000 0000000000000052 ffffffff802730a4
          0000000000000000 0000000000000001 ffffffff810cdf90 ffffffff810d0000
          ffffffff8068b968 ffffffff806f5537 ffffffff810cdf90 980000009f0782e8
          0000000000000001 ffffffff80720000 ffffffff806b0000 980000009f078000
          980000009f290000 ffffffff805f312c 980000009f05b5d8 ffffffff80233518
          980000009f05b5e8 ffffffff80274b7c 980000009f078000 ffffffff8068b968
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 980000009f05b520 0000000000000000 ffffffff805f2f6c
          0000000000000000 ffffffff80700000 ffffffff80700000 ffffffff806fc758
          ffffffff80700000 ffffffff8020be98 ffffffff806fceb0 ffffffff805f2f6c
          ...
[    2.028000] Call Trace:
[    2.032000] [<ffffffff8020be98>] show_stack+0x80/0x98
[    2.036000] [<ffffffff805f2f6c>] __schedule_bug+0x44/0x6c
[    2.040000] [<ffffffff805fac58>] __schedule+0x518/0x5b0
[    2.044000] [<ffffffff805f8a58>] schedule_timeout+0x128/0x1f0
[    2.048000] [<ffffffff80240314>] msleep+0x3c/0x60
[    2.052000] [<ffffffff80495400>] do_probe+0x238/0x3a8
[    2.056000] [<ffffffff804958b0>] ide_probe_port+0x340/0x7e8
[    2.060000] [<ffffffff80496028>] ide_host_register+0x2d0/0x7a8
[    2.064000] [<ffffffff8049c65c>] ide_pci_init_two+0x4e4/0x790
[    2.068000] [<ffffffff8049f9b8>] amd74xx_probe+0x148/0x2c8
[    2.072000] [<ffffffff803f571c>] pci_device_probe+0xc4/0x130
[    2.076000] [<ffffffff80478f60>] driver_probe_device+0x98/0x270
[    2.080000] [<ffffffff80479298>] __driver_attach+0xe0/0xe8
[    2.084000] [<ffffffff80476ab0>] bus_for_each_dev+0x78/0xe0
[    2.088000] [<ffffffff80478468>] bus_add_driver+0x230/0x310
[    2.092000] [<ffffffff80479b44>] driver_register+0x84/0x158
[    2.096000] [<ffffffff80200504>] do_one_initcall+0x104/0x160

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-mips@linux-mips.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Patchwork: https://patchwork.linux-mips.org/patch/5941/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Alexandre Oliva <lxoliva@fsfla.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/c-r4k.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -608,6 +608,7 @@ static void r4k_dma_cache_wback_inv(unsi
 			r4k_blast_scache();
 		else
 			blast_scache_range(addr, addr + size);
+		preempt_enable();
 		__sync();
 		return;
 	}
@@ -649,6 +650,7 @@ static void r4k_dma_cache_inv(unsigned l
 			 */
 			blast_inv_scache_range(addr, addr + size);
 		}
+		preempt_enable();
 		__sync();
 		return;
 	}
