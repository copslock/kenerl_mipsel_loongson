Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2006 05:26:52 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:44385 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133529AbWDYE0n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Apr 2006 05:26:43 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 25 Apr 2006 13:39:51 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 1FA40203EB
	for <linux-mips@linux-mips.org>; Tue, 25 Apr 2006 13:39:46 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 140AD2016E
	for <linux-mips@linux-mips.org>; Tue, 25 Apr 2006 13:39:46 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k3P4dj4D026102
	for <linux-mips@linux-mips.org>; Tue, 25 Apr 2006 13:39:45 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 25 Apr 2006 13:39:44 +0900 (JST)
Message-Id: <20060425.133944.88701465.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Subject: CROSS_COMPILE in environment variable
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

In the toplevel Makefile, CROSS_COMPILE is described as:

# CROSS_COMPILE can be set on the command line
# make CROSS_COMPILE=ia64-linux-
# Alternatively CROSS_COMPILE can be set in the environment.
# Default value for CROSS_COMPILE is not to prefix executables
# Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile

And currently, arch/mips/Makefile assigns CROSS_COMPILE as:

CROSS_COMPILE		:= $(tool-prefix)

This overrides environment variable's settings unconditionaly so we
can no do the 'alternative' method described above (specify
CROSS_COMPILE by shell environment variable).

If arch/mips/Makefile used "?=" assigment instead of ":=", we can
specify CROSS_COMPILE by shell environment variable.

Is there any reason to using ":=" ?  If no, shouldn't we change
arch/mips/Makefile corresponding to the description?

---
Atsushi Nemoto
