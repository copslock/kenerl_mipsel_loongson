Return-Path: <SRS0=t3K6=UI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B20C28EBD
	for <linux-mips@archiver.kernel.org>; Sun,  9 Jun 2019 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7FC2067C
	for <linux-mips@archiver.kernel.org>; Sun,  9 Jun 2019 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100674;
	bh=TJCm5AsGVKgzsrO8Flov/50oIA64VW2TAdaGPxGaYm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=orcm1kyxPB7Y1fTh/L9R+7WrEIm6fNcfciZA5RU1pp4vmsqWh/G+g+sr9eRHa5nFp
	 mPl4NWS+oAHqHv6wqjqweUKLjrehw4Deu68Qy3Kn+n8qf/vjxSReytBwDyK4i43m5D
	 0NBtue5LTL4rd9cs2UIhkPZ3KaorVTr2R4/jJO8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfFIQvY (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbfFIQvY (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 9 Jun 2019 12:51:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 170D42070B;
        Sun,  9 Jun 2019 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099083;
        bh=TJCm5AsGVKgzsrO8Flov/50oIA64VW2TAdaGPxGaYm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOMz/sFk3z1bS9koZ9U2xuxboNBDvCdj5WxvkpEKvAfBHLXwKGUOmfxx3J64fU41Y
         Kz4KoRS4xfX9XUrGInOfo1iGaI4dL3h3X+wZp1myOblpQ+F0GpuBWS+i3tWAK4PvaO
         eaH6VS07PScMTz0Uf61gFFrnKw+eDTgmwXe02K1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Julien Cristau <jcristau@debian.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        YunQiang Su <ysu@wavecomp.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.14 21/35] MIPS: Bounds check virt_addr_valid
Date:   Sun,  9 Jun 2019 18:42:27 +0200
Message-Id: <20190609164126.752755650@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164125.377368385@linuxfoundation.org>
References: <20190609164125.377368385@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

commit 074a1e1167afd82c26f6d03a9a8b997d564bb241 upstream.

The virt_addr_valid() function is meant to return true iff
virt_to_page() will return a valid struct page reference. This is true
iff the address provided is found within the unmapped address range
between PAGE_OFFSET & MAP_BASE, but we don't currently check for that
condition. Instead we simply mask the address to obtain what will be a
physical address if the virtual address is indeed in the desired range,
shift it to form a PFN & then call pfn_valid(). This can incorrectly
return true if called with a virtual address which, after masking,
happens to form a physical address corresponding to a valid PFN.

For example we may vmalloc an address in the kernel mapped region
starting a MAP_BASE & obtain the virtual address:

  addr = 0xc000000000002000

When masked by virt_to_phys(), which uses __pa() & in turn CPHYSADDR(),
we obtain the following (bogus) physical address:

  addr = 0x2000

In a common system with PHYS_OFFSET=0 this will correspond to a valid
struct page which should really be accessed by virtual address
PAGE_OFFSET+0x2000, causing virt_addr_valid() to incorrectly return 1
indicating that the original address corresponds to a struct page.

This is equivalent to the ARM64 change made in commit ca219452c6b8
("arm64: Correctly bounds check virt_addr_valid").

This fixes fallout when hardened usercopy is enabled caused by the
related commit 517e1fbeb65f ("mm/usercopy: Drop extra
is_vmalloc_or_module() check") which removed a check for the vmalloc
range that was present from the introduction of the hardened usercopy
feature.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Julien Cristau <jcristau@debian.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: YunQiang Su <ysu@wavecomp.com>
URL: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=929366
Cc: stable@vger.kernel.org # v4.12+
Cc: linux-mips@vger.kernel.org
Cc: Yunqiang Su <ysu@wavecomp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/mmap.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -203,6 +203,11 @@ unsigned long arch_randomize_brk(struct
 
 int __virt_addr_valid(const volatile void *kaddr)
 {
+	unsigned long vaddr = (unsigned long)vaddr;
+
+	if ((vaddr < PAGE_OFFSET) || (vaddr >= MAP_BASE))
+		return 0;
+
 	return pfn_valid(PFN_DOWN(virt_to_phys(kaddr)));
 }
 EXPORT_SYMBOL_GPL(__virt_addr_valid);


