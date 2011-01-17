Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 09:20:01 +0100 (CET)
Received: from mail.servus.at ([193.170.194.20]:53333 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493329Ab1AQIT4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 09:19:56 +0100
Received: from localhost (mail.servus.at [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id 69C182156AC;
        Mon, 17 Jan 2011 09:19:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M9uKT9O57LC8; Mon, 17 Jan 2011 09:19:56 +0100 (CET)
Received: from stefan-l.obssys.loc (85-127-133-21.dynamic.xdsl-line.inode.at [85.127.133.21])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: oh_stefan)
        by mail.servus.at (Postfix) with ESMTP id 8664D2156A7;
        Mon, 17 Jan 2011 09:19:55 +0100 (CET)
Message-ID: <4D33FBA9.9080503@obssys.com>
Date:   Mon, 17 Jan 2011 09:19:53 +0100
From:   Stefan Oberhumer <stefan@obssys.com>
Organization: obssys.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: MIPS: Clear the correct flag in sysmips(MIPS_FIXADE, ...).
Content-Type: multipart/mixed;
 boundary="------------090304010704090001000407"
Return-Path: <stefan@obssys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan@obssys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090304010704090001000407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


The sysmips(MIPS_FIXADE, ...) case contains an obvious copy-and-paste
error in the handling of the TIF_LOGADE flag. Fix that
---
 arch/mips/kernel/syscall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)



--------------090304010704090001000407
Content-Type: text/x-patch;
 name="0001-MIPS-Clear-the-correct-flag-in-sysmips-MIPS_FIXADE.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-MIPS-Clear-the-correct-flag-in-sysmips-MIPS_FIXADE.patc";
 filename*1="h"

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 1dc6edf..cde2a32 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -405,7 +405,7 @@ _sys_sysmips(nabi_no_regargs struct pt_regs regs)
 		if (arg1 & 2)
 			set_thread_flag(TIF_LOGADE);
 		else
-			clear_thread_flag(TIF_FIXADE);
+			clear_thread_flag(TIF_LOGADE);
 
 		return 0;
 


--------------090304010704090001000407--
