Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 10:20:10 +0100 (CET)
Received: from mail-yw0-f182.google.com ([209.85.211.182]:60952 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493173Ab0ADJSB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 10:18:01 +0100
Received: by mail-yw0-f182.google.com with SMTP id 12so15942361ywh.21
        for <multiple recipients>; Mon, 04 Jan 2010 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=GRqDoCpDCwH69EypbL8KasyZtuCMTiOexd+BSc5DuhQ=;
        b=i3lBkamVCDR4vopuVtXXEEON8Ws9b5PLCAhA/xitlAjsTyUFdYGGSTLoVWUF0b9j+h
         JZ2F+zH1g8nY2HyH3PAfo+ldExDFVPi+UYCQ529GBPkXejFZDEcTShcP8Q3sDqYxaZcu
         VqmXeF0+z5GJfqj15EZB4b0KB/CGTG4RWzlWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uAuOoYHaAKrBTghtu4ttlqXAy/6Gt+Lk1VzDXLqt+/bs3yPwZdaSzWErvfvHzCc3RZ
         HR3H5JgYCX8VRt6qBpWVNB6eUtIZHZ75usaSoAAyLO+INIO8+fqx1OE8sgG7hqRpWZkV
         IFSr/x/iaxp0em7n0/9DY+gI66bMie6I5w3Qs=
Received: by 10.151.89.37 with SMTP id r37mr8097801ybl.329.1262596680646;
        Mon, 04 Jan 2010 01:18:00 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm6122077ywh.16.2010.01.04.01.17.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 01:17:57 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 07/10] Loongson: arch/mips/Makefile: add missing whitespace
Date:   Mon,  4 Jan 2010 17:16:49 +0800
Message-Id: <0340ef8c9de1f84261bac07c74f435f719eaa65d.1262596493.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
In-Reply-To: <b36e03d26901b981248854fcaa645d8c8a0f23a8.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262586650.git.wuzhangjin@gmail.com>
 <f4aeb125cb030f10d34966febfe9715874d52ab2.1262596493.git.wuzhangjin@gmail.com>
 <669ff2f39fd2aa3849e472438d3d9d499c8f0e3a.1262596493.git.wuzhangjin@gmail.com>
 <9bcc0f00c46fdf5c832ce3bdd0df8d7f08b7a1be.1262596493.git.wuzhangjin@gmail.com>
 <dc64ae336edaf61405e56534e33fe40c49694378.1262596493.git.wuzhangjin@gmail.com>
 <a5bac10a774e405cffcf79edc430b31d6becb0d0.1262596493.git.wuzhangjin@gmail.com>
 <b36e03d26901b981248854fcaa645d8c8a0f23a8.1262596493.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262596493.git.wuzhangjin@gmail.com>
X-archive-position: 25505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2267

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch add missing whitespace after every "+=" in the loongson
related part of arch/mips/Makefile.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1893efd..51d344c 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -332,11 +332,11 @@ load-$(CONFIG_WR_PPMC)		+= 0xffffffff80100000
 #
 # Loongson family
 #
-core-$(CONFIG_MACH_LOONGSON) +=arch/mips/loongson/
+core-$(CONFIG_MACH_LOONGSON) += arch/mips/loongson/
 cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson \
                     -mno-branch-likely
-load-$(CONFIG_LEMOTE_FULOONG2E) +=0xffffffff80100000
-load-$(CONFIG_LEMOTE_MACH2F) +=0xffffffff80200000
+load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
+load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
 
 #
 # MIPS Malta board
-- 
1.6.5.6
