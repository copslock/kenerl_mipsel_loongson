Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 20:52:46 +0100 (BST)
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:62127 "EHLO
	outbound1-kan-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S8133768AbWGNTwe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Jul 2006 20:52:34 +0100
Received: from outbound1-kan.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-kan-R.bigfish.com (Postfix) with ESMTP id 75BD08057CE;
	Fri, 14 Jul 2006 19:52:27 +0000 (UTC)
Received: from mail55-kan-R.bigfish.com (unknown [172.18.7.1])
	by outbound1-kan.bigfish.com (Postfix) with ESMTP id 6E864804B9F;
	Fri, 14 Jul 2006 19:52:27 +0000 (UTC)
Received: from mail55-kan.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail55-kan-R.bigfish.com (Postfix) with ESMTP id 640EC25E40F;
	Fri, 14 Jul 2006 19:52:27 +0000 (UTC)
X-BigFish: V
Received: by mail55-kan (MessageSwitch) id 1152906747361017_5997; Fri, 14 Jul 2006 19:52:27 +0000 (UCT)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail55-kan.bigfish.com (Postfix) with ESMTP id 42A3625E0F2;
	Fri, 14 Jul 2006 19:52:27 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com [43.130.1.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k6EJqQu7014258;
	Fri, 14 Jul 2006 19:52:26 GMT
Received: from USSDIXIM01.am.sony.com (ussdixim01.am.sony.com [43.130.140.33])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k6EJqPTQ021046;
	Fri, 14 Jul 2006 19:52:25 GMT
Received: from ussdixms03.am.sony.com ([43.130.140.23]) by USSDIXIM01.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 14 Jul 2006 12:52:25 -0700
Received: from [192.168.1.10] ([43.134.85.105]) by ussdixms03.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 14 Jul 2006 12:52:19 -0700
Message-ID: <44B7F5F3.9090104@am.sony.com>
Date:	Fri, 14 Jul 2006 12:52:19 -0700
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: [PATCH 1/2] mips: fix arch help
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jul 2006 19:52:19.0581 (UTC) FILETIME=[03F682D0:01C6A77F]
Return-Path: <Geoffrey.Levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

Fixes the arch specific help for mips.  This moves the help
def's to arch/mips/Makefile, where they will be found by
'make help'.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

--

Fixes this warning:

Architecture specific targets (mips):
  No architecture specific help defined for mips


Index: 2.6.16/arch/mips/Makefile
===================================================================
--- 2.6.16.orig/arch/mips/Makefile	2006-07-14 11:30:10.000000000 -0700
+++ 2.6.16/arch/mips/Makefile	2006-07-14 11:37:33.000000000 -0700
@@ -845,6 +845,11 @@
 	       vmlinux.rm200.tmp \
 	       vmlinux.rm200

+define archhelp
+	@echo '* vmlinux.ecoff            - ECOFF boot image'
+	@echo '* vmlinux.srec             - SREC boot image'
+endef
+
 archclean:
 	@$(MAKE) $(clean)=arch/mips/boot
 	@$(MAKE) $(clean)=arch/mips/lasat
Index: 2.6.16/arch/mips/boot/Makefile
===================================================================
--- 2.6.16.orig/arch/mips/boot/Makefile	2006-07-14 11:30:10.000000000 -0700
+++ 2.6.16/arch/mips/boot/Makefile	2006-07-14 11:37:33.000000000 -0700
@@ -42,10 +42,6 @@
 $(obj)/addinitrd: $(obj)/addinitrd.c
 	$(HOSTCC) -o $@ $^

-archhelp:
-	@echo	'* vmlinux.ecoff	- ECOFF boot image'
-	@echo	'* vmlinux.srec		- SREC boot image'
-
 clean-files += addinitrd \
 	       elf2ecoff \
 	       vmlinux.bin \
