Return-Path: <SRS0=q1L1=X7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A50C10F14
	for <linux-mips@archiver.kernel.org>; Sun,  6 Oct 2019 17:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9D82077B
	for <linux-mips@archiver.kernel.org>; Sun,  6 Oct 2019 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382603;
	bh=bMhHC+db4nOccSOwhA0fo5dCCOAtbBpAxKWNgXMQHcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pRfDwNUm3R1OAIEIomnaQIu5HTyqsUapX9Gbewyv41pZr68xH5aMZeyue2z1xZcIh
	 2v+v4Bsk4p0GPwcIrIwyjiSa9yw0GdBOM37LSe4VNsAf7RlISX8HuPut0Tp0F75yd+
	 8h6BrNJeJ8HJsYoEtq3vKh515F9ynadQMRMd4ETQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfJFRXW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbfJFRXV (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 6 Oct 2019 13:23:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2392720862;
        Sun,  6 Oct 2019 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382600;
        bh=bMhHC+db4nOccSOwhA0fo5dCCOAtbBpAxKWNgXMQHcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+xBPV2lKlhWM12vb6TUcgupzMn4H/OTRl+X97LlL5txJZ6ity6FvVxEnSQ2UfBkJ
         9/vc+pYab3+41nq3xvO3S6hGaYnDaxKiNNnPikxfmJ7uUEUsk8EYCui+uQoADHBZj1
         CV6/o/1PF1D0DPCr9a3GaY5hQ9gnDBsEdxyT1xeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 19/47] MIPS: tlbex: Explicitly cast _PAGE_NO_EXEC to a boolean
Date:   Sun,  6 Oct 2019 19:21:06 +0200
Message-Id: <20191006172017.899294811@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006172016.873463083@linuxfoundation.org>
References: <20191006172016.873463083@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit c59ae0a1055127dd3828a88e111a0db59b254104 ]

clang warns:

arch/mips/mm/tlbex.c:634:19: error: use of logical '&&' with constant
operand [-Werror,-Wconstant-logical-operand]
        if (cpu_has_rixi && _PAGE_NO_EXEC) {
                         ^  ~~~~~~~~~~~~~
arch/mips/mm/tlbex.c:634:19: note: use '&' for a bitwise operation
        if (cpu_has_rixi && _PAGE_NO_EXEC) {
                         ^~
                         &
arch/mips/mm/tlbex.c:634:19: note: remove constant to silence this
warning
        if (cpu_has_rixi && _PAGE_NO_EXEC) {
                        ~^~~~~~~~~~~~~~~~
1 error generated.

Explicitly cast this value to a boolean so that clang understands we
intend for this to be a non-zero value.

Fixes: 00bf1c691d08 ("MIPS: tlbex: Avoid placing software PTE bits in Entry* PFN fields")
Link: https://github.com/ClangBuiltLinux/linux/issues/609
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/mm/tlbex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 3cc5b2e4263c0..47d50197789be 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -637,7 +637,7 @@ static __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 		return;
 	}
 
-	if (cpu_has_rixi && _PAGE_NO_EXEC) {
+	if (cpu_has_rixi && !!_PAGE_NO_EXEC) {
 		if (fill_includes_sw_bits) {
 			UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL));
 		} else {
-- 
2.20.1



