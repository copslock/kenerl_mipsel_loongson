Return-Path: <SRS0=Z+4i=YP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48C2CA9EA0
	for <linux-mips@archiver.kernel.org>; Tue, 22 Oct 2019 16:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3C52084B
	for <linux-mips@archiver.kernel.org>; Tue, 22 Oct 2019 16:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="JFID7DAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbfJVQ5T (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:57:19 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25475 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732163AbfJVQ5S (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 22 Oct 2019 12:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571763428; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=AnGQBBDj9gdcQBs5B6+gqXfvUpk2XtfJhcIT2Y1ofM13kxXg6IB2w+yRQfX40u3m+6TquOvx71meGpJnK4Y/yi1QE7vc+ljJLma5SzaarFVRqDUuP6TPIvccUl8XXcVDyHZaVsw7qeKsTE5D76noQItacWuQP+c8W1WasAoUJ9g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571763428; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=WoO9opLwGLvO34UBH8Z3GqzsC7d/WfsWFU9zGxpzK1c=; 
        b=Dwf8RmVvYC+nOZZTBWAPt2QHT+ZRoU+Mw7TS/Q4riEot1uFkMDfhKTFdTWcxHfAfYK/dsFXzAdKDXLDgy/LxEY9GxT+9Q6R5YSl9ciQhKU9KPuuzk5xT9GocZ7aNdz510kbxAnR6qMDlmD3hMRhk5BXr8qrS7hCKXfgvkenv5is=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=WdVnvx/XofvgipZWW4wx+IhBsnUMnhZ7EN+D1g/ZEa9VXL9OZ0g26ofjn0Z5tqg5aXR8uG+dEmGs
    F8lynGAJQf9Yb+tTLStNg8L5fretYM9xqepvQcfjKFnfvCnbxATt  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571763428;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=155;
        bh=WoO9opLwGLvO34UBH8Z3GqzsC7d/WfsWFU9zGxpzK1c=;
        b=JFID7DAmru8jMM2KssJdH7gG/O1nG5bsNASlwG+kNyz4n55F4YaF/Esto6W1c/PM
        UtxQHzmXJQs+fB0GubDQ1ceZMHJaZhResFDvCNU5dOSWmSmfFpE+glDmoKTTuNV/KcH
        81ZFdP1ng1UmJQfpVARVY9fFoaPaL83r4I8H1uWg=
Received: from localhost.localdomain (171.221.113.199 [171.221.113.199]) by mx.zohomail.com
        with SMTPS id 1571763428292197.9872646436479; Tue, 22 Oct 2019 09:57:08 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, mturquette@baylibre.com, sboyd@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net
Subject: clk: X1000: Add support for the X1000 v2.
Date:   Wed, 23 Oct 2019 00:56:27 +0800
Message-Id: <1571763389-43443-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571421006-12771-1-git-send-email-zhouyanjie@zoho.com>
References: <1571421006-12771-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

v1->v2:use BIT() macro instead left shift, add a call of
"ingenic_cgu_register_syscore_ops()", replace "CLK_OF_DECLARE"
with a "CLK_OF_DECLARE_DRIVER".


