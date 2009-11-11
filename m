Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 07:00:42 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:47570 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492198AbZKKGAL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 07:00:11 +0100
Received: by ywh3 with SMTP id 3so1265682ywh.22
        for <multiple recipients>; Tue, 10 Nov 2009 22:00:04 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yPYAMyBzAV2S7YS3lA794kacTTW9HpPdnkkL2ni8La8=;
        b=xMv1AxdNtiTeuBaecLzllw+IZ5VfywY/wCCFXwLRHvyIwYd3v7I40Bf/sx2GvUjd+c
         lWZmkW/LP/rQtSRcUiEDOdC3yfd3cY8EAW6f6uEGtuvk/SSO2USeaX+m2AIy/stUJZ5o
         VzyYG7YA7ERrFhZ2OShGBR/aThgS8alZNJ8ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=X90b3DzTkDfzo98baIH/G4EFWj20eBSDnxYgzdJvAs08Kls04qrhbdgPe79IUbsYz8
         8i6zJL1UiS9aRH94uk6h1DzxZ5EUHPiOaQ4t3b9ROcr9MsuOTIBmj0Ud1dGCdwYmz1RG
         Jp2KmOHeIsmCzQ9Pg8tLNXy1ypzeZMVh8B4rI=
Received: by 10.90.121.17 with SMTP id t17mr1703396agc.57.1257919174561;
        Tue, 10 Nov 2009 21:59:34 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 34sm703043yxf.11.2009.11.10.21.59.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 21:59:33 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 0/2] loongson2f: add video acceleration support
Date:	Wed, 11 Nov 2009 13:59:22 +0800
Message-Id: <cover.1257918796.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patchset add video acceleration support for loongson2f family machines via
uncached accelerated TLB mapping.

We add a new option CPU_SUPPORT_VIDEO_ACC for loongson2f and it's successors,
so all of them can share this souce code via selecting this option.

Thanks!
	Wu Zhangjin

Wu Zhangjin (2):
  [loongson] 2f: Add CPU_SUPPORT_VIDEO_ACC
  [loongson] 2f: Improve video performance via uncached accelerated TLB
    map

 arch/mips/Kconfig               |    4 +++
 arch/mips/include/asm/pgtable.h |   13 +++++++++
 arch/mips/loongson/common/mem.c |   58 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 0 deletions(-)
