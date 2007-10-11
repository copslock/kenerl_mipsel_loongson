Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 10:59:07 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.190]:47125 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021541AbXJKJ66 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 10:58:58 +0100
Received: by fk-out-0910.google.com with SMTP id f40so463275fka
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2007 02:58:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=bXdWnIVSZf5Wr9uM1h5+u09n28FDRK8YJGcNe5IEh9w=;
        b=dMHw1EfVEPHauulzL1caQbndf6UmtZWkSaah4opse7le7F+rcib03Jp4jHnWptv2EjXS7cRq79wGDlGBXwZtXvM/Rkx0iDeuBhqxz9n78uCcJQTBLpRE83NkkaTW2+HDg0XqjqR3CqTLoeaEbXpqFAfhkn8lbjcuHy2BxKJ534w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Lyc06QKAUD4wuF/HijSYUBTUhjnJmcYw/gRK4bav+1olMsgeVNROE+G1o+FMG7pmujyvWnUcxX2XknrMofuh6m8WHgPUblvdVaF9tT5pIQoj73WEy08+Z1wl2qygu1i802V2thTS841RKX80Dvfk1gp83nt+CEF9UyJ51SDmiWg=
Received: by 10.82.182.1 with SMTP id e1mr2733838buf.1192096721015;
        Thu, 11 Oct 2007 02:58:41 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id y6sm4065486mug.2007.10.11.02.58.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Oct 2007 02:58:40 -0700 (PDT)
Message-ID: <470DF3B8.6060804@gmail.com>
Date:	Thu, 11 Oct 2007 11:58:16 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] Add .init.bss section for MIPS
References: <470DF25E.60009@gmail.com>
In-Reply-To: <470DF25E.60009@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/head.S        |    5 +++++
 arch/mips/kernel/vmlinux.lds.S |    7 ++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index e46782b..e8245cd 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -183,6 +183,11 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	LONG_S		zero, (t0)
 	bne		t0, t1, 1b
 
+	PTR_LA		a0, _sinitbss
+	PTR_LA		a1, _einitbss
+	PTR_SUBU	a1, a0
+	jal		__bzero
+
 	LONG_S		a0, fw_arg0		# firmware arguments
 	LONG_S		a1, fw_arg1
 	LONG_S		a2, fw_arg2
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 84f9a4c..30e0d65 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -100,7 +100,7 @@ SECTIONS
 	_edata =  .;			/* End of data section */
 
 	/* will be freed after init */
-	. = ALIGN(_PAGE_SIZE);		/* Init code and data */
+	. = ALIGN(_PAGE_SIZE);		/* Init code, data and bss */
 	__init_begin = .;
 	.init.text : {
 		_sinittext = .;
@@ -110,6 +110,11 @@ SECTIONS
 	.init.data : {
 		*(.init.data)
 	}
+	.init.bss (NOLOAD) : {
+		_sinitbss = .;
+		*(.init.bss)
+		_einitbss = .;
+	}
 	. = ALIGN(16);
 	.init.setup : {
 		__setup_start = .;
-- 
1.5.3.3
