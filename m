Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 16:33:11 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:54327 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491928Ab0EXOdI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 May 2010 16:33:08 +0200
Received: by fxm15 with SMTP id 15so2549913fxm.36
        for <linux-mips@linux-mips.org>; Mon, 24 May 2010 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=1czh2wJ0ryXYsWb2QkrRQ/XppSQo2Zj+XjMJ5xKYrxM=;
        b=kNtvLYgALRhLkr+il+bY1CmLq5VnhwIrQTB0GVvYZksFn82kwbG7Of7KGQs6hu3kq7
         M+0ppk17yOoqsVTb8WyN9v5bsdgrLjbRhXTcMzbEdpEDazx6yaeFVi4Mus6Hj1727C4r
         rsZSwKb23wIX/egDU4+iK6bVU4ugtO1FRF+Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=L6RKDW0A183ZNp9hGtkiFn7v+FaGVjB9QHPJs8sNGtjO/JyIXdmAwNyKFjQvZFR+7Q
         tyql4k+91iNlNx4aapYEnzSfWWvvssjRrDryl27UbD3HgFksW3x3C2A/i37hf7hIvDIH
         jYjBJVGabpJI2ccIVbWBVNe1Zv91nkCB98pqA=
MIME-Version: 1.0
Received: by 10.223.68.131 with SMTP id v3mr4677624fai.82.1274711581716; Mon, 
        24 May 2010 07:33:01 -0700 (PDT)
Received: by 10.223.104.209 with HTTP; Mon, 24 May 2010 07:33:01 -0700 (PDT)
In-Reply-To: <1274711094.4bfa8c3675983@www.inmano.com>
References: <1274711094.4bfa8c3675983@www.inmano.com>
Date:   Mon, 24 May 2010 17:33:01 +0300
Message-ID: <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>
Subject: Re: Cross compiling MIPS kernel under x86
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     octane indice <octane@alinto.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, May 24, 2010 at 5:24 PM, octane indice <octane@alinto.com> wrote:
>
> Hello
>
> I have an octeon board. I'm trying to use a custom kernel from kernel.org
> instead of the Cavium one.
>

[skipped]

>
> So, I'm obviously missing a thing, but what?

It looks like your toolchain is quite old. I just tried building a
Cavium Octeon defconfig using my custom toolchain based on GCC 4.3.1
and binutils 2.19.51.20090304, and the build was successfull. Before
you ask: yes, GCC did receive `-march=octeon' :)

Dmitri
