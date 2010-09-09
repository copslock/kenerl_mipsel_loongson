Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2010 14:39:43 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:62195 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491026Ab0IIMjj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Sep 2010 14:39:39 +0200
Received: by vws11 with SMTP id 11so1366501vws.36
        for <multiple recipients>; Thu, 09 Sep 2010 05:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C99ma2XRo3DimD789TGakcCo2S3orvkvNWsD4/LyiEM=;
        b=KJULi9Q3mQ9ghwbup+xvpfthe1YTtYSZjN1geTpjCm8+DirkbungdUZU8PfnxZaA0Q
         uv41Aa8XmtX1Pty5LmyrkfW/UYPCAoBoID/rk4q21fmrTC0LdZzdoE3NUkikKzae/AeQ
         EwY+Dnnql84YULxoupF3xpEkiclvHpr7Spn4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SRLKX9+jxvO57eKhXyMUQ9EWjepHhbPIlqO9xfir6bBYnNxM7Ca114NR9booTlurFq
         vhyfLXONa9lQsqxUA9dpasH01uIujTlRoUVgtvXeDZNssaP8ZnIo8xx3hG9q9li8ScVD
         yU67PvJGaVUo4GRyEYojbK2DYHtqZBelScW0w=
MIME-Version: 1.0
Received: by 10.220.75.200 with SMTP id z8mr175377vcj.57.1284035972952; Thu,
 09 Sep 2010 05:39:32 -0700 (PDT)
Received: by 10.220.114.141 with HTTP; Thu, 9 Sep 2010 05:39:32 -0700 (PDT)
In-Reply-To: <4C88AA27.5070206@mvista.com>
References: <064bb0722da5d8c271c2bd9fe0a521cc@localhost>
        <99a0868bdbcfa8785a92b4af4f6d9b99@localhost>
        <4C88AA27.5070206@mvista.com>
Date:   Thu, 9 Sep 2010 05:39:32 -0700
Message-ID: <AANLkTinAhsetaV2F8SfBZE_BtaMhhmJO2fEwL+LJpZxB@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: DMA: Add plat_extra_sync_for_cpu()
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 27736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7219

On Thu, Sep 9, 2010 at 2:34 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
>> +static inline void plat_extra_sync_for_cpu(struct device *dev,
>> +       dma_addr_t dma_handle, unsigned long offset, size_t size,
>> +       enum dma_data_direction direction)
>> +{
>> +       return;
>
>   Why not just empty function bodies?

For consistency with plat_extra_sync_for_device().
