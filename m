Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 00:24:57 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:270 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133727AbWBTAYm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2006 00:24:42 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9F44064D3D; Mon, 20 Feb 2006 00:31:35 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 910978D5D; Mon, 20 Feb 2006 00:31:28 +0000 (GMT)
Date:	Mon, 20 Feb 2006 00:31:28 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: elf.h
Message-ID: <20060220003128.GD17967@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001126.GA17967@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220001126.GA17967@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Can we agree?

--- linux-2.6.16-rc4/include/linux/elf.h	2006-02-19 20:09:52.000000000 +0000
+++ mips-2.6.16-rc4/include/linux/elf.h	2006-02-19 20:16:23.000000000 +0000
@@ -67,7 +67,7 @@
 
 #define EM_MIPS		8	/* MIPS R3000 (officially, big-endian only) */
 
-#define EM_MIPS_RS4_BE 10	/* MIPS R4000 big-endian */
+#define EM_MIPS_RS3_LE 10	/* MIPS R3000 little-endian */
 
 #define EM_PARISC      15	/* HPPA */
 

-- 
Martin Michlmayr
http://www.cyrius.com/
