Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 05:37:24 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:33555
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133498AbVJEEhE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 05:37:04 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 4 Oct 2005 21:37:02 -0700
Message-ID: <4343586E.4030703@avtrex.com>
Date:	Tue, 04 Oct 2005 21:37:02 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] fix warning in tlbex.c for CONFIG_32BIT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Oct 2005 04:37:02.0413 (UTC) FILETIME=[6E4A2FD0:01C5C966]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

For 32 bit builds CONFIG_64BIT is not defined.  Should be doing #ifdef 
not #if.

Signed-off-by: David Daney <ddaney@avtrex.com>



diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -513,7 +513,7 @@ static __init int rel_lo(long val)

  static __init void i_LA_mostly(u32 **buf, unsigned int rs, long addr)
  {
-#if CONFIG_64BIT
+#ifdef CONFIG_64BIT
         if (!in_compat_space_p(addr)) {
                 i_lui(buf, rs, rel_highest(addr));
                 if (rel_higher(addr))
