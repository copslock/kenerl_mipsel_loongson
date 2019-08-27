Return-Path: <SRS0=TBB5=WX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A96C3A5A3
	for <linux-mips@archiver.kernel.org>; Tue, 27 Aug 2019 08:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4713D206BA
	for <linux-mips@archiver.kernel.org>; Tue, 27 Aug 2019 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893854;
	bh=hSXiHTaIGZAtakKjmWxzWPqo1JJ9IeJSuT3tMk0Qho4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+YoiDh1e40sShC4BlCI28dIYaZEiEqew881OW+a0cwHw/J35mLdkxt10lv7lYRxm
	 OwISuIzkgNe89ZrKEr+Ta+HiYsiK+CakxExmlenouN5xfTto0/QzwwIMRcY3MwNltw
	 LIMSZbaWs0SFdhL+ay9q4Mpgq1lRitEzKsjtuZwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfH0Hvs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfH0Hvr (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 27 Aug 2019 03:51:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B9BE206BA;
        Tue, 27 Aug 2019 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892306;
        bh=hSXiHTaIGZAtakKjmWxzWPqo1JJ9IeJSuT3tMk0Qho4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxfpouoWoSZRO/jubkxsAhh5qskITiBfn7uZC3WFAKnNm4nhaiCiODspLlmRWn/D0
         h6Ld9inoesBFuWEN4aZ6m6X4UMy06b1yxGyRjptcYFhhD/qwmOcXzocLlrIW0TyQPv
         w2VoMQzKGeJVIJIyaAfdjygQoqiGS/6D67WhxAoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 03/62] mips: fix cacheinfo
Date:   Tue, 27 Aug 2019 09:50:08 +0200
Message-Id: <20190827072700.223038050@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

[ Upstream commit b8bea8a5e5d942e62203416ab41edecaed4fda02 ]

Because CONFIG_OF defined for MIPS, cacheinfo attempts to fill information
from DT, ignoring data filled by architecture routine. This leads to error
reported

 cacheinfo: Unable to detect cache hierarchy for CPU 0

Way to fix this provided in
commit fac51482577d ("drivers: base: cacheinfo: fix x86 with
 CONFIG_OF enabled")

Utilize same mechanism to report that cacheinfo set by architecture
specific function

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/cacheinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
index 97d5239ca47ba..428ef21892039 100644
--- a/arch/mips/kernel/cacheinfo.c
+++ b/arch/mips/kernel/cacheinfo.c
@@ -80,6 +80,8 @@ static int __populate_cache_leaves(unsigned int cpu)
 	if (c->tcache.waysize)
 		populate_cache(tcache, this_leaf, 3, CACHE_TYPE_UNIFIED);
 
+	this_cpu_ci->cpu_map_populated = true;
+
 	return 0;
 }
 
-- 
2.20.1



