Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Nov 2009 19:17:06 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.153]:43135 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492932AbZKGSQ6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Nov 2009 19:16:58 +0100
Received: by fg-out-1718.google.com with SMTP id d23so888208fga.6
        for <multiple recipients>; Sat, 07 Nov 2009 10:16:57 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kWNCg9KEVQQID2SolBlgU7aBt8khuYlLS07Jl/y8m5A=;
        b=fWLUY7KWv+78sIEhzr3ZuOYSWOHnMbS+Znz/LQ+4QVPSCB/wq3LME/O2mWE3bcbGHG
         VWxPaT9AzdF8N0CX4MPL+8RsuGzPqqmtu271p/s4wvVEFsycSoGpVHLiO8mwgA8w2zc3
         mJs6UgWUAnR98kzehhpTgaHOmNvUVI7FWPzIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XqAAGVe6sPcSnq9GeBv8vXBJQcilQyjk/TWZW8eCjYJJFzuO+5M/hV/rCLMVpTX3gl
         LmomLNaHrULrZy+dpOIGTCTa5ewF3nLeHZKbpeKxnJ/y+ZoUPDBYUoFxs8z9Xva9F3Y3
         HuTV9QzuPqt2yXFE9kV3rVn9cR0OBxwejntKI=
MIME-Version: 1.0
Received: by 10.223.145.129 with SMTP id d1mr816010fav.99.1257617817607; Sat, 
	07 Nov 2009 10:16:57 -0800 (PST)
In-Reply-To: <1257614437-8632-1-git-send-email-anemo@mba.ocn.ne.jp>
References: <1257614437-8632-1-git-send-email-anemo@mba.ocn.ne.jp>
Date:	Sat, 7 Nov 2009 20:16:57 +0200
Message-ID: <90edad820911071016v70e6e68bia8f0c3b6f09ceb3c@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Make local arrays with CL_SIZE static __initdata
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Nov 7, 2009 at 7:20 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Since commit 22242681 ("MIPS: Extend COMMAND_LINE_SIZE"), CL_SIZE is
> 4096 and local array variables with this size will cause an build
> failure with default CONFIG_FRAME_WARN settings.
>
> Although current users of such array variables are all early bootstrap
> code and might not cause real stack overflow (thread_info corruption),
> it would be safe to declare these arrays static with __initdata.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  arch/mips/bcm47xx/prom.c           |    2 +-
>  arch/mips/mti-malta/malta-memory.c |    3 ++-
>  arch/mips/rb532/prom.c             |    2 +-
>  arch/mips/txx9/generic/setup.c     |    4 ++--
>  4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
> index 079e33d..fb284c3 100644
> --- a/arch/mips/bcm47xx/prom.c
> +++ b/arch/mips/bcm47xx/prom.c
> @@ -100,7 +100,7 @@ static __init void prom_init_console(void)
>
>  static __init void prom_init_cmdline(void)
>  {
> -       char buf[CL_SIZE];
> +       static char buf[CL_SIZE] __initdata;

If this is intended for -queue, this patch won't apply, because
CL_SIZE was recently removed in favor of using CONFIG_CMDLINE_SIZE
directly.

Also, I think it's more common to place __initdata before the variable
name, not after it, although tastes do differ. :)

Thanks,
Dmitri
