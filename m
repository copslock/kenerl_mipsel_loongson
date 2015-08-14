Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 19:53:30 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56875 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011077AbbHNRxSy2mz1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 19:53:18 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0AF198D9;
        Fri, 14 Aug 2015 17:53:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: [PATCH 3.14 02/44] MIPS: Malta: Dont reinitialise RTC
Date:   Fri, 14 Aug 2015 10:44:39 -0700
Message-Id: <20150814174401.706169515@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150814174401.628233291@linuxfoundation.org>
References: <20150814174401.628233291@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 106eccb4d20f35ebc58ff2286c170d9e79c5ff68 upstream.

On Malta, since commit a87ea88d8f6c ("MIPS: Malta: initialise the RTC at
boot"), the RTC is reinitialised and forced into binary coded decimal
(BCD) mode during init, even if the bootloader has already initialised
it, and may even have already put it into binary mode (as YAMON does).
This corrupts the current time, can result in the RTC seconds being an
invalid BCD (e.g. 0x1a..0x1f) for up to 6 seconds, as well as confusing
YAMON for a while after reset, enough for it to report timeouts when
attempting to load from TFTP (it actually uses the RTC in that code).

Therefore only initialise the RTC to the extent that is necessary so
that Linux avoids interfering with the bootloader setup, while also
allowing it to estimate the CPU frequency without hanging, without a
bootloader necessarily having done anything with the RTC (for example
when the kernel is loaded via EJTAG).

The divider control is configured for a 32KHZ reference clock if
necessary, and the SET bit of the RTC_CONTROL register is cleared if
necessary without changing any other bits (this bit will be set when
coming out of reset if the battery has been disconnected).

Fixes: a87ea88d8f6c ("MIPS: Malta: initialise the RTC at boot")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10739/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mti-malta/malta-time.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -168,14 +168,17 @@ unsigned int get_c0_compare_int(void)
 
 static void __init init_rtc(void)
 {
-	/* stop the clock whilst setting it up */
-	CMOS_WRITE(RTC_SET | RTC_24H, RTC_CONTROL);
+	unsigned char freq, ctrl;
 
-	/* 32KHz time base */
-	CMOS_WRITE(RTC_REF_CLCK_32KHZ, RTC_FREQ_SELECT);
+	/* Set 32KHz time base if not already set */
+	freq = CMOS_READ(RTC_FREQ_SELECT);
+	if ((freq & RTC_DIV_CTL) != RTC_REF_CLCK_32KHZ)
+		CMOS_WRITE(RTC_REF_CLCK_32KHZ, RTC_FREQ_SELECT);
 
-	/* start the clock */
-	CMOS_WRITE(RTC_24H, RTC_CONTROL);
+	/* Ensure SET bit is clear so RTC can run */
+	ctrl = CMOS_READ(RTC_CONTROL);
+	if (ctrl & RTC_SET)
+		CMOS_WRITE(ctrl & ~RTC_SET, RTC_CONTROL);
 }
 
 void __init plat_time_init(void)
