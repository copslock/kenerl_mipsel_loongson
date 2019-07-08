Return-Path: <SRS0=SDB9=VF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20CEC606C2
	for <linux-mips@archiver.kernel.org>; Mon,  8 Jul 2019 15:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915D2204EC
	for <linux-mips@archiver.kernel.org>; Mon,  8 Jul 2019 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600110;
	bh=z/ooAq1ICsAXqKXJ0w7Avw/GipHY/HsT8UzX+CHjg6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HlW+R6+n8H4gavAKLyWOkkA1pIIZrWEowUKG6lTDeKfXg+GXyT70P/2y/ycYAjP21
	 hFmQCSADesTIqYtlMjat7nyrYEbEpRJLkJFvBYZ6FAz9XaD2OpZUunVUfsHli6UtuO
	 TWoy/H2AcnpiWduI2fgwmdTiqtVWN0Q6U3/YNWMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390729AbfGHPfJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390892AbfGHPfI (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 8 Jul 2019 11:35:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429AC20651;
        Mon,  8 Jul 2019 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562600107;
        bh=z/ooAq1ICsAXqKXJ0w7Avw/GipHY/HsT8UzX+CHjg6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJeJmyDbVhaYTFKvup8TFoJ9pZPPe4krMsNPB0XJui2DLob+ULB66Y7K3GX35NqaS
         v/h7GpI0Qb1PMNCiGuV2fKuu3gs1UDgHj114QM+wYxOT5NYMnMS7exZ8Tz2I3xnsWO
         aRAiQyyptr8+th6cTCuCPoUz/spXZWq8Vhm4v9FI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 5.1 91/96] MIPS: have "plain" make calls build dtbs for selected platforms
Date:   Mon,  8 Jul 2019 17:14:03 +0200
Message-Id: <20190708150531.357282183@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
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
@@ -17,6 +17,7 @@ archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/mips/boot/tools relocs
 
 KBUILD_DEFCONFIG := 32r2el_defconfig
+KBUILD_DTBS      := dtbs
 
 #
 # Select the object file format to substitute into the linker script.
@@ -384,7 +385,7 @@ quiet_cmd_64 = OBJCOPY $@
 vmlinux.64: vmlinux
 	$(call cmd,64)
 
-all:	$(all-y)
+all:	$(all-y) $(KBUILD_DTBS)
 
 # boot
 $(boot-y): $(vmlinux-32) FORCE


