Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Feb 2015 02:29:25 +0100 (CET)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:45225 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007598AbbB1B3Wexms2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Feb 2015 02:29:22 +0100
Received: by iecat20 with SMTP id at20so35444396iec.12
        for <linux-mips@linux-mips.org>; Fri, 27 Feb 2015 17:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IzqMcpv6rIRkQsEVKb/ZoE2eOuJcnUwHQn3JvzrgbMo=;
        b=lHzTcu5PoPjO/WSfao8ujq1S9L7s9XuxpB5MMz25d/JdO5HkeHsOLU5lB5Gxryr3FE
         Z63k4p1irfL2l1w5QwowrMZ1rnjYMjPfjTY8+Wxc+p6/uEJXKkn/9+Omp05EHs9PC9W2
         +MeGqsyTMsl/Fbc8j9vafzc60hD1WCJAzxzNxaN8Wo+PwEV+vWF9h+xIiKz/w5193pb0
         SZzXTgzLPc8p2EdJmspnQQVghgWr/Aof/XfTG8Ryo9FpDAN67/ZfvBw+Xfmu+i/gisSB
         zKUeGczP+ktot385viOpBmVP0LIAGcXmvHHX6yhn90718URqe3ZNCDi88ObL2WihrFnU
         oVPA==
MIME-Version: 1.0
X-Received: by 10.107.47.216 with SMTP id v85mr22300713iov.86.1425086957098;
 Fri, 27 Feb 2015 17:29:17 -0800 (PST)
Received: by 10.64.176.238 with HTTP; Fri, 27 Feb 2015 17:29:17 -0800 (PST)
In-Reply-To: <20150227203159.GS29461@vapier>
References: <20150219194617.GT544@vapier>
        <CAAhV-H5+kQm_qAz7DLV4Rk9EqB4xJjmu1NV7kKd46aneKFZO-A@mail.gmail.com>
        <20150226081425.GR6655@vapier>
        <CAAhV-H7vm61G1TP53GpskhLxC6LFEUkhiVzTFDRTiXSt9-zuvg@mail.gmail.com>
        <20150227203159.GS29461@vapier>
Date:   Sat, 28 Feb 2015 09:29:17 +0800
Message-ID: <CAAhV-H7fuVu5uVj7K9hTxjr-eFQGRzaqvGYYdqUecn6F4guK8A@mail.gmail.com>
Subject: Re: custom kernel on lemote-3a-itx (Loongson-3A) crashes in userspace
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46055
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

We also built good kernels on N32 Arch-Linux. You can get the source
of GCC/Binutils here:
http://mirror.lemote.com/archls/sources/core/

Huacai

On Sat, Feb 28, 2015 at 4:31 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On 27 Feb 2015 21:37, Huacai Chen wrote:
>> We have also built good kernels with native GCC-4.6.4/4.7.2/4.8.3 (o32
>> binaries).
>
> do you have the source for those versions available ?  that way i can see if
> there's any patches we should pick up in Gentoo for mips.
>
>> So maybe this is an N32-related problems.
>
> that would not surprise me :).  we like to push the envelope in Gentoo.
> -mike
