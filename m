Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 10:52:42 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993868AbdJFIwfMrqco (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 10:52:35 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A1A1D5B1;
        Fri,  6 Oct 2017 08:52:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.9 011/104] MIPS: kexec: Do not reserve invalid crashkernel memory on boot
Date:   Fri,  6 Oct 2017 10:50:49 +0200
Message-Id: <20171006083842.433773825@linuxfoundation.org>
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
X-archive-position: 60295
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


[ Upstream commit a8f108d70c74d83574c157648383eb2e4285a190 ]

Do not reserve memory for the crashkernel if the commandline argument
points to a wrong location. This can happen if the location is specified
wrong or if the same commandline is reused when starting the crashkernel
- in the latter case the reserved memory would point to the location
from which the crashkernel is executing.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14612/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/setup.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -668,6 +668,11 @@ static void __init mips_parse_crashkerne
 	if (ret != 0 || crash_size <= 0)
 		return;
 
+	if (!memory_region_available(crash_base, crash_size)) {
+		pr_warn("Invalid memory region reserved for crash kernel\n");
+		return;
+	}
+
 	crashk_res.start = crash_base;
 	crashk_res.end	 = crash_base + crash_size - 1;
 }
