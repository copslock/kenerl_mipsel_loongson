Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 17:46:52 +0100 (CET)
Received: from sorrow.cyrius.com ([65.19.161.204]:51112 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493489AbZKSQqq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 17:46:46 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id D0B11D8C6; Thu, 19 Nov 2009 16:46:43 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 3E7CF1501ED; Thu, 19 Nov 2009 16:46:32 +0000 (GMT)
Date:	Thu, 19 Nov 2009 16:46:32 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: [RFC] [PATCH] Disable EMBEDDED on MIPS
Message-ID: <20091119164632.GA15279@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

There's no reason for MIPS to select EMBEDDED.  In fact, EMBEDDED
makes MIPS more awkward to deal with because it makes it different
to the majority of architectures for no good reason.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1aad0d9..091f349 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -5,8 +5,6 @@ config MIPS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB
-	# Horrible source of confusion.  Die, die, die ...
-	select EMBEDDED
 	select RTC_LIB if !LEMOTE_FULOONG2E
 
 mainmenu "Linux/MIPS Kernel Configuration"

-- 
Martin Michlmayr
http://www.cyrius.com/
