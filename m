Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2011 20:06:18 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:52464 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491059Ab1FISGN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jun 2011 20:06:13 +0200
Received: by ywf9 with SMTP id 9so1202185ywf.36
        for <multiple recipients>; Thu, 09 Jun 2011 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Erq7HINOQZYCI4yUaCpPjD8IV7J4CA8/HNlON0lwrJI=;
        b=dIUHQxleNc9RVoaX0ET3iomnw8rRqmBAJsL1ODLH55Y1Ax5y1nS6GbKcFRzcAeHV/F
         fKmPLokVRvZijuRfvn4sl1HGBaLJDsfX0mh9LBT00DIYO9cM7kuJfybRCEwrpPbOO3Q6
         YDAX+/gZ2xj1sEAogk2h9OxW/cYFFhFw5/FmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eO9akhI+CQVkrbR9OM7oiVDY4WXZXT1+HsTAzFCx0bgQqk6CKS53XFqC9NRaNdJg8k
         zgtp9qT7wWgD/JND0lnzvVk+mdNEhC6hggsn+1/bxalZZ7xpg7s8dySTj9KTlHlpMdOE
         mzzPZr0Iea9Zi7EcVc8181MTZrJSL8qBsgMmc=
MIME-Version: 1.0
Received: by 10.236.155.41 with SMTP id i29mr1346748yhk.444.1307642765725;
 Thu, 09 Jun 2011 11:06:05 -0700 (PDT)
Received: by 10.236.95.173 with HTTP; Thu, 9 Jun 2011 11:06:05 -0700 (PDT)
In-Reply-To: <1307642253-8770-1-git-send-email-blogic@openwrt.org>
References: <1307642253-8770-1-git-send-email-blogic@openwrt.org>
Date:   Thu, 9 Jun 2011 20:06:05 +0200
Message-ID: <BANLkTikWCDhUPDX_fJ20+TVoqaq4Y9q5ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: lantiq: adds missing clk.h functions
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8300

On Thu, Jun 9, 2011 at 7:57 PM, John Crispin <blogic@openwrt.org> wrote:
> The 2 functions clk_enable() and clk_disable were missing.
>
> Signed-of-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/lantiq/clk.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
> index 9456089..aba91db 100644
> --- a/arch/mips/lantiq/clk.c
> +++ b/arch/mips/lantiq/clk.c
> @@ -100,6 +100,17 @@ void clk_put(struct clk *clk)
>  }
>  EXPORT_SYMBOL(clk_put);
>
> +int clk_enable(struct clk *clk)
> +{
> +       /* not used */
> +       return 0;
> +}
> +
> +void clk_disable(struct clk *clk)
> +{
> +       /* not used */
> +}
> +

Shouldn't those be exported as well?

Manuel
