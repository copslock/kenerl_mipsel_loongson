Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 10:56:15 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:52266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993915AbdJFIzTEk7Yo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 10:55:19 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 932525B1;
        Fri,  6 Oct 2017 08:55:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.9 077/104] MIPS: smp-cps: Fix retrieval of VPE mask on big endian CPUs
Date:   Fri,  6 Oct 2017 10:51:55 +0200
Message-Id: <20171006083852.253825982@linuxfoundation.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171006083840.743659740@linuxfoundation.org>
References: <20171006083840.743659740@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60303
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>


[ Upstream commit fb2155e3c30dc2043b52020e26965067a3e7779c ]

The vpe_mask member of struct core_boot_config is of type atomic_t,
which is a 32bit type. In cps-vec.S this member was being retrieved by a
PTR_L macro, which on 64bit systems is a 64bit load. On little endian
systems this is OK, since the double word that is retrieved will have
the required less significant word in the correct position. However, on
big endian systems the less significant word of the load is retrieved
from address+4, and the more significant from address+0. The destination
register therefore ends up with the required word in the more
significant word
e.g. when starting the second VP of a big endian 64bit system, the load

PTR_L    ta2, COREBOOTCFG_VPEMASK(a0)

ends up setting register ta2 to 0x0000000300000000

When this value is written to the CPC it is ignored, since it is
invalid to write anything larger than 4 bits. This results in any VP
other than VP0 in a core failing to start in 64bit big endian systems.

Change the load to a 32bit load word instruction to fix the bug.

Fixes: f12401d7219f ("MIPS: smp-cps: Pull boot config retrieval out of mips_cps_boot_vpes")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15787/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/cps-vec.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -361,7 +361,7 @@ LEAF(mips_cps_get_bootcfg)
 	END(mips_cps_get_bootcfg)
 
 LEAF(mips_cps_boot_vpes)
-	PTR_L	ta2, COREBOOTCFG_VPEMASK(a0)
+	lw	ta2, COREBOOTCFG_VPEMASK(a0)
 	PTR_L	ta3, COREBOOTCFG_VPECONFIG(a0)
 
 #if defined(CONFIG_CPU_MIPSR6)
