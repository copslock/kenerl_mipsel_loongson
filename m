Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 02:42:14 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:7951 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133730AbWCTCmE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Mar 2006 02:42:04 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3606164D3D; Mon, 20 Mar 2006 02:51:38 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id E211B66ED5; Mon, 20 Mar 2006 02:51:20 +0000 (GMT)
Date:	Mon, 20 Mar 2006 02:51:20 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [MIPS] Separate CPU entries in /proc/cpuinfo with a blank line
Message-ID: <20060320025120.GA18414@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Put in a blank line between CPU entries in /proc/cpuinfo, just like
most other architectures (i386, ia64, x86_64) do.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -135,6 +135,7 @@ static int show_cpuinfo(struct seq_file 
 	        cpu_has_vce ? "%u" : "not available");
 	seq_printf(m, fmt, 'D', vced_count);
 	seq_printf(m, fmt, 'I', vcei_count);
+	seq_printf(m, "\n");
 
 	return 0;
 }

-- 
Martin Michlmayr
http://www.cyrius.com/
