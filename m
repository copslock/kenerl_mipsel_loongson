Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 09:18:35 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:43491 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225226AbUKUJS3>;
	Sun, 21 Nov 2004 09:18:29 +0000
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id iAL9IQGU013647;
	Sun, 21 Nov 2004 10:18:27 +0100 (MET)
Date: Sun, 21 Nov 2004 10:18:26 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ip32 build fix
In-Reply-To: <20041121065630.GA6701@linux-mips.org>
Message-ID: <Pine.GSO.4.61.0411211017350.19680@waterleaf.sonytel.be>
References: <20041121024144.GK20986@rembrandt.csv.ica.uni-stuttgart.de>
 <20041121065630.GA6701@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 21 Nov 2004, Ralf Baechle wrote:
> On Sun, Nov 21, 2004 at 03:41:44AM +0100, Thiemo Seufer wrote:
> > a simple build fix for the ip32 framebuffer.
> 
> Thanks, applied.

FYI, this has been fixed differently in mainline:

On Fri, 19 Nov 2004, Linux Kernel Mailing List wrote:
| ChangeSet 1.2183, 2004/11/19 14:54:09-08:00, giuseppe@eppesuigoccas.homedns.org
| 
| 	[PATCH] gbefb.c build fix
| 	
| 	The current gbefb.c source cannot be compiled as module because of a small
| 	typo where "option" was written instead of "options" in two places.
| 	
| 	Signed-off-by: Andrew Morton <akpm@osdl.org>
| 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
| 
| 
| 
|  gbefb.c |    4 ++--
|  1 files changed, 2 insertions(+), 2 deletions(-)
| 
| 
| diff -Nru a/drivers/video/gbefb.c b/drivers/video/gbefb.c
| --- a/drivers/video/gbefb.c	2004-11-19 16:11:11 -08:00
| +++ b/drivers/video/gbefb.c	2004-11-19 16:11:11 -08:00
| @@ -1084,9 +1084,9 @@
|  	int i, ret = 0;
|  
|  #ifndef MODULE
| -	char *option = NULL;
| +	char *options = NULL;
|  
| -	if (fb_get_options("gbefb", &option))
| +	if (fb_get_options("gbefb", &options))
|  		return -ENODEV;
|  	gbefb_setup(options);
|  #endif
| -
| To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
