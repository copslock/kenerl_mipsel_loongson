Return-Path: <SRS0=SDB9=VF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C936AC606C2
	for <linux-mips@archiver.kernel.org>; Mon,  8 Jul 2019 15:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BF621537
	for <linux-mips@archiver.kernel.org>; Mon,  8 Jul 2019 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600292;
	bh=oqJOOPIzXqtL84WhyP7K9dTw3vqk5/8dazpQ8iRpGL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1QtM+NVbN3+oMGhLd/6kRI/A20s68nnaVq3EWxMXIdEs8zOE9OnKM49BWdcNfUzJ
	 19tFDHr66v4/E4QNvvWeyfXjGEPkKFX+6HqVCATrrdzlar67EY15umBQ7bNMfxDAWR
	 C3SsYKNxDcjsBBl/DvPjo9iwZcGC++oUMIxU6V10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389720AbfGHPaq (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730174AbfGHPap (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 8 Jul 2019 11:30:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FF8216C4;
        Mon,  8 Jul 2019 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599844;
        bh=oqJOOPIzXqtL84WhyP7K9dTw3vqk5/8dazpQ8iRpGL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtLBaEHuX506Uwg6vmtgMB3iqJyh0Imvmt5ivP57+sSv6SM8AVRBt75SosmkVuS8A
         yvkoxdDrX0QJD2horKqahtwsR7jx83Lnl8dOEl9SwLpYA9an42pvsVYWceQkEQdCS0
         m//xPP1l9vEDDkW68loQHneWGauvgcTD7xG19qD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org,
        jhogan@kernel.org, f4bug@amsat.org, linux-mips@vger.kernel.org,
        ysu@wavecomp.com, jcristau@debian.org
Subject: [PATCH 4.19 86/90] MIPS: Fix bounds check virt_addr_valid
Date:   Mon,  8 Jul 2019 17:13:53 +0200
Message-Id: <20190708150526.824054542@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Hauke Mehrtens <hauke@hauke-m.de>

commit d6ed083f5cc621e15c15b56c3b585fd524dbcb0f upstream.

The bounds check used the uninitialized variable vaddr, it should use
the given parameter kaddr instead. When using the uninitialized value
the compiler assumed it to be 0 and optimized this function to just
return 0 in all cases.

This should make the function check the range of the given address and
only do the page map check in case it is in the expected range of
virtual addresses.

Fixes: 074a1e1167af ("MIPS: Bounds check virt_addr_valid")
Cc: stable@vger.kernel.org # v4.12+
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: f4bug@amsat.org
Cc: linux-mips@vger.kernel.org
Cc: ysu@wavecomp.com
Cc: jcristau@debian.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/mmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -203,7 +203,7 @@ unsigned long arch_randomize_brk(struct
 
 int __virt_addr_valid(const volatile void *kaddr)
 {
-	unsigned long vaddr = (unsigned long)vaddr;
+	unsigned long vaddr = (unsigned long)kaddr;
 
 	if ((vaddr < PAGE_OFFSET) || (vaddr >= MAP_BASE))
 		return 0;


