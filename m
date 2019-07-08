Return-Path: <SRS0=SDB9=VF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49541C606C1
	for <linux-mips@archiver.kernel.org>; Mon,  8 Jul 2019 15:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186D621537
	for <linux-mips@archiver.kernel.org>; Mon,  8 Jul 2019 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600296;
	bh=F0MLiEif0xXSL6E1WHyu/bkxCafh91cFapRm0n3w3PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1q7A5J0bFlIlqz8POuE2bqdjruEZoUITAwcOF/Fqg668ZeLlU5vILc6QjU/VhKuS
	 MJP4gjb7p0c+LEnSlLwnNNMamuOnGMzueWUsgVCMCnElb/OzR4MsWetEyCQgR91RVn
	 MIQqDFvzqETtRNYppTuYQ1kRjGMTn9mk2fFdmbXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389732AbfGHPaj (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389720AbfGHPag (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 8 Jul 2019 11:30:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 651D320665;
        Mon,  8 Jul 2019 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599835;
        bh=F0MLiEif0xXSL6E1WHyu/bkxCafh91cFapRm0n3w3PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zqDn2s5Ph79ZC4ScrilMWRz1+7Zrg/UF51dP0anvaNiOHQM4tDkaNl9X0V5AdqUiF
         ugx7EymBd/xZZ+jz0gNzgpz/k1E4cbC223lgTRTSOy8EyJTB1paKw74hmbKvSXo4d3
         l+xbSUIOVwEq6u1Ybizo+Me6HoDkceNQ4bmKkRSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.19 88/90] MIPS: have "plain" make calls build dtbs for selected platforms
Date:   Mon,  8 Jul 2019 17:13:55 +0200
Message-Id: <20190708150526.970098760@linuxfoundation.org>
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

From: Cedric Hombourger <Cedric_Hombourger@mentor.com>

commit 637dfa0fad6d91a9a709dc70549a6d20fa77f615 upstream.

scripts/package/builddeb calls "make dtbs_install" after executing
a plain make (i.e. no build targets specified). It will fail if dtbs
were not built beforehand. Match the arm64 architecture where DTBs get
built by the "all" target.

Signed-off-by: Cedric Hombourger <Cedric_Hombourger@mentor.com>
[paul.burton@mips.com: s/builddep/builddeb]
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org # v4.1+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -16,6 +16,7 @@ archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/mips/boot/tools relocs
 
 KBUILD_DEFCONFIG := 32r2el_defconfig
+KBUILD_DTBS      := dtbs
 
 #
 # Select the object file format to substitute into the linker script.
@@ -385,7 +386,7 @@ quiet_cmd_64 = OBJCOPY $@
 vmlinux.64: vmlinux
 	$(call cmd,64)
 
-all:	$(all-y)
+all:	$(all-y) $(KBUILD_DTBS)
 
 # boot
 $(boot-y): $(vmlinux-32) FORCE


