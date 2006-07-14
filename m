Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 20:53:39 +0100 (BST)
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:2768 "EHLO
	outbound2-kan-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S8133776AbWGNTwe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Jul 2006 20:52:34 +0100
Received: from outbound2-kan.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-kan-R.bigfish.com (Postfix) with ESMTP id 9FF4D7AF850;
	Fri, 14 Jul 2006 19:52:27 +0000 (UTC)
Received: from mail56-kan-R.bigfish.com (unknown [172.18.7.1])
	by outbound2-kan.bigfish.com (Postfix) with ESMTP id 973367AF83B;
	Fri, 14 Jul 2006 19:52:27 +0000 (UTC)
Received: from mail56-kan.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail56-kan-R.bigfish.com (Postfix) with ESMTP id 8C71D1A1C59;
	Fri, 14 Jul 2006 19:52:27 +0000 (UTC)
X-BigFish: V
Received: by mail56-kan (MessageSwitch) id 1152906747534868_15490; Fri, 14 Jul 2006 19:52:27 +0000 (UCT)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail56-kan.bigfish.com (Postfix) with ESMTP id 6D5271A1A29;
	Fri, 14 Jul 2006 19:52:27 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com [43.130.1.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k6EJqQek014259;
	Fri, 14 Jul 2006 19:52:26 GMT
Received: from USSDIXIM01.am.sony.com (ussdixim01.am.sony.com [43.130.140.33])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k6EJqQCj021049;
	Fri, 14 Jul 2006 19:52:26 GMT
Received: from ussdixms03.am.sony.com ([43.130.140.23]) by USSDIXIM01.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 14 Jul 2006 12:52:25 -0700
Received: from [192.168.1.10] ([43.134.85.105]) by ussdixms03.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 14 Jul 2006 12:52:24 -0700
Message-ID: <44B7F5F8.4050703@am.sony.com>
Date:	Fri, 14 Jul 2006 12:52:24 -0700
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: [PATCH 2/2] mips: add new target vmlinux.strip
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jul 2006 19:52:24.0253 (UTC) FILETIME=[06BF66D0:01C6A77F]
Return-Path: <Geoffrey.Levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

Adds a new make target 'vmlinux.strip', a stripped elf boot
image.  This target reduces image load time with bootloaders
that load elf images.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Index: 2.6.16/arch/mips/Makefile
===================================================================
--- 2.6.16.orig/arch/mips/Makefile	2006-07-14 11:37:33.000000000 -0700
+++ 2.6.16/arch/mips/Makefile	2006-07-14 11:39:25.000000000 -0700
@@ -834,6 +834,9 @@
 vmlinux.bin: $(vmlinux-32)
 	+@$(call makeboot,$@)

+vmlinux.strip: $(vmlinux-32)
+	+@$(call makeboot,$@)
+
 vmlinux.ecoff vmlinux.rm200: $(vmlinux-32)
 	+@$(call makeboot,$@)

@@ -846,6 +849,7 @@
 	       vmlinux.rm200

 define archhelp
+	@echo '* vmlinux.strip            - stripped elf boot image'
 	@echo '* vmlinux.ecoff            - ECOFF boot image'
 	@echo '* vmlinux.srec             - SREC boot image'
 endef
Index: 2.6.16/arch/mips/boot/Makefile
===================================================================
--- 2.6.16.orig/arch/mips/boot/Makefile	2006-07-14 11:37:33.000000000 -0700
+++ 2.6.16/arch/mips/boot/Makefile	2006-07-14 11:37:55.000000000 -0700
@@ -23,6 +23,9 @@
 drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
 strip-flags	= $(addprefix --remove-section=,$(drop-sections))

+quiet_cmd_stripvm = STRIP   $@
+      cmd_stripvm = $(STRIP) -s -R .comment $< -o $@
+
 VMLINUX = vmlinux

 all: vmlinux.ecoff vmlinux.srec addinitrd
@@ -36,6 +39,9 @@
 vmlinux.bin: $(VMLINUX)
 	$(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $(obj)/vmlinux.bin

+vmlinux.strip: $(VMLINUX)
+	$(call if_changed,stripvm)
+
 vmlinux.srec: $(VMLINUX)
 	$(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $(obj)/vmlinux.srec
