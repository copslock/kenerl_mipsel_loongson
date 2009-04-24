Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 15:49:24 +0100 (BST)
Received: from mail-gx0-f157.google.com ([209.85.217.157]:39935 "EHLO
	mail-gx0-f157.google.com") by ftp.linux-mips.org with ESMTP
	id S20023926AbZDXOtQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2009 15:49:16 +0100
Received: by gxk1 with SMTP id 1so2361506gxk.0
        for <multiple recipients>; Fri, 24 Apr 2009 07:49:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=pMDyAah7gAA5TW/9kZ/3zTVUHfmt7lhJPqzzCDmLkPk=;
        b=f9tQ58moGd5ru8eINQ5FFVI4Uo4mH4YiSLbgtJmHyX/PKauENj+/uIoPM+6So/PV4a
         jAf9qIlWNxUEa+EM84Mq9q+4vIi9KenABh6FFk1m6pHBbX2J7tmsbvBMCiLgjUxNJbnx
         KUgH39zKjCCvfifRcy7eVnxQa+qYulKKqbAHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=dG3uyWsLTz7unwWZyt/c/7Ssw96m7xkKVsOsC1vUZmQNytl7TxM7h0aPYdC9efqH4s
         hL+loprQ+ZiYiDH1KQu9oG/2mB+Ppg+tTpY3VVRmBZs2Lno6zDjNb/FXGp8VYC8ClVSH
         D16+Vng/3CZw1nJ43Qd3FfeDkxIXPOhAtej2E=
MIME-Version: 1.0
Received: by 10.151.129.8 with SMTP id g8mr2585161ybn.104.1240584550397; Fri, 
	24 Apr 2009 07:49:10 -0700 (PDT)
In-Reply-To: <1240414831-20429-1-git-send-email-anemo@mba.ocn.ne.jp>
References: <1240414831-20429-1-git-send-email-anemo@mba.ocn.ne.jp>
Date:	Fri, 24 Apr 2009 07:49:10 -0700
X-Google-Sender-Auth: 103c66f36e12f74e
Message-ID: <e9c3a7c20904240749g79b7b54cufa64149e44b5753a@mail.gmail.com>
Subject: Re: [PATCH] DMA: TXx9 Soc DMA Controller driver (v3)
From:	Dan Williams <dan.j.williams@intel.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dan.j.williams@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.j.williams@intel.com
Precedence: bulk
X-list: linux-mips

On Wed, Apr 22, 2009 at 8:40 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> This patch adds support for the integrated DMAC of the TXx9 family.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Acked-by: Dan Williams <dan.j.williams@intel.com>

> +static void
> +txx9dmac_descriptor_complete(struct txx9dmac_chan *dc,
> +                            struct txx9dmac_desc *desc)
[..]
> +       /*
> +        * We use dma_unmap_page() regardless of how the buffers were
> +        * mapped before they were submitted...
> +        */

This will be caught by the new dma-mapping debug infrastructure that
went in for 2.6.30, but I would not hold up merging this driver for
this issue.  Once Maciej's fix [1] goes upstream you can fix up your
driver to use the new "unmap single" flags.

Thanks,
Dan

[1]: http://marc.info/?l=linux-kernel&m=124049040806961&w=2
