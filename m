Return-Path: <SRS0=t3K6=UI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8289DC2BCA1
	for <linux-mips@archiver.kernel.org>; Sun,  9 Jun 2019 16:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F75206C3
	for <linux-mips@archiver.kernel.org>; Sun,  9 Jun 2019 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098918;
	bh=RraCkwXdzglEq/7vdS33A/72ye87OZQO/agCNTF+Lok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jw6Ev0AFJj3AyhBVWQJlQH9qSCK5s7dXavnIIu2HxaqP/bfAGpjKOSadfY7OOSuuh
	 zOaHTIuaTMhghBFsimD2c6gBVyHN7PqddgKWuKl/dmKCfN4lImDO33WO0p/EJ/XqK0
	 pvanGOYGe9J39Dg0s56ac5IZ0T4Vb/35cH+sv9YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfFIQsh (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731232AbfFIQsf (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 9 Jun 2019 12:48:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28246205ED;
        Sun,  9 Jun 2019 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098914;
        bh=RraCkwXdzglEq/7vdS33A/72ye87OZQO/agCNTF+Lok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ccsxcei6/nm0gUVfv/9l3kkUGB9aZwrhP7XKlFfm8XgYrCkziI0I7wGPV2/h5eeV4
         7NyZVox0MW0h/Qz5gsTxHcuNIs22MAGZMZpFytd4keIRDqMx4AYUf5SF/xw697Wv/z
         uVM9L3l55QWhfKWeS51FryLywk6V6ypXS1oKNASo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.19 33/51] MIPS: pistachio: Build uImage.gz by default
Date:   Sun,  9 Jun 2019 18:42:14 +0200
Message-Id: <20190609164129.245033949@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

commit e4f2d1af7163becb181419af9dece9206001e0a6 upstream.

The pistachio platform uses the U-Boot bootloader & generally boots a
kernel in the uImage format. As such it's useful to build one when
building the kernel, but to do so currently requires the user to
manually specify a uImage target on the make command line.

Make uImage.gz the pistachio platform's default build target, so that
the default is to build a kernel image that we can actually boot on a
board such as the MIPS Creator Ci40.

Marked for stable backport as far as v4.1 where pistachio support was
introduced. This is primarily useful for CI systems such as kernelci.org
which will benefit from us building a suitable image which can then be
booted as part of automated testing, extending our test coverage to the
affected stable branches.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
URL: https://groups.io/g/kernelci/message/388
Cc: stable@vger.kernel.org # v4.1+
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/pistachio/Platform |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/pistachio/Platform
+++ b/arch/mips/pistachio/Platform
@@ -6,3 +6,4 @@ cflags-$(CONFIG_MACH_PISTACHIO)		+=				\
 		-I$(srctree)/arch/mips/include/asm/mach-pistachio
 load-$(CONFIG_MACH_PISTACHIO)		+= 0xffffffff80400000
 zload-$(CONFIG_MACH_PISTACHIO)		+= 0xffffffff81000000
+all-$(CONFIG_MACH_PISTACHIO)		:= uImage.gz


