Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 12:30:58 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:39321 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1FFKaz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 12:30:55 +0200
Received: by qwi2 with SMTP id 2so2060473qwi.36
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pcMMdg0LSRQ33MJb9iCduXTENE8D3psZWZN0JJDtVlM=;
        b=wgdoAXYGGOhyiiavE/mDMGeZE0QI/3evr6FT+AD0CGfQEq/tcNijsCGpRjBxovvHk4
         LSVxSaH1FW3exRh55H8knv2YsVLZqvtA4bnrfT9hERd174QYbYPuOh4zTc/fOlHqUzmJ
         tpb3Wm+CyJ3rCZEmbLQaGG4ToH6tvNe0JPSv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hdErGTt5yMSljZVtAVBDqSo77sY0ZK4cPhu1s4hSI3/YccXRVx2qod9CnYSLVqLhVD
         WUPA0LX19/qkdLeOQrzKM3kZAEgJ4EbCPZ+ASv4Y91b/BKV1vT5d8ZU8p4Wq4p8X49bJ
         eS+AjBBoxcbEWHltUJF3J6q+mHki519Qnbs2k=
MIME-Version: 1.0
Received: by 10.229.35.1 with SMTP id n1mr3387354qcd.84.1307356249456; Mon, 06
 Jun 2011 03:30:49 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 03:30:49 -0700 (PDT)
In-Reply-To: <1307311658-15853-6-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-6-git-send-email-hauke@hauke-m.de>
Date:   Mon, 6 Jun 2011 12:30:49 +0200
Message-ID: <BANLkTik9u5QhxdeaGMUyYYK-W8hSkQb-Wg@mail.gmail.com>
Subject: Re: [RFC][PATCH 05/10] bcma: add serial console support
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4079

2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
> +       if ((ccrev >= 11) && (ccrev != 15) && (ccrev != 20)) {
> +       ....
> +       } else
> +               pr_err("serial not supported on this device ccrev: 0x%x\n",
> +                      ccrev);

Please use scripts/checkpatch* for your patches. I believe it will
alert you about lacking brackets for "else" (kernel coding style).

-- 
Rafał
