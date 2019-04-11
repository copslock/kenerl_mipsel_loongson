Return-Path: <SRS0=fNfu=SN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6A0C10F13
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE48D2083E
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="H5VycW7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfDKMTc (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:19:32 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:43949 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfDKMTc (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Thu, 11 Apr 2019 08:19:32 -0400
Received: from mxback17g.mail.yandex.net (mxback17g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:317])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id E90221C804E6;
        Thu, 11 Apr 2019 15:19:28 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback17g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id gntORT2Cqn-JSDaFQnc;
        Thu, 11 Apr 2019 15:19:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1554985168;
        bh=ft9OmVT6aCUsQ5Kk29vVt3utzLICJCugYHV2VR51/Bs=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=H5VycW7p8yQPU56uy1Q5Am8dn7oBOCFNp9MKd9SDUVgCLJMF42ROnsHGMegLSs6DA
         djCIXiDqoyiakqZjI6FDqjXpvpHdctv8524E5wmAtNozU/QNriVSc+Dcx9Uyh+OBFe
         xNJ4XJnqTz/gPVNMEhxfDiH3GFitPKWBHUL/A280=
Authentication-Results: mxback17g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QbB7ClwXzg-JMCmhaRo;
        Thu, 11 Apr 2019 15:19:26 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     devicetree@vger.kernel.org, paul.burton@mips.com,
        robh+dt@kernel.org
Subject: [PATCH v2 0/6] MIPS: Loongson32: Initial devicetree support
Date:   Thu, 11 Apr 2019 20:19:09 +0800
Message-Id: <20190411121915.8040-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312091520.8863-2-jiaxun.yang@flygoat.com>
References: <20190312091520.8863-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

v1->v2: Fix dts and add documents


