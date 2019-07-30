Return-Path: <SRS0=ZHUC=V3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B63C433FF
	for <linux-mips@archiver.kernel.org>; Tue, 30 Jul 2019 11:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46DD205C9
	for <linux-mips@archiver.kernel.org>; Tue, 30 Jul 2019 11:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="aec8Tnjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfG3Lb1 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:31:27 -0400
Received: from sender-pp-o92.zoho.com ([135.84.80.237]:25419 "EHLO
        sender-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfG3Lb1 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 30 Jul 2019 07:31:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564486255; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=UXTFKv7gVDhrNdY67mJtbrMMkEhYjxYh61cPUe5L98eVx82cFDkMmQ7ZWkQG2IWVcitwRCIawLITEvBvXK/gFoaf4ylUFpwYLLC6ngFrrTpjGTRASfEsy3TUDXogbBKPW7I6wTrMAG39buq0uoaSIurF/oinWo1+0LC5ywHHkIs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1564486255; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=WBUlw9utVZTw5p7WLkBvmTODJB01FKCSNEFTLWHE3XA=; 
        b=OqlPhgBrKNlb0IPkis/wdQgbBnAQ8qacvov3nnzUEY28FfDg/Iy+YAcJd0W2ltBzdfPVPUwS8lDl9vupIzQWx0cpLhw1oj98XP4WRnFK8Rr/da7pKkjPUAigorvdOwWWUkYuDiJbbem8xIEsmOXOzEyrrBva3MvsyEXrq7Q8GGs=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=FxnLbGs98Tq7O/iVNcxOziWe7JS1AejpMjYToYj7h9UDl1S1CrsnoRFUPrJBIRj2S4Gg98kNgoA3
    1xvF4VDAe7XR7BpDEAY1JQfd+EA62nPCYh14VKSa7TgrXqRrIgj9  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1564486255;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=64;
        bh=WBUlw9utVZTw5p7WLkBvmTODJB01FKCSNEFTLWHE3XA=;
        b=aec8TnjwV2nL3MMIFaU3YbtJQABi/qCk7nFX9y/kOCRn/7M8ytbqX4SrRW21V4e3
        7WCJA09frtsXkelfe3+YGOc15SrQNDBaXyfItIDQXagQPes84POhgfegiPJg6mP8uZC
        Fj8MKUsgFjxJbPl8AHnzlF1VV/RKcqPghaXI0hME=
Received: from localhost.localdomain (171.221.113.137 [171.221.113.137]) by mx.zohomail.com
        with SMTPS id 1564486252526388.69305994190245; Tue, 30 Jul 2019 04:30:52 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        paul@crapouillou.net, paul.burton@mips.com, jhogan@kernel.org,
        fancer.lancer@gmail.com, chenhc@lemote.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, armijn@tjaldur.nl, syq@debian.org,
        jiaxun.yang@flygoat.com
Subject: Add Ingenic X1000 system type.
Date:   Tue, 30 Jul 2019 19:30:10 +0800
Message-Id: <1564486211-2699-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add X1000 system type for cat /proc/cpuinfo to give out X1000.


