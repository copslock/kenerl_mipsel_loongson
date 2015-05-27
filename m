Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 22:31:49 +0200 (CEST)
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36163 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007493AbbE0UbrPJi6T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 22:31:47 +0200
Received: by qkx62 with SMTP id 62so12903558qkx.3;
        Wed, 27 May 2015 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u9W9WXq+DQzomay68M6UCRL2X3chvqvCwutRTPN707g=;
        b=cXaOt1TiI/La34QB3BOhXWiESWu+LAtQCcqgHg9fpYNtENsS1rBL1X63mzrDm7AxvF
         DSiOcSpDf2D1lgZzsUaoJMYJRX+GkIprucbXi6bJ5Kh7dYTSSmIO3NF8QijwLCBaJsDC
         JqI8yZdsNhhOl5S4AP/4CSKQf77ltIZqEsdTxwE2wTHYQZDeNtkI5XsS6k82Pa4M8dCr
         +SxhQ4XxacwvDo0SVk8EPlUzLQ4rDFy6mKn5mTrqp5NxRB7O6l+M8za/G2Vsra15e6IH
         ZjTp0lT3MWTtqTSh6c5MLRDwdtiU59eSiatUmmUX6mxri2LD3GW11+/I7vZTzZRPJrGP
         eu5w==
X-Received: by 10.140.235.147 with SMTP id g141mr34478356qhc.35.1432758704025;
 Wed, 27 May 2015 13:31:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.106.196 with HTTP; Wed, 27 May 2015 13:31:23 -0700 (PDT)
In-Reply-To: <20150527062508.CD24722020B@puck.mtv.corp.google.com>
References: <20150527062508.CD24722020B@puck.mtv.corp.google.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 27 May 2015 13:31:23 -0700
Message-ID: <CAJiQ=7AuDs3nLdmppFn2--ni0bLhaMDRpjOuJzYY8c0TB4CGyQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BMIPS: fix bmips_wr_vec()
To:     Petri Gynther <pgynther@google.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, May 26, 2015 at 11:25 PM, Petri Gynther <pgynther@google.com> wrote:
> bmips_wr_vec() copies exception vector code from start to dst.
>
> The call to dma_cache_wback() needs to flush (end-start) bytes,
> starting at dst, from write-back cache to memory.
>
> Signed-off-by: Petri Gynther <pgynther@google.com>
> ---
>  arch/mips/kernel/smp-bmips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
> index fd528d7..336708a 100644
> --- a/arch/mips/kernel/smp-bmips.c
> +++ b/arch/mips/kernel/smp-bmips.c
> @@ -444,7 +444,7 @@ struct plat_smp_ops bmips5000_smp_ops = {
>  static void bmips_wr_vec(unsigned long dst, char *start, char *end)
>  {
>         memcpy((void *)dst, start, end - start);
> -       dma_cache_wback((unsigned long)start, end - start);
> +       dma_cache_wback(dst, end - start);
>         local_flush_icache_range(dst, dst + (end - start));
>         instruction_hazard();
>  }
> --
> 2.2.0.rc0.207.ga3a616c

Thanks Petri for catching this.

Reviewed-by: Kevin Cernekee <cernekee@gmail.com>
