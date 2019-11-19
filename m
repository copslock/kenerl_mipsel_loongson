Return-Path: <SRS0=PhWg=ZL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D14C432C0
	for <linux-mips@archiver.kernel.org>; Tue, 19 Nov 2019 06:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB12E21852
	for <linux-mips@archiver.kernel.org>; Tue, 19 Nov 2019 06:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143924;
	bh=P3UvzSRpRnTNM+a2JJrkuszswtOIZUdDobM0GCA6KYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kJPYcWn164vp7u6dlckZFC7IOvJ51ovL8YlpfP7V27Sk/DqihG0MhaQjV18LkseDO
	 jtmOYZVceaPGNz/NNaHF1giqQLUdc2qdDfZ612bDUcKNRRJHk6BmkyEYqvqISXMR6Z
	 TMr/zhH8mUinCqusdmOFUKF7sqsLnEoYxqzWwLNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKSFXT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfKSFXT (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 19 Nov 2019 00:23:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECAF21939;
        Tue, 19 Nov 2019 05:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574140998;
        bh=P3UvzSRpRnTNM+a2JJrkuszswtOIZUdDobM0GCA6KYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTyQbh26klS1D9D1yyOuHwAmGQf2bnKSWTOHR0h0afd4o1ab6sWvydo5sSgNRLk1+
         +bTwG2yL2R2IToDBbeLR/qsCz4E5iCb3pVty7Pu1PHLTVYd1ugv5D2eufGpw8d27mF
         DMtnpm7CAhiC9/njY5muGBM9EPwKJH7J5M2IcNGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.19 002/422] MIPS: BCM63XX: fix switch core reset on BCM6368
Date:   Tue, 19 Nov 2019 06:13:19 +0100
Message-Id: <20191119051400.401770057@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Jonas Gorski <jonas.gorski@gmail.com>

commit 8a38dacf87180738d42b058334c951eba15d2d47 upstream.

The Ethernet Switch core mask was set to 0, causing the switch core to
be not reset on BCM6368 on boot. Provide the proper mask so the switch
core gets reset to a known good state.

Fixes: 799faa626c71 ("MIPS: BCM63XX: add core reset helper")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/bcm63xx/reset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/bcm63xx/reset.c
+++ b/arch/mips/bcm63xx/reset.c
@@ -120,7 +120,7 @@
 #define BCM6368_RESET_DSL	0
 #define BCM6368_RESET_SAR	SOFTRESET_6368_SAR_MASK
 #define BCM6368_RESET_EPHY	SOFTRESET_6368_EPHY_MASK
-#define BCM6368_RESET_ENETSW	0
+#define BCM6368_RESET_ENETSW	SOFTRESET_6368_ENETSW_MASK
 #define BCM6368_RESET_PCM	SOFTRESET_6368_PCM_MASK
 #define BCM6368_RESET_MPI	SOFTRESET_6368_MPI_MASK
 #define BCM6368_RESET_PCIE	0


