Return-Path: <SRS0=bwn4=QC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B59C282C7
	for <linux-mips@archiver.kernel.org>; Sat, 26 Jan 2019 15:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CF021903
	for <linux-mips@archiver.kernel.org>; Sat, 26 Jan 2019 15:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="IosUSp6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfAZPkg (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:40:36 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25401 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfAZPkg (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 26 Jan 2019 10:40:36 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548517214; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=jPgnNg7xCnKVtitR1impGWyebVJ9repyHSfl7jZUmZqAqBJjIJJKNLJozbZMbJMpu7U5To/4pQUWLyng3DRsLE8VYNXYjAMX8cQKdddYknxWhfmxEgXQokIMv2B4KK/xYLkHrds/WoPlsxgmJwWNfsZuw7obRgc7uF7dwrj8UDs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548517214; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=aLl9LOC5/y5bzeBnYnp9/0ADs68L6KAELWCzFdYLlbM=; 
        b=Fwjoni2nY8uSU9F5FlLsRSG8L81WCrVNHAJuO15pRHg4dcLnwzH8m+RgPImDjqPmCNMhuB9ajEnfIfHRqyajIhhCVjWs2vSStjrWfOniia2aSJThJjhzILpSGT4nfAVhKNBziK5sf8lviLDWH84G9P6B8W/m2f7+TWE3KEl0rGU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=oH+iWBLXw1GGL5WFJyMIfezqKlRiFnWHZcnF+/qciuEomb0vDceipeYI2LqqCPecTz3TJWcC9t7T
    FIbEicZtyADzvUW58xqa+ZMKLE/5NJx//2Z0rKWoKOqp7Lx6cdIP  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548517214;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=36;
        bh=aLl9LOC5/y5bzeBnYnp9/0ADs68L6KAELWCzFdYLlbM=;
        b=IosUSp6EN+MKQ7MA4mPAUMDgbJLGu8s1ZRsX23HDC8ZfZK7Qv6ocX0TOdopAHUS+
        OCWX+l9AvRtmzfYfVKBKNnZaNfFsA7aDo62yEvXJ74VXKpR40hnx938knSLcAlWvIua
        t4Eg0KIk7S/g9t0b27rlOX3PDCqWHJ91tnZmi82Y=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548517212809199.82158132937707; Sat, 26 Jan 2019 07:40:12 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: Add Ingenic X1000 irqchip support.
Date:   Sat, 26 Jan 2019 23:38:39 +0800
Message-Id: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add Ingenic X1000 irqchip support.


