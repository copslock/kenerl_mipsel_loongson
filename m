Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 13:37:48 +0000 (GMT)
Received: from mail1.kontent.de ([81.88.34.36]:59827 "EHLO Mail1.KONTENT.De")
	by ftp.linux-mips.org with ESMTP id S3465568AbWAJNh1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2006 13:37:27 +0000
Received: from p549A12AB.dip0.t-ipconnect.de (p549A12AB.dip0.t-ipconnect.de [84.154.18.171])
	by Mail1.KONTENT.De (Postfix) with ESMTP id 0973F100EDC3;
	Tue, 10 Jan 2006 14:40:35 +0100 (CET)
From:	Oliver Neukum <oliver@neukum.org>
To:	"Thomas Dahlmann" <thomas.dahlmann@amd.com>
Subject: Re: [linux-usb-devel] [PATCH] UDC support for MIPS/AU1200 and Geode/CS5536
Date:	Tue, 10 Jan 2006 14:40:38 +0100
User-Agent: KMail/1.8
Cc:	linux-usb-devel@lists.sourceforge.net,
	"Jordan Crouse" <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
References: <20060109180356.GA8855@cosmic.amd.com> <200601092344.55988.oliver@neukum.org> <43C39431.6020308@amd.com>
In-Reply-To: <43C39431.6020308@amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101440.38853.oliver@neukum.org>
Return-Path: <oliver@neukum.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oliver@neukum.org
Precedence: bulk
X-list: linux-mips

Am Dienstag, 10. Januar 2006 12:02 schrieb Thomas Dahlmann:
> 
> Oliver Neukum wrote:
> 
> >Am Montag, 9. Januar 2006 19:03 schrieb Jordan Crouse:
> >  
> >
> >>>From the "two-birds-one-stone" department, I am pleased to present USB UDC
> >>support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
> >>Also, coming soon (in the next few days), OTG, which has been removed from
> >>the usb_host patch, and put into its own patch (as per David's comments).
> >>
> >>This patch is against current linux-mips git, but it should apply for Linus's
> >>tree as well.
> >>
> >>Regards,
> >>Jordan
> >>
> >>    
> >>
> >+        VDBG("udc_read_bytes(): %d bytes\n", bytes);
> >+
> >+        /* dwords first */
> >+        for (i = 0; i < bytes / UDC_DWORD_BYTES; i++) {
> >+               *((u32*) (buf + (i<<2))) = readl(dev->rxfifo); 
> >+        }
> >
> >Is there any reason you don't increment by 4?
> >
> >	Regards
> >		Oliver
> >
> >
> >
> >  
> >
> The loop is for reading dwords only, so "i < bytes / UDC_DWORD_BYTES" cuts
> off remaining 1,2 or 3 bytes which are handled by the next loop.
> But you are right, incrementing by 4 may look better,  as
> 
>         for (i = 0; i < bytes - bytes % UDC_DWORD_BYTES; i+=4) {
>                *((u32*) (buf + i)) = readl(dev->rxfifo); 
>         }

Not only will it look better, but it'll save you a shift operation.
You might even compute start and finish values before the loop and
save an addition in the body.

	Regards
		Oliver
