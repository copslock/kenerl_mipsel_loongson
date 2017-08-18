Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 19:14:47 +0200 (CEST)
Received: from mail.skyhub.de ([IPv6:2a01:4f8:190:11c2::b:1457]:55373 "EHLO
        mail.skyhub.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994922AbdHRROgnD0Rq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 19:14:36 +0200
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RvweuIi3322t; Fri, 18 Aug 2017 19:14:35 +0200 (CEST)
Received: from pd.tnic (p2003008C2F319E00D8A0629D32DD6C06.dip0.t-ipconnect.de [IPv6:2003:8c:2f31:9e00:d8a0:629d:32dd:6c06])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79F681EC014F;
        Fri, 18 Aug 2017 19:14:35 +0200 (CEST)
Date:   Fri, 18 Aug 2017 19:14:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     ralf@linux-mips.org, david.daney@cavium.com, mchehab@kernel.org,
        linux-edac@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] EDAC, thunderx: Fix an error handling path in
 'thunderx_lmc_probe()'
Message-ID: <20170818171434.qlxnimpnuvrhipa7@pd.tnic>
References: <20170816045821.14165-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170816045821.14165-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <bp@alien8.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bp@alien8.de
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

On Wed, Aug 16, 2017 at 06:58:21AM +0200, Christophe JAILLET wrote:
> 'ret' is known to be 0 at this point.
> If 'ioremap()' fails, returns -ENOMEM instead of 0 which means success.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/edac/thunderx_edac.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
