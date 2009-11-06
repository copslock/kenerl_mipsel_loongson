Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 17:13:51 +0100 (CET)
Received: from mba.ocn.ne.jp ([122.28.14.163]:55080 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492939AbZKFQNp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Nov 2009 17:13:45 +0100
Received: from localhost (p7248-ipad211funabasi.chiba.ocn.ne.jp [58.91.163.248])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 48E2F6ED6
	for <linux-mips@linux-mips.org>; Sat,  7 Nov 2009 01:13:39 +0900 (JST)
Date:	Sat, 07 Nov 2009 01:08:39 +0900 (JST)
Message-Id: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Recently COMMAND_LINE_SIZE (CL_SIZE) was extended to 4096 from 512.
(commit 22242681 "MIPS: Extend COMMAND_LINE_SIZE")

This cause warning if something like buf[CL_SIZE] was declared as a
local variable, for example in prom_init_cmdline() on some platforms.

And since many Makefiles in arch/mips enables -Werror, this cause
build failure.

How can we avoid this error?

- do not use local array? (but dynamic allocation cannot be used in
  such an early stage.  static array?)
- are there any way to disable -Wframe-larger-than for the file or function?
- make COMMAND_LINE_SIZE customizable?
- use non default CONFIG_FRAME_WARN?

Any comments or suggestions?
---
Atsushi Nemoto
