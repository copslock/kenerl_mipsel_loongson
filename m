Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 14:10:48 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:50706 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133762AbWBTOKI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 14:10:08 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E61EE64D3D; Mon, 20 Feb 2006 14:17:02 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 947A68DC5; Mon, 20 Feb 2006 14:16:55 +0000 (GMT)
Date:	Mon, 20 Feb 2006 14:16:55 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
Message-ID: <20060220141655.GK29098@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060219234757.GW10266@deprecation.cyrius.com> <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-02-20 13:33]:
> > +	  in the MIPS-based DECstation series. The card is currently only
> > +	  supported in 1280x1024x8 mode.
>  ACK.


[MIPS] Remove trailing whitespace from drivers/video/Kconfig - sync with Linus tree

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

---

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7d7724c..7e63f15 100644
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
