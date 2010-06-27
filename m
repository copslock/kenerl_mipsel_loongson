Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jun 2010 15:44:18 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55300 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491898Ab0F0NoM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Jun 2010 15:44:12 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E062B08C3;
        Sun, 27 Jun 2010 09:44:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:content-type
        :content-transfer-encoding; s=sasl; bh=3YTkrFCINFccsmzTNRNtfVPYC
        VM=; b=P9+H+g3bDt8uOLiurSqXUAHjt4Mjdbr2D40fLmopr8PItd0jaFpETkDdf
        ByW1UhjmL+ctxPU5ov9wet+Yu0Kg+DihOoO0OGVctR3Ba5Pd2A5sOHne0ywTaJfW
        6J0cRGlMOAARrFH+JLzMCv5wraa0QlTA+h7+A7fFdVEiZhxk/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=DVafIXfwzWYsl0ybzJS
        UBTmW9Rve751hrbCY0LjHmqS+j050Y2B2WA4j32U9MhtZAqJDzvnWQfHs4ryE7Fo
        rYffZtvQz5m/K31VVWsQBsNO84v/jj0UHg9XygMhP5VuEEH9ioq87QjDLZZ2x5Fd
        jdGXum4Y4WYfNDlFiHlYg3zA=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CF85B08C2;
        Sun, 27 Jun 2010 09:44:07 -0400 (EDT)
Received: from [192.168.11.3] (unknown [114.162.174.29]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 903F4B08C0; Sun, 27 Jun
 2010 09:44:05 -0400 (EDT)
Message-ID: <4C2755A3.3080600@pobox.com>
Date:   Sun, 27 Jun 2010 22:44:03 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9)
 Gecko/20100423 Thunderbird/3.0.4
MIME-Version: 1.0
To:     dvomlehn@cisco.com
CC:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: PowerTV: Use fls() carefully where static optimization
 is required
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 0EAFFB8C-81F2-11DF-A6C0-2AC9016DD5F0-47602734!b-pb-sasl-quonix.pobox.com
X-archive-position: 27257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18167

fls()/__fls() defined at <asm/bitops.h>, doesn't use CLZ unless it's
explicitly requested via <cpu-features-overrides.h>.  In other words,
as long as depending on cpu_data[0].isa_level, CLZ is nerver used for
fls()/__fls().

Looking at leftover clz() in asic_int.c, PowerTV used to use Malta's
clz() and irq_ffs() as-is, then for some reason made a decision not to
use clz().

It's MIPS32 machine and luckily clz() is left there, then let's go back
to the original shape.

Signed-off-by: Shinya Kuribayashi <skuribay@pobox.com>
---

 Compile checked, and now CLZ is back.

 arch/mips/powertv/asic/asic_int.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
index 529c44a..e3c08a2 100644
--- a/arch/mips/powertv/asic/asic_int.c
+++ b/arch/mips/powertv/asic/asic_int.c
@@ -86,7 +86,7 @@ static inline int clz(unsigned long x)
  */
 static inline unsigned int irq_ffs(unsigned int pending)
 {
-	return fls(pending) - 1 + CAUSEB_IP;
+	return -clz(pending) + 31 - CAUSEB_IP;
 }
 
 /*
-- 
1.7.1
