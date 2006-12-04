Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2006 09:37:47 +0000 (GMT)
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:38152 "EHLO
	tuxland.pl") by ftp.linux-mips.org with ESMTP id S20038722AbWLDJhn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Dec 2006 09:37:43 +0000
Received: from [192.168.1.3] (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by tuxland.pl (Postfix) with ESMTP id 022B06EF87;
	Mon,  4 Dec 2006 10:37:22 +0100 (CET)
Received: from [192.168.1.3] ([192.168.1.3])
	by tuxland.pl (AISK); Mon, 04 Dec 2006 10:37:22 +0100 (CET)
From:	Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To:	ralf@linux-mips.org
Subject: [2.4 PATCH] mips64 klconfig parenthesis fix
Date:	Mon, 4 Dec 2006 10:37:21 +0100
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org, Willy Tarreau <wtarreau@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612041037.21563.m.kozlowski@tuxland.pl>
Return-Path: <m.kozlowski@tuxland.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.kozlowski@tuxland.pl
Precedence: bulk
X-list: linux-mips

Hello,

        This patch fixes parenthesis stuff in PTR_CH_MALLOC_HDR() macro code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-mips64/sn/klconfig.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/include/asm-mips64/sn/klconfig.h	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.34-pre6-b/include/asm-mips64/sn/klconfig.h	2006-12-01 12:01:25.000000000 +0100
@@ -196,7 +196,7 @@ typedef struct kl_config_hdr {
 			((__psunsigned_t)_k + (_k->ch_malloc_hdr_off)))
 #else
 #define PTR_CH_MALLOC_HDR(_k)   ((klc_malloc_hdr_t *)\
-			(unsigned long)_k + (_k->ch_malloc_hdr_off)))
+			((unsigned long)_k + (_k->ch_malloc_hdr_off)))
 #endif
 
 #define KL_CONFIG_CH_MALLOC_HDR(_n)   PTR_CH_MALLOC_HDR(KL_CONFIG_HDR(_n))


-- 
Regards,

	Mariusz Kozlowski
