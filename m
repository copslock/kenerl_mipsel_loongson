Return-Path: <SRS0=mRU9=ZS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8182C432C0
	for <linux-mips@archiver.kernel.org>; Tue, 26 Nov 2019 05:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5FA2071E
	for <linux-mips@archiver.kernel.org>; Tue, 26 Nov 2019 05:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="asIamyGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfKZFed (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:34:33 -0500
Received: from sender4-pp-o97.zoho.com ([136.143.188.97]:25759 "EHLO
        sender4-pp-o97.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKZFec (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 26 Nov 2019 00:34:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574746459; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Hk/o5YBhVkhivrYE6M8Jj8WdI2Ibg1xQm9VeORTlsFbyiShjfeHD/uKj2Sa7B01eWm9+SZaBiscDd0SDPr75ptOhBH8PLPXSDCcNwiX7H9lp9bbkvKPRKbmdmuXDjsvJjwTn3KeXYzscVmklPH6mBCIDBYkjk7bnZ7myFqdbpkE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574746459; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=B3Byg1E6dN5pQwW3/kQ65XwbC3TKftBlzTGMq8uWcxc=; 
        b=HO9BPhP+4pN7wCxSuPS6Nwnux3UIXJ5nvd92sCAJYfEz1FT1vSw1KXlHSUQFPdRECYLOLkjmk7adPJ648RmxbySu79XxXP4r0qsYzZQcuVzXrRHHr+zIpEwqlNCNQcmRYS/Q+SnZEEkOvQHXcNcRJgt6dKoir2wMhkyJO2gM6bk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=QJTcWFa9EPDmbx2p4B+2puOQ1EXhuk+mp0PaeJHJgPIOYq2Txad2q0vTOxVEFr2ixoQ+4WF9keRO
    iqBXZXdebnq5GTes1nn8wnhJxeKJd8X0HRstr7xkNtvVTXdcEzp6  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574746459;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=B3Byg1E6dN5pQwW3/kQ65XwbC3TKftBlzTGMq8uWcxc=;
        b=asIamyGh+k5KSTcm08B985ZMuaUdnaVk4RUQ70mxwqPEmXxxqRPj978a/vrPnF9Z
        V9DFwg3yp27/b3OK5tiZUkq9CKEAHjWyJYoDVWczNZkRjBCqOa3oGV5fzscFmBGVOd4
        gOtMP4dihAU75o3s6XOs7FZpzkyfw7d4zTGWUxcg=
Received: from zhouyanjie-virtual-machine.localdomain (182.148.156.27 [182.148.156.27]) by mx.zohomail.com
        with SMTPS id 157474645824479.72030377729016; Mon, 25 Nov 2019 21:34:18 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, paulburton@kernel.org, paul@crapouillou.net,
        mark.rutland@arm.com, syq@debian.org
Subject: Fix bugs in X1000/X1500 and add X1830 pinctrl driver v6.
Date:   Tue, 26 Nov 2019 13:33:52 +0800
Message-Id: <1574746436-80066-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

v5->v6:
1.Remove duplicates "ssi-ce0-d".
2.Use local variables to streamline code.
3.Rename "GPIO_HIZ" to "GPIO_PULL_DIS", and adjust
  related code.


