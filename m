Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jan 2006 16:52:19 +0000 (GMT)
Received: from arrakis.dune.hu ([195.56.146.235]:36237 "EHLO arrakis.dune.hu")
	by ftp.linux-mips.org with ESMTP id S8133541AbWA1QwB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Jan 2006 16:52:01 +0000
Received: from localhost (localhost [127.0.0.1])
	by arrakis.dune.hu (Postfix) with ESMTP id 155BD7840C0
	for <linux-mips@linux-mips.org>; Sat, 28 Jan 2006 17:57:19 +0100 (CET)
Received: from arrakis.dune.hu ([127.0.0.1])
	by localhost (arrakis [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12851-05 for <linux-mips@linux-mips.org>;
	Sat, 28 Jan 2006 17:57:19 +0100 (CET)
Received: from richese (catv-5063294a.catv.broadband.hu [80.99.41.74])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by arrakis.dune.hu (Postfix) with ESMTP id DA1F2784085
	for <linux-mips@linux-mips.org>; Sat, 28 Jan 2006 17:57:18 +0100 (CET)
Date:	Sat, 29 Jan 2005 17:54:44 +0100
To:	linux-mips@linux-mips.org
Subject: [PATCH] use __always_inline for __xchg
From:	"Imre Kaloz" <kaloz@openwrt.org>
Content-Type: multipart/mixed; boundary=----------oJykAMPxGs5MptUDiVRgEo
MIME-Version: 1.0
Message-ID: <op.sldiliqr2s3iss@richese>
X-Virus-Scanned: by amawis at dune.hu
Return-Path: <kaloz@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaloz@openwrt.org
Precedence: bulk
X-list: linux-mips

------------oJykAMPxGs5MptUDiVRgEo
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


The following patch changes inline for __xchg to __always_inline in  
include/asm-mips/system.h, following the changes in git. Without this  
change linking the kernel fails.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
------------oJykAMPxGs5MptUDiVRgEo
Content-Disposition: attachment; filename=use-__always_inline-for-__xchg.patch
Content-Type: application/octet-stream; name=use-__always_inline-for-__xchg.patch
Content-Transfer-Encoding: Base64

LS0tIGxpbnV4LTIuNi4xNS4xLm9sZC9pbmNsdWRlL2FzbS1taXBzL3N5c3RlbS5o
CTIwMDYtMDEtMjggMTU6MDI6NTQuNDgxMDMyMjgwICswMTAwCisrKyBsaW51eC0y
LjYuMTUuMS5kZXYvaW5jbHVkZS9hc20tbWlwcy9zeXN0ZW0uaAkyMDA2LTAxLTI4
IDE0OjQ3OjUxLjYzNDI4NTg0OCArMDEwMApAQCAtMjczLDcgKzI3Myw3IEBACiAg
ICBpZiBzb21ldGhpbmcgdHJpZXMgdG8gZG8gYW4gaW52YWxpZCB4Y2hnKCkuICAq
LwogZXh0ZXJuIHZvaWQgX194Y2hnX2NhbGxlZF93aXRoX2JhZF9wb2ludGVyKHZv
aWQpOwogCi1zdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgX194Y2hnKHVuc2ln
bmVkIGxvbmcgeCwgdm9sYXRpbGUgdm9pZCAqIHB0ciwgaW50IHNpemUpCitzdGF0
aWMgX19hbHdheXNfaW5saW5lIHVuc2lnbmVkIGxvbmcgX194Y2hnKHVuc2lnbmVk
IGxvbmcgeCwgdm9sYXRpbGUgdm9pZCAqIHB0ciwgaW50IHNpemUpCiB7CiAJc3dp
dGNoIChzaXplKSB7CiAJCWNhc2UgNDoK
------------oJykAMPxGs5MptUDiVRgEo--
