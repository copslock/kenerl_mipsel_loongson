Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 11:45:36 +0100 (BST)
Received: from cantor2.suse.de ([195.135.220.15]:41601 "EHLO mx2.suse.de")
	by ftp.linux-mips.org with ESMTP id S20027707AbYHSKp3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 11:45:29 +0100
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5DF3245DF4;
	Tue, 19 Aug 2008 12:45:28 +0200 (CEST)
Date:	Tue, 19 Aug 2008 12:45:27 +0200
Message-ID: <s5h3al1xozc.wl%tiwai@suse.de>
From:	Takashi Iwai <tiwai@suse.de>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	alsa-devel@alsa-project.org, linux-mips@linux-mips.org,
	akpm@linux-foundation.org
Subject: Re: [alsa-devel] [PATCH] Remove OSS driver for SGI HAL2 audio device
In-Reply-To: <20080814072008.B5E06C316D@solo.franken.de>
References: <20080814072008.B5E06C316D@solo.franken.de>
User-Agent: Wanderlust/2.12.0 (Your Wildest Dreams) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.7 (=?ISO-8859-4?Q?Sanj=F2?=) APEL/10.6 Emacs/22.2
 (x86_64-suse-linux-gnu) MULE/5.0 (SAKAKI)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tiwai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips

At Thu, 14 Aug 2008 09:20:08 +0200 (CEST),
Thomas Bogendoerfer wrote:
> 
> With the restructering of the indy button handling the old OSS HAL2
> driver got broken. Since there is a new ALSA driver for HAL2, the
> experimental OSS driver is obsolete and will be removed by this patch.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

I applied this patch on my tree now, thus will appear on linux-next,
too.

Please let me know if any one still requires the old hal2 driver.


thanks,

Takashi
