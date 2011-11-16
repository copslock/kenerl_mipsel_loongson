Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 20:51:45 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:59313 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903864Ab1KPTvi convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 20:51:38 +0100
Received: by ggnb1 with SMTP id b1so96807ggn.36
        for <multiple recipients>; Wed, 16 Nov 2011 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HjzCm+trlPzkD9bmrh7jrImO5ZytGP+DtIVacgGYy/I=;
        b=pSTwbHiZE7Q95eKvGPZ6R0Fnlaf8XsT1x0pwfPd2d7o3mtWsRB3EBR+xR1gVy1GhM4
         NoSV9J+iuRLRH2z27/SQKBHDw/OzHCl9/0pBFsf1wF76ByDINnJ1ysB7IsCKNEJKsnTy
         lQ8+0WKh39rM8R8lorbOmfm+qdk7FnyuWhKF8=
Received: by 10.236.200.135 with SMTP id z7mr4328090yhn.33.1321473092118; Wed,
 16 Nov 2011 11:51:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.102.141 with HTTP; Wed, 16 Nov 2011 11:50:51 -0800 (PST)
In-Reply-To: <1321440940-20246-2-git-send-email-xsecute@googlemail.com>
References: <1321440940-20246-1-git-send-email-xsecute@googlemail.com> <1321440940-20246-2-git-send-email-xsecute@googlemail.com>
From:   Manuel Lauss <manuel.lauss@googlemail.com>
Date:   Wed, 16 Nov 2011 20:50:51 +0100
Message-ID: <CAOLZvyENpkRs7RtsUkeBHb-JdYTq1gV3D0m82ukH1m6SGcaT8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Initial PCI support for Atheros 724x SoCs.
To:     Rene Bolldorf <xsecute@googlemail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13789

Howdy,

On Wed, Nov 16, 2011 at 11:55 AM, Rene Bolldorf <xsecute@googlemail.com> wrote:
> Signed-off-by: Rene Bolldorf <xsecute@googlemail.com>
> ---
>  arch/mips/pci/Makefile      |    1 +
>  arch/mips/pci/ops-ath724x.c |  109 +++++++++++++++++++++++++++++++++++++++++++
>  arch/mips/pci/pci-ath724x.c |   45 ++++++++++++++++++

Why don't you just merge ops-ath724x.c into pci-ath724x.c?  (the only
place where its
contents are referenced)


> diff --git a/arch/mips/pci/ops-ath724x.c b/arch/mips/pci/ops-ath724x.c
> new file mode 100644
> index 0000000..bd3cf15
> --- /dev/null
> +++ b/arch/mips/pci/ops-ath724x.c
> @@ -0,0 +1,109 @@
[...]
> +static int ath724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
> +                           int size, uint32_t *value)
> +{
> +       unsigned long flags, addr, tval, mask;
> +
> +       if(devfn)
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +       if(where & (size - 1))
> +               return PCIBIOS_BAD_REGISTER_NUMBER;

Please run both patches through checkpatch once and fix up the
codingstyle issues it
will complain about (like the two above).


Thanks,
        Manuel Lauss
