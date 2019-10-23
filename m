Return-Path: <SRS0=5TPM=YQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED18CA9EA0
	for <linux-mips@archiver.kernel.org>; Wed, 23 Oct 2019 03:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F3621848
	for <linux-mips@archiver.kernel.org>; Wed, 23 Oct 2019 03:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="HzWvyEuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbfJWDFi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Oct 2019 23:05:38 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25414 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389529AbfJWDFh (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 22 Oct 2019 23:05:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571799928; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lc2NUnikpohM9t0n5cbPB+GRebr6/zx3XKT4rbDRxVBpo2+cWPcjJgf7pPzrWO00DFR/eBEWMKkI9DA87LTZWCR0sXAqG+yEJkIxD22UdTsWXoksgnLzukh7ZyNNn9xnKcNuVRVctmo9FSHtcytterkkHd/iHNfnsgSGY4W0HAU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571799928; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=2Uge8+ljj0deMQfYUyYNoqG72JVhhEqn9BRyubJpunA=; 
        b=Nn9z6WmLbgjrm4JHvqZ7zQG/APStL+aWm7BkWOX+D+5BR0mc4jHCw8qPlQSYXN4+lb0dPinUAIeOz/gTsGsRi8kk76Ip+jw0fj0PWUvWNeMDU7ZyXXQ6I7UQwao60tuHFij4LWKfSD1u3WugGFK5cwm9EYx4q6n/LKxU0QOB1/c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=Gz57UxplaaMKihRKoF+klm+LbiVEuQaASYP9C3YMZT4DQ7H3k7IFbEii4wgB68eC5nZuFocT+KUM
    gmxFtC5Of/kZisJIrVrjNcd+h8ybYSKAh6DnA3TArPvqloKYnIu3  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571799928;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=138;
        bh=2Uge8+ljj0deMQfYUyYNoqG72JVhhEqn9BRyubJpunA=;
        b=HzWvyEuDWygsE4xWy4QFTzw99wy0jT88unjaldYzpUpl5Fdjnmhst5pSi2/jOW7q
        dwamncQf0dgBfwmD9Px04YzcUXbE33g2YKLENM+tGANo3i4f8YzH0VYtFLjcorCCsVY
        XzCAAwVa/8v20kzDOnVpRBNn/4LoeW9ed0vFMH5U=
Received: from zhouyanjie-virtual-machine.lan (182.148.156.27 [182.148.156.27]) by mx.zohomail.com
        with SMTPS id 1571799925965485.830652634629; Tue, 22 Oct 2019 20:05:25 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, vkoul@kernel.org, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: DMA: JZ4780: Add DMA driver for X1000.
Date:   Wed, 23 Oct 2019 11:05:01 +0800
Message-Id: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

1.Add the DMA bindings for the X1000 SoC from Ingenic.
2.Add support for probing the dma-jz4780 driver on the
  X1000 SoC from Ingenic.


