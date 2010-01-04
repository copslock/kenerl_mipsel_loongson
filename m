Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 10:18:10 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:36824 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493169Ab0ADJRd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 10:17:33 +0100
Received: by mail-yx0-f204.google.com with SMTP id 42so15199460yxe.22
        for <multiple recipients>; Mon, 04 Jan 2010 01:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=u8DlvqMJjU+JKh+Ex4AONWqflTUHx6HLLvmRo8A3NEs=;
        b=YOeniC9UuBzfhFiLfdkfGYQiXTSLU8F5s+m/oAoANG4hwHOgi814uxcL9l3Lt6l5Uj
         bXI4AuSbgJV9fFH02nfMTlnpVg+1kjozZC5FS47x/ByDOizQyruFRFaTVaqY5osAsuns
         wR0Vczmfbz0z8AUz4tx79rTeoXR+xQ2m/s4Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kzr2Ocm/XJH1Gak9DyBtXiZVdlhhl5FCp+GFxBreX4xLO4oC+3bo4P4xmr2xDXCFSD
         /T84O7p+4xA7jS8vs6Ag7AzblgfiVYEpwdgVYGU0GM5hTut9OtYZSBcM6kTo3cbV+TSv
         CLYuy4mRb8Y7a3/w/pODJgygOUW9etG8HQ/Tg=
Received: by 10.101.4.9 with SMTP id g9mr17112714ani.61.1262596650539;
        Mon, 04 Jan 2010 01:17:30 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm6122077ywh.16.2010.01.04.01.17.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 01:17:29 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 02/10] Loongson: Lemote-2F: USB: Not Emulate Non-Posted Writes
Date:   Mon,  4 Jan 2010 17:16:44 +0800
Message-Id: <669ff2f39fd2aa3849e472438d3d9d499c8f0e3a.1262596493.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
In-Reply-To: <f4aeb125cb030f10d34966febfe9715874d52ab2.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262586650.git.wuzhangjin@gmail.com>
 <f4aeb125cb030f10d34966febfe9715874d52ab2.1262596493.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262596493.git.wuzhangjin@gmail.com>
X-archive-position: 25500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2261

From: Wu Zhangjin <wuzhangjin@gmail.com>

Without this patch, when copying large amounts of data between the USB
storage devices and the hard disk, the USB device will disconnect
regularly.

Signed-off-by: Hu Hongbing <huhb@lemote.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/pci/fixup-lemote2f.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
index caf2ede..4b9768d 100644
--- a/arch/mips/pci/fixup-lemote2f.c
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -131,7 +131,7 @@ static void __init loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
 
 	/* Serial short detect enable */
 	_rdmsr(USB_MSR_REG(USB_CONFIG), &hi, &lo);
-	_wrmsr(USB_MSR_REG(USB_CONFIG), (1 << 1) | (1 << 2) | (1 << 3), lo);
+	_wrmsr(USB_MSR_REG(USB_CONFIG), (1 << 1) | (1 << 3), lo);
 
 	/* setting the USB2.0 micro frame length */
 	pci_write_config_dword(pdev, PCI_EHCI_FLADJ_REG, 0x2000);
-- 
1.6.5.6
