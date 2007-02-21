Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 00:35:40 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:54023 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20039019AbXBUAff convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2007 00:35:35 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.0)); Tue, 20 Feb 2007 16:34:58 -0800
X-Server-Uuid: 9206F490-5C8F-4575-BE70-2AAA8A3D4853
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 744CE2AF; Tue, 20 Feb 2007 16:34:58 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 61B442AE for
 <linux-mips@linux-mips.org>; Tue, 20 Feb 2007 16:34:58 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EYN96768; Tue, 20 Feb 2007 16:34:58 -0800 (PST)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
 [10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 EC87420501 for <linux-mips@linux-mips.org>; Tue, 20 Feb 2007 16:34:57
 -0800 (PST)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0751.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 20 Feb 2007 16:34:57 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: [PATCH] minor fix in sb1250_duart.c
Date:	Tue, 20 Feb 2007 16:34:56 -0800
Message-ID: <710F16C36810444CA2F5821E5EAB7F231C84EB@NT-SJCA-0752.brcm.ad.broadcom.com>
Thread-Topic: [PATCH] minor fix in sb1250_duart.c
Thread-Index: AcdVUBwYEKYbAIIaTJCPFN8oX0l5fg==
From:	"Manoj Ekbote" <manoj.ekbote@broadcom.com>
To:	linux-mips@linux-mips.org
X-OriginalArrivalTime: 21 Feb 2007 00:34:57.0877 (UTC)
 FILETIME=[1D2FE050:01C75550]
X-WSS-ID: 69C54C383Y825748611-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoj.ekbote@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoj.ekbote@broadcom.com
Precedence: bulk
X-list: linux-mips

Patch to remove the first "default" label in switch and case.

Signed-off-by: Manoj Ekbote <manoje@broadcom.com>

diff --git a/drivers/char/sb1250_duart.c b/drivers/char/sb1250_duart.c
index 9cbd92e..a311fdb 100644
--- a/drivers/char/sb1250_duart.c
+++ b/drivers/char/sb1250_duart.c
@@ -469,7 +469,6 @@ static inline void duart_set_cflag(unsig
 	case B1800:	clk_divisor = 2776;		break;
 	case B2400:	clk_divisor = 2082;		break;
 	case B4800:	clk_divisor = 1040;		break;
-	default:
 	case B9600:	clk_divisor = 519;		break;
 	case B19200:	clk_divisor = 259;		break;
 	case B38400:	clk_divisor = 129;		break;
