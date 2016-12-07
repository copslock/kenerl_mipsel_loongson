Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 23:44:08 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51752 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993419AbcLGWoAvASXa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2016 23:44:00 +0100
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E151787822
        for <linux-mips@linux-mips.org>; Thu,  8 Dec 2016 11:43:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1481150636;
        bh=jZIwfoOJOAV6UPC+bSEgWmKUybRM9qxT0HpJX1gqrjE=;
        h=From:To:Cc:Subject:Date;
        b=cdrb1ym194pxo4ytKVG8rzU/eyt+eQz7CGFWGKAoT42JMkHsiNrleYjRL8gixZbsK
         emIXEglpenl9c0I3Xsyonvd7cmpEDxH0QrSH4t0Gg+CkAZXvUwQLGu2Ox04CSXpasI
         Z7073tf4HLUpJdEw78CLDJe+TEW4WjI/aa9wUtXY=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,6,8438)
        id <B584890aa0000>; Thu, 08 Dec 2016 11:43:54 +1300
Received: from luukp-dl.ws.atlnz.lc (luukp-dl.ws.atlnz.lc [10.33.11.25])
        by smtp (Postfix) with ESMTP id 4001513ED20;
        Thu,  8 Dec 2016 11:43:55 +1300 (NZDT)
Received: by luukp-dl.ws.atlnz.lc (Postfix, from userid 1137)
        id 43DDE4409FF; Thu,  8 Dec 2016 11:43:56 +1300 (NZDT)
From:   Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
To:     linux-mips@linux-mips.org
Cc:     Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
Subject: [PATCH] mips: Return -ENODEV from weak implementation of rtc_mips_set_time
Date:   Thu,  8 Dec 2016 11:43:34 +1300
Message-Id: <20161207224334.22303-1-luuk.paulussen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.10.2
Return-Path: <luukp@alliedtelesis.co.nz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luuk.paulussen@alliedtelesis.co.nz
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

The sync_cmos_clock function in kernel/time/ntp.c first tries to update
the internal clock of the cpu by calling the "update_persistent_clock64"
architecture specific function.  If this returns -ENODEV, it then tries
to update an external RTC using "rtc_set_ntp_time".

On the mips architecture, the weak implementation of the underlying
function would return 0 if it wasn't overridden.  This meant that the
sync_cmos_clock function would never try to update an external RTC
(if both CONFIG_GENERIC_CMOS_UPDATE and CONFIG_RTC_SYSTOHC are
configured)

Returning -ENODEV instead, means that an external RTC will be tried.

Reviewed-by: Richard Laing <richard.laing@alliedtelesis.co.nz>
Reviewed-by: Scott Parlane <scott.parlane@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
---
 arch/mips/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 8d01709..a7f8126 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL(rtc_lock);
 
 int __weak rtc_mips_set_time(unsigned long sec)
 {
-	return 0;
+	return -ENODEV;
 }
 
 int __weak rtc_mips_set_mmss(unsigned long nowtime)
-- 
2.10.2
