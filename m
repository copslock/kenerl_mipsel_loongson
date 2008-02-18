Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 18:11:30 +0000 (GMT)
Received: from vs166246.vserver.de ([62.75.166.246]:18886 "EHLO
	vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S28574212AbYBRSL1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Feb 2008 18:11:27 +0000
Received: from t1be0.t.pppool.de ([89.55.27.224] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1JRASJ-00011W-Sw; Mon, 18 Feb 2008 18:11:08 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH] [SSB] PCI core driver: use new SPROM data structure
Date:	Mon, 18 Feb 2008 19:10:46 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20080217200947.GH1403@cs181133002.pp.htv.fi> <20080218100126.GA22519@hall.aurel32.net> <20080218100257.GB22519@hall.aurel32.net>
In-Reply-To: <20080218100257.GB22519@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802181910.46581.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Monday 18 February 2008 11:02:57 Aurelien Jarno wrote:
> Switch the SSB PCI core driver to the new SPROM data structure now that
> the old one has been removed.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Acked-by: Michael Buesch <mb@bu3sch.de>

John, can you please apply this?

> ---
>  drivers/ssb/driver_pcicore.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ssb/driver_pcicore.c b/drivers/ssb/driver_pcicore.c
> index 2faaa90..191db7a 100644
> --- a/drivers/ssb/driver_pcicore.c
> +++ b/drivers/ssb/driver_pcicore.c
> @@ -362,7 +362,7 @@ static int pcicore_is_in_hostmode(struct ssb_pcicore *pc)
>  	    chipid_top != 0x5300)
>  		return 0;
>  
> -	if (bus->sprom.r1.boardflags_lo & SSB_PCICORE_BFL_NOPCI)
> +	if (bus->sprom.boardflags_lo & SSB_PCICORE_BFL_NOPCI)
>  		return 0;
>  
>  	/* The 200-pin BCM4712 package does not bond out PCI. Even when
> -- 
> 1.5.4.1
> 



-- 
Greetings Michael.
