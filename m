Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2006 09:17:11 +0000 (GMT)
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:7182 "EHLO
	tuxland.pl") by ftp.linux-mips.org with ESMTP id S20037612AbWK3JRH
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Nov 2006 09:17:07 +0000
Received: from [192.168.1.3] (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by tuxland.pl (Postfix) with ESMTP id 81CCF6EE9A;
	Thu, 30 Nov 2006 10:16:48 +0100 (CET)
Received: from [192.168.1.3] ([192.168.1.3])
	by tuxland.pl (AISK); Thu, 30 Nov 2006 10:16:47 +0100 (CET)
From:	Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To:	ralf@linux-mips.org
Subject: [PATCH] mips: klconfig add missing bracket
Date:	Thu, 30 Nov 2006 10:16:29 +0100
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301016.29505.m.kozlowski@tuxland.pl>
Return-Path: <m.kozlowski@tuxland.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.kozlowski@tuxland.pl
Precedence: bulk
X-list: linux-mips

Hello,

	This patch adds missing bracket.

 include/asm-mips/sn/klconfig.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/include/asm-mips/sn/klconfig.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/asm-mips/sn/klconfig.h	2006-11-30 00:58:32.000000000 +0100
@@ -176,7 +176,7 @@ typedef struct kl_config_hdr {
 /* --- New Macros for the changed kl_config_hdr_t structure --- */
 
 #define PTR_CH_MALLOC_HDR(_k)   ((klc_malloc_hdr_t *)\
-			(unsigned long)_k + (_k->ch_malloc_hdr_off)))
+			((unsigned long)_k + (_k->ch_malloc_hdr_off)))
 
 #define KL_CONFIG_CH_MALLOC_HDR(_n)   PTR_CH_MALLOC_HDR(KL_CONFIG_HDR(_n))
 


-- 
Regards,

	Mariusz Kozlowski
