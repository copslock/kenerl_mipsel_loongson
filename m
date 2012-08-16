Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 02:39:53 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61607 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903484Ab2HPAjq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2012 02:39:46 +0200
Received: by lbbgf7 with SMTP id gf7so1114066lbb.36
        for <multiple recipients>; Wed, 15 Aug 2012 17:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IMFt08BmZSF90uBH4kvUKoq8ik6HUOlhfEJuNoeY+Ng=;
        b=Q4XtrKWIsZ4dCvMA7GJHxJ9RfgWF1K/EY1Aqt3xIah2ljYvzAxXFj/Llqi0V5o/kBx
         DaNDg0boqVeyIiicxP1AylnXAcBg6pgbmn3H+3s/KPjBnAgas31mNqJQvXMtMKUhHxke
         Do4ij7XhfTzACeiQTh9rfmBusLrZIixN958BdSaM2LCigqg5/y8B2K+C4FR7WRLwdvQn
         PIkbYaHVXAd+T76f/eTgkQeedu2qsrfY980i8+r1SisiMFvaGcxrMxHqJxIQiZ2/TN+Y
         3Pv0ARgsB8HGW2OADvAKeGyvFCuCWIFIT0+dzDEbUc4QkzOsNXi1PJJXZa/sQUXT6Af1
         XMAA==
MIME-Version: 1.0
Received: by 10.152.113.68 with SMTP id iw4mr20947089lab.50.1345077580945;
 Wed, 15 Aug 2012 17:39:40 -0700 (PDT)
Received: by 10.152.111.138 with HTTP; Wed, 15 Aug 2012 17:39:40 -0700 (PDT)
In-Reply-To: <20120815193617.GA15844@linux-mips.org>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
        <1344677543-22591-2-git-send-email-chenhc@lemote.com>
        <50274467.90509@phrozen.org>
        <20120815193617.GA15844@linux-mips.org>
Date:   Thu, 16 Aug 2012 08:39:40 +0800
Message-ID: <CAAhV-H4ZHB2CztNuFvvyaU5kMNeU6i38NJZMrugKXf7+rdv-Tg@mail.gmail.com>
Subject: Re: [PATCH V5 01/18] MIPS: Loongson: Add basic Loongson-3 definition.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

OK, I'm reworking the patch series.

On Thu, Aug 16, 2012 at 3:36 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sun, Aug 12, 2012 at 07:51:35AM +0200, John Crispin wrote:
>
>> On 11/08/12 11:32, Huacai Chen wrote:
>> >  #define PRID_IMP_LOONGSON2 0x6300
>> > +#define PRID_IMP_LOONGSON3 0x6300
>> >
>>
>> as PRID_IMP_LOONGSON2 and PRID_IMP_LOONGSON3 share the same value, its
>> not really a uniq ID anymore. Maybe change this to a common PRID ?
>>
>> patch 2/18 does not even make use of this new symbol inside
>> arch/mips/kernel/cpu-probe.c
>
> PRID_IMP_LOONGSON3 is not even being used in the series.  If it was, it'd
> cause a duplicate case label in the usual switch construction in
> cpu_probe_legacy().
>
> Huacai, can you please resend with this symbol removed?  Thanks.
>
>   Ralf
>
