Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6FMNqRw014851
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 15:23:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6FMNqsZ014850
	for linux-mips-outgoing; Mon, 15 Jul 2002 15:23:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6FMNlRw014840
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 15:23:47 -0700
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA26471
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 15:28:35 -0700
Subject: PATCH
From: Pete Popov <ppopov@mvista.com>
To: linux-mips <linux-mips@oss.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 15 Jul 2002 15:29:10 -0700
Message-Id: <1026772150.15665.145.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=-2.5 required=5.0 tests=TO_LOCALPART_EQ_REAL,UNIFIED_PATCH,SUBJ_ALL_CAPS version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,

__pte is broken when pte_t is a 64bit type.  I did this to fix the 36
bit IO support for the Alchemy boards, but it also affects the 64 bit
mips port.  Apparently it fixed a Xfree problem someone was having.

Pete

--- include/asm-mips/pgtable.h.old	Fri Jul 12 17:25:19 2002
+++ include/asm-mips/pgtable.h	Fri Jul 12 17:25:36 2002
@@ -332,7 +332,9 @@
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	return __pte(((pte).pte_low & _PAGE_CHG_MASK) | pgprot_val(newprot));
+	pte.pte_low &= _PAGE_CHG_MASK;
+	pte.pte_low |= pgprot_val(newprot);
+	return pte;
 }
 
 /*
