Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 22:23:02 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:2821 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8225208AbTDXVW5>; Thu, 24 Apr 2003 22:22:57 +0100
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA469;
          Thu, 24 Apr 2003 14:22:48 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: "'Jun Sun'" <jsun@mvista.com>,
	"'Steven Seeger'" <sseeger@stellartec.com>
Cc: <linux-mips@linux-mips.org>
Subject: [patch] new wait instruction for vr4181
Date: Thu, 24 Apr 2003 14:28:47 -0700
Message-ID: <079701c30aa8$7de13300$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0798_01C30A6D.D1825B00"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030424112711.E28275@mvista.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Return-Path: <sseeger@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sseeger@stellartec.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0798_01C30A6D.D1825B00
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

I think I figured this out. Could someone look at this and tell me if I did
it right?

Thanks.

-Steve


------=_NextPart_000_0798_01C30A6D.D1825B00
Content-Type: application/octet-stream;
	name="cpu-probe.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cpu-probe.c.diff"

--- /root/vr/new/linux-2.4.21.orig/arch/mips/kernel/cpu-probe.c	=
2003-04-24 05:32:21.000000000 -0700
+++ ./cpu-probe.c	2003-04-24 14:16:35.000000000 -0700
@@ -34,6 +34,16 @@
 		".set\tmips0");
 }
=20
+#ifdef CONFIG_VR4181
+static void vr4181_wait(void)
+{
+   __asm__(".set\tnoreorder\n"
+	   ".int 0x42000021\n"
+	   ".set\treorder\n");
+  =20
+}
+#endif
+ =20
 void au1k_wait(void)
 {
 #ifdef CONFIG_PM
@@ -83,6 +93,12 @@
 		cpu_wait =3D au1k_wait;
 		printk(" available.\n");
 		break;
+#ifdef CONFIG_VR4181
+	 case CPU_VR4181:
+	   cpu_wait =3D vr4181_wait;
+	   printk(" available\n");
+	   break;
+#endif	  =20
 	default:
 		printk(" unavailable.\n");
 		break;

------=_NextPart_000_0798_01C30A6D.D1825B00--
