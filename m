Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:40:31 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:64271 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133754AbWCTEcG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:32:06 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 81C3F64D3D; Mon, 20 Mar 2006 04:41:43 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B711666ED5; Mon, 20 Mar 2006 04:41:27 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:41:27 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 12/12] [SCSI] mem_start is a physical address already
Message-ID: <20060320044127.GL20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

mem_start is a physical address already so there's no need to call
CPHYSADDR().  This brings the file in sync with the linux-mips tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Maciej W. Rozycki <macro@linux-mips.org>


--- linux-2.6/drivers/scsi/dec_esp.c	2006-03-05 19:35:05.000000000 +0000
+++ mips.git/drivers/scsi/dec_esp.c	2006-03-05 18:51:16.000000000 +0000
@@ -230,7 +230,7 @@
 			mem_start = get_tc_base_addr(slot);
 
 			/* Store base addr into esp struct */
-			esp->slot = CPHYSADDR(mem_start);
+			esp->slot = mem_start;
 
 			esp->dregs = 0;
 			esp->eregs = (void *)CKSEG1ADDR(mem_start +

-- 
Martin Michlmayr
http://www.cyrius.com/
