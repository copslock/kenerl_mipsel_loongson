Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Apr 2014 21:10:40 +0200 (CEST)
Received: from mail-qc0-f176.google.com ([209.85.216.176]:36959 "EHLO
        mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816686AbaDETKjH40FA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Apr 2014 21:10:39 +0200
Received: by mail-qc0-f176.google.com with SMTP id m20so4828953qcx.21
        for <multiple recipients>; Sat, 05 Apr 2014 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=noBnwfrKg6VIi1YDBiIefMjtLx+eTnpaacJhZSqGin4=;
        b=e06dr76RITPC97Swg6YUKmTsPeNTWLDONnBJZU7rkv94J13fBMOcBkjchUBpx/xj/T
         itEDCdA0wWWxaHhGsz/ng8V4HJDhNP7cp2wGgsKS0Yh5CH3gvlNriV1A0c4hjXiGAGbQ
         dQvDKlTR9VXlEgrEStPQ3nbPUhLywuwgC+TJEYEl0uEfS/XS5cdH+yjS6qMfbmmeFaYf
         Veicei/fsFklCDIbP5c/M5U9prHWJEvKDrlJdchjhZQV+NinnBnK93OkqmFxDhyNBGzw
         PVmdtUxI2I8uEkNBe8QQr2ZPEEBlgZoKQRyuwBn/OOLSUsqsZCY2VBVhywUUjUQgTZMc
         UWHg==
X-Received: by 10.140.29.131 with SMTP id b3mr21624310qgb.5.1396725032802;
 Sat, 05 Apr 2014 12:10:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.207.65 with HTTP; Sat, 5 Apr 2014 12:10:12 -0700 (PDT)
In-Reply-To: <20140404084805.GA7558@drone.musicnaut.iki.fi>
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
 <1396599104-24370-8-git-send-email-chenhc@lemote.com> <20140404084805.GA7558@drone.musicnaut.iki.fi>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 5 Apr 2014 12:10:12 -0700
Message-ID: <CAEdQ38HvPBRqdTkWx9zR9v8wqGSF=LwKiot3DpCY91vCHnpjLg@mail.gmail.com>
Subject: Re: [PATCH 7/9] MIPS: Loongson: Make CPU name more clear
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Fri, Apr 4, 2014 at 1:48 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Fri, Apr 04, 2014 at 04:11:42PM +0800, Huacai Chen wrote:
>> Make names in /proc/cpuinfo more human-readable, Since GCC support the
>> new-style names for a long time, this may not break -march=native any
>> more.
>
> NACK. There isn't a GCC release available yet that supports
> new Loongson 2 names. You need to wait until such release is made
> and everyone starts using it. That will take maybe 5-10 years.

It seems like he could, however, modify the names such that they
allowed new gcc to differentiate between them if old gcc could still
recognize them.
