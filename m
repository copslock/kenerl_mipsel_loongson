Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 15:04:42 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:10251 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8225207AbTDXOEj>; Thu, 24 Apr 2003 15:04:39 +0100
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA479
          for <linux-mips@linux-mips.org>; Thu, 24 Apr 2003 07:04:32 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@linux-mips.org>
Subject: [patch] wait instruction on vr4181
Date: Thu, 24 Apr 2003 07:10:28 -0700
Message-ID: <076701c30a6b$429b0560$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0768_01C30A30.963C2D60"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030424141217.A23893@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Return-Path: <sseeger@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sseeger@stellartec.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0768_01C30A30.963C2D60
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

The VR4181 does work with the wait instruction. This is a patch for that.
(arch/mips/cpu-probe.c)

Steve


------=_NextPart_000_0768_01C30A30.963C2D60
Content-Type: application/octet-stream;
	name="patch-cpu-probe.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-cpu-probe.c"

--- linux-2.4.21.orig/arch/mips/kernel/cpu-probe.c	2003-04-24 =
05:32:21.000000000 -0700
+++ linux-2.4.21/arch/mips/kernel/cpu-probe.c	2003-04-24 =
05:26:42.000000000 -0700
@@ -69,6 +69,7 @@
 	case CPU_NEVADA:
 	case CPU_RM7000:
 	case CPU_TX49XX:
+	case CPU_VR4181:
 	case CPU_4KC:
 	case CPU_4KEC:
 	case CPU_4KSC:

------=_NextPart_000_0768_01C30A30.963C2D60--
