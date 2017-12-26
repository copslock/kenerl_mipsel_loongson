Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 11:46:29 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:42405
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990418AbdLZKqVImYQ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 11:46:21 +0100
Received: by mail-wm0-x243.google.com with SMTP id b199so34711774wme.1;
        Tue, 26 Dec 2017 02:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WTV63n6FI7aaFv956CQQdbwiW7uIRQu9xdNpeQgxLg=;
        b=sQylpYqTHb/HSRkrGh8Mtw/UrshBB4I78osXCK/fnUIDpqpn24ocFF9ernoetAXg3x
         VJE8rYVO90HLjJRUh/hwxST1fFHV8IfXl5iWj0CsWeBMC4/DflLflbQEQIaGnD437o7J
         DMtpbIF7dsOPN26rTDQ0TWVQakbFwa7Qavckg7Znll1kQAZT28kmQMWl7916vHT9vyO1
         d1iS3ITxYPhsj470ArMSvklQDbViNdEqEwuGgVSDMMgz5ilM0HKG6GXrdtgPOiBi6baS
         ST8auZ1DD9X1v8bhszkRHzRDWQ53cUln1gHIaoOsvWf/Wdwz4EYrtz5cX5cV1/k4WPT+
         aMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1WTV63n6FI7aaFv956CQQdbwiW7uIRQu9xdNpeQgxLg=;
        b=GDO+CwQ9Wr4BlTUi5vlu2IOeg/teu68LWlD/ElvGZA+M8cbTn5Nsfe6SEVSFN4pQkf
         ZXHAAEn2KC9FKgK+0lOFcZGOsmqcXeQepPjzZ3iRVNa2bDXN25fQw1MdgBDHjCHurgZV
         kTPn1QuLgWvEdFFvGBERHL5LLumUMnAtfiFcYh2SAWCmiqSqZ3QeG6u4bbWDRznQkD5Y
         qXz5MYqZF/KiisYlxdJcBl5gbinKjv+o3GgmY3JzripdnTAkL3vbu0uC54sYviaCM+Rz
         9MfUldUsJ/9hlrfuTxQ7DAs7LwkNjhms2eEHrVwwu53ZOAZU5nbUqKO9v9DD4QXmtGZc
         aZJw==
X-Gm-Message-State: AKGB3mKBqUZIXJTNrPILyTwhVW+nKrgD86WPZLkFByFvZjAHFiVg+M2d
        BaxsNfdrrHFjJp73Be0AC0A=
X-Google-Smtp-Source: ACJfBossKWzQPS/Q0KhdZ2m8B7oiNQSD7mFC7hSG7ezinEoh7dYlYmr8kCfHyCrcy7PnH9Z2NVFq2A==
X-Received: by 10.28.140.206 with SMTP id o197mr18701644wmd.43.1514285175543;
        Tue, 26 Dec 2017 02:46:15 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id y124sm13405323wmb.42.2017.12.26.02.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Dec 2017 02:46:14 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 76D1110C1B2E; Tue, 26 Dec 2017 11:46:13 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Douglas Leung <douglas.leung@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MIPS: math-emu: Do not export function `srl128`
Date:   Tue, 26 Dec 2017 11:45:50 +0100
Message-Id: <20171226104554.19612-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Fix non-fatal warning:

arch/mips/math-emu/dp_maddf.c:19:6: warning: no previous prototype for ‘srl128’ [-Wmissing-prototypes]
 void srl128(u64 *hptr, u64 *lptr, int count)

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/math-emu/dp_maddf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 7ad79ed411f5..0e2278a47f43 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -16,7 +16,7 @@
 
 
 /* 128 bits shift right logical with rounding. */
-void srl128(u64 *hptr, u64 *lptr, int count)
+static void srl128(u64 *hptr, u64 *lptr, int count)
 {
 	u64 low;
 
-- 
2.11.0
