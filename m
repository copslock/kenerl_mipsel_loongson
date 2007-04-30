Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2007 14:16:52 +0100 (BST)
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73]:32926 "EHLO
	hoboe2bl1.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022461AbXD3NQu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Apr 2007 14:16:50 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe2bl1.telenet-ops.be (Postfix) with SMTP id 08A9A124055;
	Mon, 30 Apr 2007 15:16:49 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by hoboe2bl1.telenet-ops.be (Postfix) with ESMTP id 95C30124053;
	Mon, 30 Apr 2007 15:16:46 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3UDGjMI001165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Apr 2007 15:16:45 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3UDGfqZ000995;
	Mon, 30 Apr 2007 15:16:42 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Mon, 30 Apr 2007 15:16:39 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Christoph Hellwig <hch@lst.de>
Cc:	jejb@steeleye.com, davem@davemloft.net, linux-scsi@vger.kernel.org,
	linux-m68k@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] deprecate the old NCR53C9x driver
In-Reply-To: <20070429220548.GA22666@lst.de>
Message-ID: <Pine.LNX.4.64.0704301516190.27246@anakin>
References: <20070429220548.GA22666@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 30 Apr 2007, Christoph Hellwig wrote:
> Now that we have the much better esp_scsi driver and low level drivers
> are easy to port over deprecate the old NCR53C9x driver.
> 
> I've Cc'ed the m68k and mips lists because all but one bus glues are
> for these platforms.  Chances stand bad for the remaining driver,
> mca_53c9x which hasn't gotten any non-trivial update since it was
> merge in late 2.1.x and whos maintainers mail address bounces.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Index: linux-2.6/Documentation/feature-removal-schedule.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/feature-removal-schedule.txt	2007-04-29 23:44:46.000000000 +0200
> +++ linux-2.6/Documentation/feature-removal-schedule.txt	2007-04-29 23:45:55.000000000 +0200
> @@ -6,6 +6,13 @@ be removed from this file.
>  
>  ---------------------------
>  
> +What:	old NCR53C9x driver
> +When:	October 2007
> +Why:	Replaced by the much better esp_scsi driver.  Actual low-level
> +	driver can ported over almost trivially.
                  ^
		  be

> +Who:	David Miller <davem@davemloft.net>
> +	Christoph Hellwig <hch@lst.de>
> +
>  What:	V4L2 VIDIOC_G_MPEGCOMP and VIDIOC_S_MPEGCOMP
>  When:	October 2007
>  Why:	Broken attempt to set MPEG compression parameters. These ioctls are

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
