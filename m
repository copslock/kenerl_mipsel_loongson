Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 11:55:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6817 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009494AbbJEJxBNLP25 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 11:53:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DFA1A124EF10C
        for <linux-mips@linux-mips.org>; Mon,  5 Oct 2015 10:52:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 5 Oct 2015 10:52:55 +0100
Received: from mredfearn-linux.le.imgtec.org (192.168.154.117) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 5 Oct 2015 10:52:54 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [RFC PATCH 7/7] MIPS: Add CONFIG_RELOCATABLE Kconfig option
Date:   Mon, 5 Oct 2015 10:52:31 +0100
Message-ID: <1444038751-25105-8-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1444038751-25105-1-git-send-email-matt.redfearn@imgtec.com>
References: <1444038751-25105-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.117]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49431
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

Add option to KConfig to enable the kernel to relocate
itself at runtime

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
 arch/mips/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6a69bdb07f18..beef7dfabd58 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2472,6 +2472,14 @@ config NUMA
 config SYS_SUPPORTS_NUMA
 	bool
 
+config RELOCATABLE
+	bool "Relocatable kernel"
+	help
+	  This builds a kernel image that retains relocation information
+	  so it can be loaded someplace besides the default 1MB.
+	  The relocations make the kernel binary about 15% larger,
+	  but are discarded at runtime
+
 config NODES_SHIFT
 	int
 	default "6"
-- 
2.1.4
