Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jun 2010 18:31:24 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:45020 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491973Ab0FWQbV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jun 2010 18:31:21 +0200
Received: by iwn6 with SMTP id 6so2723890iwn.36
        for <multiple recipients>; Wed, 23 Jun 2010 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6+mnvSk88cVoStlt6Lwx73nsR2LRUriBfpGOpEX7vys=;
        b=tcoVD4KToVuME58yc4ms2YHhmUzCBUUtg3721P6fzvq1Gayos1JS6fp0tyyLAGG9im
         sFmPLicNCaNnUuGvx0dhl40zrj9DjqQtElk3QuGThZfQXobMZF9DSa0F5uWvBTFr0sWX
         wEzAlNqA6LFcBCTFa7AOB56GSMBiZ9fc3zXFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ng90FJxCMtEMsjAiW7Lpijbdu4mdzf8RwvGbstzUDjCnhbKLnAjPaW5Uw4HPA4tKyt
         Lhk+ForRrU6TiSEeBlHzjJKkIlmDggJUyWYmafT+gND84UcH7pAPKSZtMNYe0rxDVGJQ
         trvS0Dwkq1nYNIBwBIE+cvsQUO/8QD8OboeQM=
MIME-Version: 1.0
Received: by 10.231.130.162 with SMTP id t34mr8638897ibs.157.1277310678311; 
        Wed, 23 Jun 2010 09:31:18 -0700 (PDT)
Received: by 10.231.183.5 with HTTP; Wed, 23 Jun 2010 09:31:18 -0700 (PDT)
In-Reply-To: <20100624012415L.fujita.tomonori@lab.ntt.co.jp>
References: <20100624012415L.fujita.tomonori@lab.ntt.co.jp>
Date:   Wed, 23 Jun 2010 18:31:18 +0200
Message-ID: <AANLkTimNUemAUf8OI_lQYw4eDRC3uo0rTWORxH1wqHU_@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: fix deprecated compile warnings
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        manuel.lauss@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 27247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16109

On Wed, Jun 23, 2010 at 6:26 PM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> I got the following errors on linux-next. They might be already
> addressed (I've not subscribed to linux-mips@linux-mips), but anyway
> here's a fix.
>
> =
> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Subject: [PATCH] MIPS: Alchemy: fix deprecated compile warnings
>
> replace deprecated DMA_32BIT_MASK with DMA_BIT_MASK.
>
> cc1: warnings being treated as errors
> arch/mips/alchemy/devboards/db1200/platform.c:219: error: 'DMA_nnBIT_MASK' is deprecated
> arch/mips/alchemy/devboards/db1200/platform.c:226: error: 'DMA_nnBIT_MASK' is deprecated
> arch/mips/alchemy/devboards/db1200/platform.c:388: error: 'DMA_nnBIT_MASK' is deprecated
> arch/mips/alchemy/devboards/db1200/platform.c:393: error: 'DMA_nnBIT_MASK' is deprecated
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> ---
>  arch/mips/alchemy/devboards/db1200/platform.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Manuel Lauss <manuel.lauss@googlemail.com>

Thank you!
       Manuel Lauss
