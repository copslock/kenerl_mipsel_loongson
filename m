Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 05:15:40 +0200 (CEST)
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34287 "EHLO
        mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009242AbbHDDPh2b1DI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2015 05:15:37 +0200
Received: by ykax123 with SMTP id x123so127719642yka.1;
        Mon, 03 Aug 2015 20:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+EtdHWkxyHou8AgnEf4wWKvdmb0WynUxLfqhRMvlQ58=;
        b=bJeMaSWUa8j4y/fEsGyMnO5hAwT72dRVRzSwsNQ57KvcCjBSF3xNpbabrwFndbe8YG
         k87mCJxH1DTv8wX3oFrORtVc6bg/YtNMctSH5jHhW6E8zGEZ0I0lAk5IfO6Ngz/L+Obt
         yaFNMlC1lpQK3yYniWkTvEB8zGWVyCXe3rPnuHFRQfM5AkpWgUNYmLb3kxhMbxf2JGIL
         XyB6YlvVYx0n2jKxFzmKirb7C8QzokQ7DwgMaL58B6WZ6dDjdlAwxk6Q8jn416A2H3Qx
         Buy9eXZwo0twXj1Ny8zerD/K5ZBTgOfOwV2LHa4K5zbP32looQVqHfX0biqpv3NU2Dls
         vmWw==
MIME-Version: 1.0
X-Received: by 10.170.210.212 with SMTP id b203mr1415488ykf.110.1438658131653;
 Mon, 03 Aug 2015 20:15:31 -0700 (PDT)
Received: by 10.37.208.80 with HTTP; Mon, 3 Aug 2015 20:15:31 -0700 (PDT)
In-Reply-To: <20150803152107.GE2843@linux-mips.org>
References: <1434537166-5385-1-git-send-email-zhoubb@lemote.com>
        <1434537166-5385-4-git-send-email-zhoubb@lemote.com>
        <20150803152107.GE2843@linux-mips.org>
Date:   Tue, 4 Aug 2015 11:15:31 +0800
X-Google-Sender-Auth: 8_9ADh3n7ZFaMpufb3WAoK64PAQ
Message-ID: <CAAhV-H74JnPwDTZ4iBsrLPQwopyGQ0f9nYS3BrfrRAmGwSacEQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] MIPS: Loongson: Add platform devices for Loongson-1A/1B
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Binbin Zhou <zhoubb@lemote.com>, John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Chunbo Cui <cuicb@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Unforunately, Loongson doesn't support device-tree now.

Huacai

On Mon, Aug 3, 2015 at 11:21 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Jun 17, 2015 at 06:32:41PM +0800, Binbin Zhou wrote:
>
>>  arch/mips/loongson32/common/platform.c            | 290 +++++++++++++++++++++-
>
> Another lengthy platform.c file.  Have you considered putting that
> information into a DT instead?
>
>   Ralf
>
