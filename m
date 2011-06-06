Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 13:34:24 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:34177 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1FFLeV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 13:34:21 +0200
Received: by qyl38 with SMTP id 38so2228710qyl.15
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 04:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T3uuQdTY6x1mI1O0cDc0jqZ+uLB7Wb0PB89Q5fluNtI=;
        b=hA3+nirSdFYIZoQ05xkmpD/0+lDcvFLPoXm0PMkf6fCE4OQgfstim4WjHHqDO3rxkU
         YHjFtH/hp4WJBswuX0z1WmIojp852PKXX6gK3dyWIwm0/Nzmbp1PWjv348o8FqrI5+Hn
         rzuvBgjHv1KdwuRybDb1TYCPQxSu+Ysr1Eq7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gCbb4G+IEesLcl8LJllr8pfHYO8lGowvq1SYnVUepe2bF50ynHq6q3dhiFX4XcRk82
         913/GyE6x1DOuggJKk2iO9/4Zs1XpwTbk87Pqx2I9PM7/Ff08GUyVrg+zsNPuZJDDPDS
         IztArznGhIIW9H/F57B6HCG0MbNSOPDsEs2Rw=
MIME-Version: 1.0
Received: by 10.229.43.99 with SMTP id v35mr3467947qce.8.1307360055878; Mon,
 06 Jun 2011 04:34:15 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 04:34:15 -0700 (PDT)
In-Reply-To: <1307311658-15853-8-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-8-git-send-email-hauke@hauke-m.de>
Date:   Mon, 6 Jun 2011 13:34:15 +0200
Message-ID: <BANLkTi=6F_T1vwJL3e0DMbKhuFjjnF5pAQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 07/10] bcma: add pci(e) host mode
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4146

2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
> +#ifdef CONFIG_BCMA_PCICORE_HOSTMODE
> +/* driver_pci_host.c */
> +extern int bcma_pcicore_is_in_hostmode(struct bcma_drv_pci *pc);
> +extern void bcma_pcicore_init_hostmode(struct bcma_drv_pci *pc);
> +#endif /* CONFIG_BCMA_PCICORE_HOSTMODE */

I don't know if I'm overreacting, but I really don't like naming mess
in the ssb.

Why don't you use bcma_core_pci_* to be consistent?

-- 
Rafał
