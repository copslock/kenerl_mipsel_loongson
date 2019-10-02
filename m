Return-Path: <SRS0=RYQo=X3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9BAC352AA
	for <linux-mips@archiver.kernel.org>; Wed,  2 Oct 2019 11:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE77B206BB
	for <linux-mips@archiver.kernel.org>; Wed,  2 Oct 2019 11:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="ZfgcpRGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfJBL0M (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:26:12 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25590 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJBL0M (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 2 Oct 2019 07:26:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570015542; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=oPRUFqcMfcxs2ZQBxlSRx9sHr8DETI7ghePJ0+G/CqPM3OvV0tIvJRfzQvFX23RkXymPYJ1DcEKhf+EZV5XWcm6cnNg/nx9VjyLRTg0DGe56ls2nD7Ny9Np3cu3VXhK+6M2Clll/whHAWG31BEu5pVJ18vGn3URQLpEicw6ePg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1570015542; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=MOCAF5cNP+Lh10vJimxqFDAc7SBWUfa3+Eqjyz8nj/s=; 
        b=ZWvDNZcDl19C1866vnjpMwn/txFeIjuIZjdloGt1Wkunvb3vW2QvpzZ7IsDrrDgoheR5qVmbB5lce6QIB9vuJM2VMh6Ee+AItLyNz9I86CbUQeeB6q5TWAdevtQTp+cEdFP3Fr2gnMDhTXMKAEYYsKPbinCPf9FbLz0eFMwAEzo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=wFovTQZGGwh+4L21q9mwcAD/bL+4FIZU0SVJi153EKUfo5FKIdQvlXJT60fNIHyqybYPKPrnjT45
    d/TyZhefjWjE3fHgnKqrX89imAPTmh1BDc3AGwkNCd+bX0oGUPTi  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570015542;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=96;
        bh=MOCAF5cNP+Lh10vJimxqFDAc7SBWUfa3+Eqjyz8nj/s=;
        b=ZfgcpRGGwUndw+K9/YCLwlPWYKm3lwlkPI7CmETiF6RY7ssHh0Tte5+bho6uVXrS
        56OMBzehebM/Hv1hptsTJGBKiclBo0o6kakp9qnn7jfnuyxcqahDayeerdVCUs9y4Ep
        QhBWYmLPLMRz9vFdOAU2dQbHMDf9ZP1Lq5B82Mwo=
Received: from zhouyanjie-virtual-machine.localdomain (171.221.113.164 [171.221.113.164]) by mx.zohomail.com
        with SMTPS id 1570015540821583.7400534227955; Wed, 2 Oct 2019 04:25:40 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        paul.burton@mips.com, gregkh@linuxfoundation.org,
        jason@lakedaemon.net, syq@debian.org, marc.zyngier@arm.com,
        rfontana@redhat.com, armijn@tjaldur.nl, allison@lohutok.net,
        paul@crapouillou.net
Subject: Add process for more than one irq at the same time v5
Date:   Wed,  2 Oct 2019 19:25:20 +0800
Message-Id: <1570015525-27018-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Rebase on top of Paul Cercueil's patches and drop unneeded changes as
Paul Cercueil's advice.


