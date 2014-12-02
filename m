Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2014 15:16:19 +0100 (CET)
Received: from mail-yh0-f48.google.com ([209.85.213.48]:49637 "EHLO
        mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006733AbaLBOQRbyd2d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Dec 2014 15:16:17 +0100
Received: by mail-yh0-f48.google.com with SMTP id i57so5932638yha.7
        for <multiple recipients>; Tue, 02 Dec 2014 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=13FcmuSXHJQAXtqaU08x3VoR0WJS0jYzYXW8elWH5PQ=;
        b=rpKDqi45efyRLdOn2xJsvGTZmkSGOD3u6N9BOMH8VQGNjMhEFBbA4k01au2jc6PlKU
         fZgLCAdtqEI3IcTyPIcZsHbCzXRryjCiO1NRkbexAghASdp9W1EFQezGUQ3ml9T9dVRV
         256Tgeg5ONtX1nrCc78s9DiQZQhtAHzjuroypIZyR7do3V3VWXToBNrlJoIlj+jLOMZu
         CUWimbOkCndD6N+1fe/12CogwIvNxewiX+at+e4vfe0JrLJlggIklxk0UUHRJjfPDMeT
         7bcN3qnrv4Yye7nd12FogwKBP1ZgiqTsPnL5ItlbPuEINYOxlr8Ibl6jwJdCSWw0uBM4
         v6Sw==
X-Received: by 10.236.222.198 with SMTP id t66mr64640886yhp.125.1417529771555;
 Tue, 02 Dec 2014 06:16:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.170.190.86 with HTTP; Tue, 2 Dec 2014 06:15:51 -0800 (PST)
In-Reply-To: <1409364388-7108-6-git-send-email-ryazanov.s.a@gmail.com>
References: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com> <1409364388-7108-6-git-send-email-ryazanov.s.a@gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 2 Dec 2014 18:15:51 +0400
Message-ID: <CAHNKnsR-GhhxOA9wrnfK8xUFhVdfVxZbcUmMbyjHfuBTffOKDQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] MIPS: make PCI_DMA_BUS_IS_PHYS=1 constant
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-08-30 6:06 GMT+04:00 Sergey Ryazanov <ryazanov.s.a@gmail.com>:
> No one of supported MIPS machines has an IOMMU unit, so we can safely define
> PCI_DMA_BUS_IS_PHYS = 1. Also remove iommu flag from the pci controller
> structure, since it is useless.
>
Ralf, do you have some issue with this patch? Should I resend it?

-- 
BR,
Sergey
