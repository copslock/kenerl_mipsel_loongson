Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 22:42:04 +0000 (GMT)
Received: from mail1.kontent.de ([81.88.34.36]:64898 "EHLO Mail1.KONTENT.De")
	by ftp.linux-mips.org with ESMTP id S8133508AbWAIWlr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2006 22:41:47 +0000
Received: from p549A1508.dip0.t-ipconnect.de (p549A1508.dip0.t-ipconnect.de [84.154.21.8])
	by Mail1.KONTENT.De (Postfix) with ESMTP id 0AE4210D7EF6;
	Mon,  9 Jan 2006 23:44:58 +0100 (CET)
From:	Oliver Neukum <oliver@neukum.org>
To:	linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] UDC support for MIPS/AU1200 and Geode/CS5536
Date:	Mon, 9 Jan 2006 23:44:55 +0100
User-Agent: KMail/1.8
Cc:	"Jordan Crouse" <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com,
	thomas.dahlmann@amd.com
References: <20060109180356.GA8855@cosmic.amd.com>
In-Reply-To: <20060109180356.GA8855@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601092344.55988.oliver@neukum.org>
Return-Path: <oliver@neukum.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oliver@neukum.org
Precedence: bulk
X-list: linux-mips

Am Montag, 9. Januar 2006 19:03 schrieb Jordan Crouse:
> >From the "two-birds-one-stone" department, I am pleased to present USB UDC
> support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
> Also, coming soon (in the next few days), OTG, which has been removed from
> the usb_host patch, and put into its own patch (as per David's comments).
> 
> This patch is against current linux-mips git, but it should apply for Linus's
> tree as well.
> 
> Regards,
> Jordan
> 
+        VDBG("udc_read_bytes(): %d bytes\n", bytes);
+
+        /* dwords first */
+        for (i = 0; i < bytes / UDC_DWORD_BYTES; i++) {
+               *((u32*) (buf + (i<<2))) = readl(dev->rxfifo); 
+        }

Is there any reason you don't increment by 4?

	Regards
		Oliver
