Return-Path: <SRS0=99me=YR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641CDCA9EAF
	for <linux-mips@archiver.kernel.org>; Thu, 24 Oct 2019 17:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37072205F4
	for <linux-mips@archiver.kernel.org>; Thu, 24 Oct 2019 17:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="fJQtnkGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503564AbfJXRW1 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:22:27 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25428 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503500AbfJXRW0 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 24 Oct 2019 13:22:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571937737; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=A4RD+rwTmvJv9EkI+nlGgzoBhBgv/HGOA7Zi+hyda5AK/E/L6o6HVfIvoz9OcTsNlvoiYk0WT4ZOlsLGEiKzNAHKQ4dNENWri1gZq6OcIPjrFFCgVN+keV4/RNlm6LfjDyVhau13LwQjXEPMad8iPRfpdzIFmCGdqUAhZ/+W5YM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571937737; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=nW4r9hfSpDvbnYrfHmG0XhOTR4iUAineFE87Et7nkUU=; 
        b=hKCl+U4uD65rNluZtmmDeeHHT/mo/WurL7Gi637SNNMCuaFagJDch3z6L/c0VdHxosAAlVHS+VlaLdW9uAEjDC3kXwnB9eb6Xqh1fgcQwoYVzsSO0ItwJ8QFifE/i0ZLxbrI3OXRWjgreegqXwfFTYxz6ki+YleaR7ul1YfBYE8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=ZqdzBT53l2Q1Sz9Te84EB01AGYpv45B2/YU82QrpWE6H++Fu9NDkVWRCEo/6FN/7l/BIOUniiV43
    ZFYTH3ZUka+frqLnoCDwricKTQEvk1hNVtqYN07Ju/4HJmXundUK  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571937737;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=49;
        bh=nW4r9hfSpDvbnYrfHmG0XhOTR4iUAineFE87Et7nkUU=;
        b=fJQtnkGvKFYula426xlDTpzgX7gLj3E9F32LR1sfVpKfHoqU4BNQTYs/AHGaqx9S
        jU1/plQfKqCzlh6U40hzfKrNnOaghzKRfJ+WtA0/u6Xp0ab78Hf96fXm9UGeCrwBlDy
        8BSdmsfqH+nPn6Vub/bsXxCZuHuqa+uomQuc3R0Q=
Received: from zhouyanjie-virtual-machine.localdomain (171.221.113.49 [171.221.113.49]) by mx.zohomail.com
        with SMTPS id 1571937736333206.6263410656744; Thu, 24 Oct 2019 10:22:16 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, vkoul@kernel.org, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: dmaengine: JZ4780: Add support for the X1000 v2
Date:   Fri, 25 Oct 2019 01:21:08 +0800
Message-Id: <1571937670-30828-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

v1->v2:remove flag JZ_SOC_DATA_ALLOW_LEGACY_DT.


