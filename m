Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Dec 2004 08:51:50 +0000 (GMT)
Received: from s306.secure.ne.jp ([IPv6:::ffff:211.9.215.133]:47628 "HELO
	s306.secure.ne.jp") by linux-mips.org with SMTP id <S8225208AbULNIvo>;
	Tue, 14 Dec 2004 08:51:44 +0000
Received: (qmail 69443 invoked from network); 14 Dec 2004 17:51:22 +0900
Received: from unknown (HELO koseki) (163.139.182.183)
  by 0 with SMTP; 14 Dec 2004 17:51:22 +0900
Message-ID: <009001c4e1ba$54a431f0$2100a8c0@koseki>
From: "Tatsuya Koseki" <koseki@shimafuji.co.jp>
To: "Linux MIPS mailing list" <linux-mips@linux-mips.org>
Subject: kernel 2.6.9 patch
Date: Tue, 14 Dec 2004 17:53:02 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <koseki@shimafuji.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: koseki@shimafuji.co.jp
Precedence: bulk
X-list: linux-mips

Please review 


--- linux/include/asm/stackframe.h.old Tue Dec 14 17:49:38 2004
+++ linux/include/asm/stackframe.h Tue Dec 14 17:50:35 2004
@@ -244,6 +244,10 @@
   nor v1, $0, v1
   and v0, v1
   or v0, a0
+
+  li v1,2
+  or v0,v1
+
   mtc0 v0, CP0_STATUS
   LONG_L v1, PT_EPC(sp)
   MTC0 v1, CP0_EPC
