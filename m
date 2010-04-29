Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 11:57:24 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:41331 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492393Ab0D2J4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 11:56:53 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id E55B527401A; Thu, 29 Apr 2010 11:56:52 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id 07E6A274012
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 11:56:52 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id 3B95B84250
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 12:14:33 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id 716E3FF855
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 11:58:46 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] arch/mips/loongson/common/machtype.c: Fix typo
Organization: Mandriva
Date:   Thu, 29 Apr 2010 11:58:46 +0200
Message-ID: <m3y6g6wpex.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

--=-=-=


The gdium name string contains an obvious typo. It's not "gidum" but
"gdium".

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=gdium_fix_name.patch

Index: linux-2.6/arch/mips/loongson/common/machtype.c
===================================================================
--- linux-2.6.orig/arch/mips/loongson/common/machtype.c
+++ linux-2.6/arch/mips/loongson/common/machtype.c
@@ -24,7 +24,7 @@ static const char *system_types[] = {
 	[MACH_LEMOTE_FL2F]              "lemote-fuloong-2f-box",
 	[MACH_LEMOTE_ML2F7]             "lemote-mengloong-2f-7inches",
 	[MACH_LEMOTE_YL2F89]            "lemote-yeeloong-2f-8.9inches",
-	[MACH_DEXXON_GDIUM2F10]         "dexxon-gidum-2f-10inches",
+	[MACH_DEXXON_GDIUM2F10]         "dexxon-gdium-2f",
 	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
 	[MACH_LEMOTE_LL2F]              "lemote-lynloong-2f",
 	[MACH_LOONGSON_END]             NULL,

--=-=-=--
