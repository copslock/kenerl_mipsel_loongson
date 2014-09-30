Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 16:31:24 +0200 (CEST)
Received: from mail-we0-f169.google.com ([74.125.82.169]:32982 "EHLO
        mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010180AbaI3ObUhCY7g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 16:31:20 +0200
Received: by mail-we0-f169.google.com with SMTP id w61so2418399wes.14
        for <multiple recipients>; Tue, 30 Sep 2014 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=zQgCmgGUM/wn+eqSNcSjOS4foxO2YGaphqXarXY5WcQ=;
        b=EyUuRR83iHx2WofCrjkUTIBYi9RQU9bUT9H9um0FVJen/S7ucwNzq3bKIYyxTUrwtN
         sk+D8Yk579BXu2+lzNCep9+5A44Uw+UEU8ElsThdqFlnz5+y0pHboM1NtIQJAsXSZhof
         lW8vigBPCBEfOfqBtiLyGvLUL6Nl8dC9T7iveOrkQkDYHqAuZq+M5G6A1Uuuo/hXu9g1
         83bMvIY4ObModpUgz4tX/IbRvAGtBlJLXvckSae4Uju9ADwOU07+Ea0X0oEfkdAlJgq2
         nNvJUIb3BaKb/3+dBEf2WVoDa7hFIfgXK8E63yRz+bvBgA7prrJKamUjaDKD0eHZsSgg
         M3pg==
X-Received: by 10.180.89.230 with SMTP id br6mr6515747wib.16.1412087475357;
        Tue, 30 Sep 2014 07:31:15 -0700 (PDT)
Received: from [10.24.135.53] ([160.92.7.69])
        by mx.google.com with ESMTPSA id mz16sm15364481wic.13.2014.09.30.07.31.13
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 07:31:14 -0700 (PDT)
Message-ID: <1412087471.10205.12.camel@L80496>
Subject: Re: [PATCH] tc: fix warning and coding style
From:   Thibaut Robert <thibaut.robert@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 30 Sep 2014 16:31:11 +0200
In-Reply-To: <CAMuHMdWHMK7NxX9AUg3ihwds41dKW26A_jFnZELw5N9shMaBKw@mail.gmail.com>
References: <1412079396-26005-1-git-send-email-thibaut.robert@gmail.com>
         <CAMuHMdXj=b0G7foTRkcEtRC_De8+WjVefxBfW=s1sjaXLeF5nQ@mail.gmail.com>
         <1412085083.10205.8.camel@L80496>
         <CAMuHMdWHMK7NxX9AUg3ihwds41dKW26A_jFnZELw5N9shMaBKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <thibaut.robert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thibaut.robert@gmail.com
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

Le mardi 30 septembre 2014 à 16:08 +0200, Geert Uytterhoeven a écrit :
> I guess that's acceptable, as tc is probably limited to 32-bit anyway. Maciej?
> 
> Note that there's also %pa, for phys_addr_t/resource_size_t.
Yes, but unfortunately that needs a reference so we can't use it.

Thibaut
