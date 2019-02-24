Return-Path: <SRS0=K/c0=Q7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1736C43381
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 09:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B09206B6
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 09:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="D3Kfl8Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfBXJpj (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 24 Feb 2019 04:45:39 -0500
Received: from [115.28.160.31] ([115.28.160.31]:45132 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1728184AbfBXJpj (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Sun, 24 Feb 2019 04:45:39 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Feb 2019 04:45:36 EST
Received: from localhost.localdomain (unknown [116.236.177.50])
        by mailbox.box.xen0n.name (Postfix) with ESMTPA id 4287B6013E;
        Sun, 24 Feb 2019 17:36:53 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1551001013; bh=SaS7/8iwYty2/Hsjn2E7qt7xar4Vw3GgVVK1Y/USQe4=;
        h=From:To:Cc:Subject:Date:From;
        b=D3Kfl8Am9zkPfEO68QvYYjiP9u6X/OFXgXyUhtYIWWd1YMw6JAp8DAXNaNWnEYgK2
         w37Vn9u1/6zc5L2NC78pb4aAi1NZL1W9fyGwg4ngAX/6p3bEJWcr0JfyY7XmsW7XKo
         hxFVMXfaw9b96iX87YxvXMKz8XEpfRJMYwQThW6A=
From:   kernel@xen0n.name
To:     linux-mips@vger.kernel.org
Cc:     Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [RFC PATCH 0/2] MIPS: Loongson: ExtCC clocksource support
Date:   Sun, 24 Feb 2019 17:36:33 +0800
Message-Id: <20190224093635.1242-1-kernel@xen0n.name>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Wang Xuerui <wangxuerui@qiniu.com>

Hi,

This is my WIP patchset to add support for using the on-chip ExtCC
(external counter) register as clocksource, to boost the real-time
performance on Loongson platform. I'm posting this to solicit comments
and get some of the unresolved questions answered.

* I don't have access to multi-socket ccNUMA Loongson boards. The code
  most certainly doesn't work on such hardware, so either someone with
  expertise would teach me how to do this, or get this done on their
  own.
* I'm not sure of the pipeline behavior of the rdhwr instruction used.
  The current implementation has a sync (roughly the x86 way), and I'm
  not sure if it can be safely omitted, or even moved into the delay
  slot on return.
* Clock skew can be a concern, but it seems there's no generic mechanism
  for clocksource calibration. The x86 code has one supporting PIT/HPET-
  based calibration, but that code never got extracted to common
  framework.
* The VDSO performance seems very bad comparing to x86, even after
  adjusting for the cycle frequency difference. But I haven't thoroughly
  profiled this and perhaps won't have enough spare time for doing so
  (kernel work isn't part of my day job).  So maybe someone could
  provide some hints in this area?

Can only come up with so many points for now; I'll add if more ideas
turn up.

P.S. I have to change to my personal address for outgoing mails; my
work address is hosted on QQ Enterprise Mail, which most certainly is
blocked altogether by linux-mips.org.

Wang Xuerui (2):
  MIPS: Loongson: add extcc clocksource
  MIPS: VDSO: support extcc-based timekeeping

 arch/mips/include/asm/clocksource.h           |  1 +
 arch/mips/include/asm/mach-loongson64/extcc.h | 26 +++++++++
 arch/mips/loongson64/Kconfig                  | 13 +++++
 arch/mips/loongson64/common/Makefile          |  5 ++
 arch/mips/loongson64/common/extcc.c           | 54 +++++++++++++++++++
 arch/mips/loongson64/common/time.c            |  7 +++
 arch/mips/vdso/gettimeofday.c                 |  8 +++
 7 files changed, 114 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-loongson64/extcc.h
 create mode 100644 arch/mips/loongson64/common/extcc.c

-- 
2.20.1

