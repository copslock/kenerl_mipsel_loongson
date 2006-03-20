Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:27:14 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:36623 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133350AbWCTE0U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:26:20 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0798064D3D; Mon, 20 Mar 2006 04:35:58 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 4B44666ED5; Mon, 20 Mar 2006 04:35:42 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:35:42 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, akpm@osdl.org
Subject: [PATCH 2/6] [VIDEO] Remove trailing whitespace from drivers/video/Kconfig
Message-ID: <20060320043542.GB20200@deprecation.cyrius.com>
References: <20060320043445.GA20171@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043445.GA20171@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Remove trailing whitespace from drivers/video/Kconfig, thereby
syncing with with Linus' tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Maciej W. Rozycki <macro@linux-mips.org>


--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1336,8 +1336,8 @@ config FB_PMAGB_B
  	select FB_CFB_IMAGEBLIT
 	help
 	  Support for the PMAGB-B TURBOchannel framebuffer card used mainly
-	  in the MIPS-based DECstation series. The card is currently only 
-	  supported in 1280x1024x8 mode.  
+	  in the MIPS-based DECstation series. The card is currently only
+	  supported in 1280x1024x8 mode.
 
 config FB_MAXINE
 	bool "Maxine (Personal DECstation) onboard framebuffer support"

-- 
Martin Michlmayr
http://www.cyrius.com/
