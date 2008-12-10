Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2008 20:28:31 +0000 (GMT)
Received: from mail-gx0-f19.google.com ([209.85.217.19]:52873 "EHLO
	mail-gx0-f19.google.com") by ftp.linux-mips.org with ESMTP
	id S24119914AbYLJU22 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Dec 2008 20:28:28 +0000
Received: by gxk12 with SMTP id 12so796850gxk.9
        for <multiple recipients>; Wed, 10 Dec 2008 12:28:19 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6K3LjKx56O51wSW2YfQHvJR1b8t2jkRmz7UhXJs/ITA=;
        b=uZY1AU+/EoFtJU+UID3h3MUke/l672hb3o0/kg9nqIeRzCKvoR+pTJmkeuTusCzO2b
         ysTpof8NuDG+WOawHAMvKrBzlsTLe/Bfgmav0Wkcq6VN2bFEy2Im2LoBvdF8UPUt0d+W
         RhW5yNt7dWm43tn75BDTTc49FHr+PsYSETjrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pknBF8fsztIXkh+wptcRhPU4+nY8kjlpdrgC0s5sNdIpj41hDQs/FbcyV3FYM16W2D
         IDvIHrdo0pgI6FvJ/OVjFng+Exq0ydoNLonM9XbHL6QBP53yP4P3KPh9Rcp8pIIYc9ns
         3cpiepTTPfM9AHKPIhJvIecHc9giPrjJgwUzA=
Received: by 10.90.83.2 with SMTP id g2mr728404agb.69.1228940899016;
        Wed, 10 Dec 2008 12:28:19 -0800 (PST)
Received: by 10.90.31.6 with HTTP; Wed, 10 Dec 2008 12:28:18 -0800 (PST)
Message-ID: <b2b2f2320812101228i285257f6v64e1de88910ea63e@mail.gmail.com>
Date:	Wed, 10 Dec 2008 14:28:18 -0600
From:	"Shane McDonald" <mcdonald.shane@gmail.com>
To:	"Dmitri Vorobiev" <dmitri.vorobiev@movial.fi>
Subject: Re: [PATCH] [MIPS] Kconfig: fix the arch-specific header path
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <1228936355-11675-1-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1228936355-11675-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

As long as you're changing that line, I'd suggest fixing the spelling
mistake, too (debuging should be debugging).

Shane

On Wed, Dec 10, 2008 at 1:12 PM, Dmitri Vorobiev
<dmitri.vorobiev@movial.fi> wrote:
>
> The header path in the help text for the RUNTIME_DEBUG config
> option is obsolete and needs to be updated to match the new
> location of architecture-specific header files.
>
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
> ---
>  arch/mips/Kconfig.debug |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> index 765c8e2..aab004f 100644
> --- a/arch/mips/Kconfig.debug
> +++ b/arch/mips/Kconfig.debug
> @@ -48,7 +48,7 @@ config RUNTIME_DEBUG
>        help
>          If you say Y here, some debugging macros will do run-time checking.
>          If you say N here, those macros will mostly turn to no-ops.  See
> -         include/asm-mips/debug.h for debuging macros.
> +         arch/mips/include/asm/debug.h for debuging macros.
>          If unsure, say N.
>
>  endmenu
> --
> 1.5.4.3
>
>
