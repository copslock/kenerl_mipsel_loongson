Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 12:43:51 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994647AbeE1KnoZ6a20 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 12:43:44 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE9720844;
        Mon, 28 May 2018 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527504218;
        bh=HDKsPp72L58lfe66xuYKU1rraoH1eMLMpsdrjErNiQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHdRTalDVDnjEtnM0T8LIpaKKmAd6bVjqbFGaQDfmjt0T83NZgOsSeRLt8fgaNEql
         e3Q1t0AM5PvqSt2j6ruHCMadzknfDDGoBbT0k5PRIIxmjCvIIeYACJhm3wMwPUd/HG
         QswlsZPcr/5/mJ6leMXSo1gEh37qPwdw+nYRBsUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 057/496] MIPS: generic: Fix machine compatible matching
Date:   Mon, 28 May 2018 11:57:22 +0200
Message-Id: <20180528100322.195730290@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64106
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

[ Upstream commit 9a9ab3078e2744a1a55163cfaec73a5798aae33e ]

We now have a platform (Ranchu) in the "generic" platform which matches
based on the FDT compatible string using mips_machine_is_compatible(),
however that function doesn't stop at a blank struct
of_device_id::compatible as that is an array in the struct, not a
pointer to a string.

Fix the loop completion to check the first byte of the compatible array
rather than the address of the compatible array in the struct.

Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18580/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/machine.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/machine.h
+++ b/arch/mips/include/asm/machine.h
@@ -52,7 +52,7 @@ mips_machine_is_compatible(const struct
 	if (!mach->matches)
 		return NULL;
 
-	for (match = mach->matches; match->compatible; match++) {
+	for (match = mach->matches; match->compatible[0]; match++) {
 		if (fdt_node_check_compatible(fdt, 0, match->compatible) == 0)
 			return match;
 	}
