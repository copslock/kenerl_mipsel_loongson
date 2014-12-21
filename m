Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2014 18:14:12 +0100 (CET)
Received: from mail-la0-f43.google.com ([209.85.215.43]:51899 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009433AbaLUROK7hNIe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2014 18:14:10 +0100
Received: by mail-la0-f43.google.com with SMTP id s18so3015690lam.30
        for <linux-mips@linux-mips.org>; Sun, 21 Dec 2014 09:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KDG62rMBmEys41taRujwMfZuH9vLfJBzmN0VoUy+LA4=;
        b=HYxXHI9QmBdb4pW511SW0dImn67p4iwvLUBTYAhNgetTSK7GYTfNzaFuVzXZGyz/01
         FkgzXl2BNwCEXzCBRJszNAuBb7jEUbCXYKzRecOOzdr9xiUPEOjJHZ4flsBB1MBr6Wia
         MkIdGpRVS3pQJ3J9f3+VAzAI3xbk8ZNIuy2GwdlwexOlc/2mTJw6kJAcW1KEgKQ1uejq
         cG3783LWzpvlSWqB/wZXcuVY55/k5qW5UsVr8nr71sK5E4//DUHM6tavG2vwzo6+8AUN
         9e6XgMoGultt/r4WDi70aQIPI9+Z3IKteKbpwIhf1KNkDmGWDxvKkY+diRJjU0Mi8pXb
         29Qw==
X-Gm-Message-State: ALoCoQnzKCpkKNWquSZDxTwEwwSmZS2KLP61HSukSBpnjU/hPgZZDZHqOOk/q9M69wK0urYHiVpw
X-Received: by 10.152.5.226 with SMTP id v2mr18068206lav.34.1419182045567;
        Sun, 21 Dec 2014 09:14:05 -0800 (PST)
Received: from localhost.localdomain (h-246-111.a218.priv.bahnhof.se. [85.24.246.111])
        by mx.google.com with ESMTPSA id vr7sm4398345lbb.21.2014.12.21.09.14.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Dec 2014 09:14:05 -0800 (PST)
From:   Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch: mips: fw: arc: file.c:  Remove some unused functions
Date:   Sun, 21 Dec 2014 18:16:52 +0100
Message-Id: <1419182212-9529-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <rickard_strandqvist@spectrumdigital.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rickard_strandqvist@spectrumdigital.se
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

Removes some functions that are not used anywhere:
ArcSetFileInformation() ArcGetFileInformation() ArcSeek()
ArcGetReadStatus() ArcClose() ArcOpen() ArcGetDirectoryEntry()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/mips/fw/arc/file.c |   43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/arch/mips/fw/arc/file.c b/arch/mips/fw/arc/file.c
index 49fd3ff..ebd69de 100644
--- a/arch/mips/fw/arc/file.c
+++ b/arch/mips/fw/arc/file.c
@@ -13,62 +13,19 @@
 #include <asm/sgialib.h>
 
 LONG
-ArcGetDirectoryEntry(ULONG FileID, struct linux_vdirent *Buffer,
-		     ULONG N, ULONG *Count)
-{
-	return ARC_CALL4(get_vdirent, FileID, Buffer, N, Count);
-}
-
-LONG
-ArcOpen(CHAR *Path, enum linux_omode OpenMode, ULONG *FileID)
-{
-	return ARC_CALL3(open, Path, OpenMode, FileID);
-}
-
-LONG
-ArcClose(ULONG FileID)
-{
-	return ARC_CALL1(close, FileID);
-}
-
-LONG
 ArcRead(ULONG FileID, VOID *Buffer, ULONG N, ULONG *Count)
 {
 	return ARC_CALL4(read, FileID, Buffer, N, Count);
 }
 
 LONG
-ArcGetReadStatus(ULONG FileID)
-{
-	return ARC_CALL1(get_rstatus, FileID);
-}
-
-LONG
 ArcWrite(ULONG FileID, PVOID Buffer, ULONG N, PULONG Count)
 {
 	return ARC_CALL4(write, FileID, Buffer, N, Count);
 }
 
 LONG
-ArcSeek(ULONG FileID, struct linux_bigint *Position, enum linux_seekmode SeekMode)
-{
-	return ARC_CALL3(seek, FileID, Position, SeekMode);
-}
-
-LONG
 ArcMount(char *name, enum linux_mountops op)
 {
 	return ARC_CALL2(mount, name, op);
 }
-
-LONG
-ArcGetFileInformation(ULONG FileID, struct linux_finfo *Information)
-{
-	return ARC_CALL2(get_finfo, FileID, Information);
-}
-
-LONG ArcSetFileInformation(ULONG FileID, ULONG AttributeFlags,
-			   ULONG AttributeMask)
-{
-	return ARC_CALL3(set_finfo, FileID, AttributeFlags, AttributeMask);
-}
-- 
1.7.10.4
