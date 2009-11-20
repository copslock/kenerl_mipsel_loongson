Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 03:18:00 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:54873 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494102AbZKTCRy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2009 03:17:54 +0100
Received: by ywh3 with SMTP id 3so2986789ywh.22
        for <multiple recipients>; Thu, 19 Nov 2009 18:17:47 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=yXmLiObW3VQt/O1plf8faFneIhlXfd3Pi0MySrYFG0U=;
        b=FyWetN/t+T2m302QPX2TmqgvTw3uevp1TB/QrqUGxswp5BUt0dC2zQ0iJVGDnddCMh
         +rk8hgzcOjPhdYM/ery9abSqZWUhnFvPG+wfsCuSOUhnTwADjlnr/DTSZuKoQwzjC4XA
         e07Vsr8fGfRAE5KH0uJD3cE2iz3pGD/IV5E6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=k9NDFDHmF6hfkfoTQ9nr2HapoYBcPiqcM6Cb+WdCoT2BOIOHPo41B4jut5veL/Wfp5
         tL50MXZFu36Mv6+X8h0QA1j6bZ2zOZHzfclONhFl8pWRpsPEtEugh/JNeEBf/abXzqjC
         CUt6eY9m4s3jkVUmHovzavCr2XjwlV7bnkEw4=
Received: by 10.150.5.35 with SMTP id 35mr1552733ybe.84.1258683467887;
        Thu, 19 Nov 2009 18:17:47 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 9sm403604ywf.35.2009.11.19.18.17.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 18:17:47 -0800 (PST)
Subject: Re: [PATCH -next] drivers/staging/sm7xx: add a new framebuffer
 driver
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Greg Kroah-Hartman <gregkh@suse.de>
Cc:	Ralf Baechle <ralf@linux-mips.org>, devel@driverdev.osuosl.org,
	linux-mips@linux-mips.org,
	Teddy Wang <teddy.wang@siliconmotion.com.cn>, huhb@lemote.com,
	yanh@lemote.com
In-Reply-To: <1257673141-1646-1-git-send-email-wuzhangjin@gmail.com>
References: <1257673141-1646-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 20 Nov 2009 10:17:33 +0800
Message-ID: <1258683453.2862.35.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-11-08 at 17:39 +0800, Wu wrote:
[...]
> +/* Jason (08/14/2009)
> + * suspend function, called when the suspend event is triggered
> + */
> +static int smtcfb_suspend(struct pci_dev *pdev, pm_message_t msg)
> +{

__maybe_unused is needed before smtcfb_suspend() to let gcc not complain
about "function defined but not used" when CONFIG_PM is disabled.

[...]
> +static int smtcfb_resume(struct pci_dev *pdev)
> +{

Here too.

> +static struct pci_driver smtcfb_driver = {
> +	.name = "smtcfb",
> +	.id_table = smtcfb_pci_table,
> +	.probe = smtcfb_pci_probe,
> +	.remove = __devexit_p(smtcfb_pci_remove),
> +#ifdef CONFIG_PM
> +	.suspend = smtcfb_suspend,
> +	.resume = smtcfb_resume,
> +#endif
> +};
> +

Best Regards,
	Wu Zhangjin
