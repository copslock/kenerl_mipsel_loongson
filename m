Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 10:08:22 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:50354 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491068Ab1CYJIT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Mar 2011 10:08:19 +0100
Received: by bwz1 with SMTP id 1so918588bwz.36
        for <linux-mips@linux-mips.org>; Fri, 25 Mar 2011 02:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=rYD40/jETXEeKKLbGAEn4Q8JhIk7GnJ4NgnW6JikXiE=;
        b=TtPZP0xkOuM4X5lp3IvWEf7gy6aJStSwwTHb9XlaDp0bT6iLyZe9JW7TV25wSHl3YP
         2cVL1mmRSm8uKK1YEI8dGLMJ140q5f0st6i4BWOkmQDmqbrU5fvZClfVpT2JQi4LsKk5
         gg7ZIG1YS9Ct+GF2HAou/e0rl4NAUF6cOwfd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=dsN0S/CeHxxFd0MEn9w+tSqDfkuCG8XiKCdVMySRQOuQuzxpiNEwwOahiHShlt5K29
         +dh4HVf9ScpzTGi5pRd555tw9tTPPWiLGnbGlu3H0rIby7B6UNIG/8JX46y6mEOq6b8P
         gGt5R22RckTwTet7RdhlMR7zR6V2dQBYSpZWE=
MIME-Version: 1.0
Received: by 10.204.126.147 with SMTP id c19mr473301bks.60.1301044093728; Fri,
 25 Mar 2011 02:08:13 -0700 (PDT)
Received: by 10.204.157.13 with HTTP; Fri, 25 Mar 2011 02:08:13 -0700 (PDT)
Date:   Fri, 25 Mar 2011 14:38:13 +0530
Message-ID: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
Subject: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Dear All,

We are working on 2.6.35.9 linux kernel on MIPS 34kce core and our
cache is VIVT having cache aliasing .
When I check the implementation on ARM I can check the implemenation
exists , but there is not similar implementation exists on MIPS.
These API's are used by XFS module:

static inline void flush_kernel_vmap_range(void *vaddr, int size)
static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
static inline void flush_kernel_dcache_page(struct page *page)


I can check implementation on ARM at
http://git.kernel.org/?p=linux/kernel/git/longterm/linux-2.6.34.y.git;a=commit;h=252a9afff76097667429b583e8b5b170b47665a4
 and
----------------------------------------------------------------------------------------------------------------------------
--- a/arch/arm/include/asm/cacheflush.h+++ b/arch/arm/include/asm/cacheflush.h
@@ -432,6 +432,16
 @@ static inline void __flush_icache_all(void)
  : "r" (0)); #endif }
+static inline void flush_kernel_vmap_range(void *addr, int size)
+{
+       if ((cache_is_vivt() || cache_is_vipt_aliasing()))
+         __cpuc_flush_dcache_area(addr, (size_t)size);
+}
+static inline void invalidate_kernel_vmap_range(void *addr, int size)
+{
+       if ((cache_is_vivt() || cache_is_vipt_aliasing()))
+         __cpuc_flush_dcache_area(addr, (size_t)size);
+}
-------------------------------------------------------------------------------------------------------------------------------------


http://git.kernel.org/?p=linux/kernel/git/longterm/linux-2.6.34.y.git;a=blobdiff;f=arch/arm/include/asm/cacheflush.h;h=1a711ea8418b6045c581a576caa3f85496ee2673;hp=bb7d695f3900f70d635a3597cd19d7cb68c0d732;hb=73be1591579084a8103a7005dd3172f3e9dd7362;hpb=44b7532b8b464f606053562400719c9c21276037

======================================================
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
+{
+       /* highmem pages are always flushed upon kunmap already */
+       if ((cache_is_vivt() || cache_is_vipt_aliasing()) && !PageHighMem(page))
+               __cpuc_flush_dcache_page(page_address(page));
+}
+
==========================================================


Is there any similar API exists for MIPS.  I want to use for XFS these API's

thanks
