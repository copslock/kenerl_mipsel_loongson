Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2017 15:42:18 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:55870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992314AbdKSOla5u-Ei (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2017 15:41:30 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A25994A3;
        Sun, 19 Nov 2017 14:41:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.9 53/72] MIPS: init: Ensure reserved memory regions are not added to bootmem
Date:   Sun, 19 Nov 2017 15:38:57 +0100
Message-Id: <20171119143534.547793189@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171119143532.376035495@linuxfoundation.org>
References: <20171119143532.376035495@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61015
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

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>


[ Upstream commit e89ef66d7682f031f026eee6bba03c8c2248d2a9 ]

Memories managed through boot_mem_map are generally expected to define
non-crossing areas. However, if part of a larger memory block is marked
as reserved, it would still be added to bootmem allocator as an
available block and could end up being overwritten by the allocator.

Prevent this by explicitly marking the memory as reserved it if exists
in the range used by bootmem allocator.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14608/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/setup.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -551,6 +551,10 @@ static void __init bootmem_init(void)
 			continue;
 		default:
 			/* Not usable memory */
+			if (start > min_low_pfn && end < max_low_pfn)
+				reserve_bootmem(boot_mem_map.map[i].addr,
+						boot_mem_map.map[i].size,
+						BOOTMEM_DEFAULT);
 			continue;
 		}
 
