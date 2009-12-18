Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2009 13:21:54 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:41823 "EHLO
        mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492907AbZLRMVu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2009 13:21:50 +0100
Received: by gxk2 with SMTP id 2so2717102gxk.4
        for <multiple recipients>; Fri, 18 Dec 2009 04:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=OrtyKM0D6uCVQhPG1QmowIaJ1s73wvcLIIOPYEQVWi4=;
        b=rotDEX8vfqVmU57W7qkAiNe7HsxNzYKGSZGIiwPUP/xLZ07gmrZrliQnjTJciXpnkh
         KW7MLkQDhI6klXuxhFh4wrD7VrZXUhTFYZkGwZoclQr0Rid6ISxmuhr/4l82krBqzq/u
         mTIfwa3v4oZtPOwr0niV9u6j7spgCnoDYYVn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=nsF7noyZ9yxHnodD/cn5EYR9m72ZFLiWLBMw2k87Yuq/hQ/o6M/gcO/D3ovNoKqYOo
         UNVbHwX9Y3guR0ii9sCpqzQomD47uTCFmhb/ZQsWxQXuaLDDJmBQN9n0rdn16/JCskYc
         g0yH0dZxn/ohsKCAW79tXidiHSSGdBiCuM92I=
Received: by 10.101.130.8 with SMTP id h8mr5906197ann.168.1261138566889;
        Fri, 18 Dec 2009 04:16:06 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm955187gxk.8.2009.12.18.04.16.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 04:16:06 -0800 (PST)
Date:   Fri, 18 Dec 2009 21:14:19 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] Add vmlinux.* to arch/mips/boot/.gitignore
Message-Id: <20091218211419.b50a64e3.yuasa@linux-mips.org>
In-Reply-To: <20091218211317.45e5da2e.yuasa@linux-mips.org>
References: <20091218211317.45e5da2e.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/boot/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
index ba63401..4667a5f 100644
--- a/arch/mips/boot/.gitignore
+++ b/arch/mips/boot/.gitignore
@@ -1,4 +1,5 @@
 mkboot
 elf2ecoff
+vmlinux.*
 zImage
 zImage.tmp
-- 
1.6.5.7
