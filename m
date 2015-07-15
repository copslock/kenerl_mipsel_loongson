Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 21:57:03 +0200 (CEST)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36630 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011255AbbGOT5BzoySF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 21:57:01 +0200
Received: by igbij6 with SMTP id ij6so80184175igb.1
        for <linux-mips@linux-mips.org>; Wed, 15 Jul 2015 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=J+O9vqhhi77FYk+YlP1R8Wfl7gQPvn/MnDL12Hup8Q4=;
        b=gGI7rK5bp7yH931kn8/sZsAoXBYkl+cXwmGPybHNv7BuViGcTjgRlsHsFDTZi25kD/
         PEstp3Df1Vh+9C28MmGDNxGl/tSP6ytXcDYPtkipVUy1MjAE0Ggqaz4G3pwkjexGwsMq
         bxmehmRtOo2eRuFEwjEACZaE2wTU4TcrsnuPsIkgt+tLlVguat3dOUryIJkVzQOQSFk/
         wz09XZHasXdMcG/D/s4Fk5NMVXHUYPY83Z1Vrg9m2BSZ0vKVBn2cngbGNyrTgka95yPQ
         sDEK/dUoR//Vso7WKv8gruXYxm+cJlkilDXW+mnWlQq1fRZ0sAsht4NOhSY9Wrvo/mOx
         /W8g==
MIME-Version: 1.0
X-Received: by 10.50.64.244 with SMTP id r20mr28981378igs.33.1436990215875;
 Wed, 15 Jul 2015 12:56:55 -0700 (PDT)
Received: by 10.36.110.138 with HTTP; Wed, 15 Jul 2015 12:56:55 -0700 (PDT)
In-Reply-To: <55A613C6.3040505@imgtec.com>
References: <CAAA5faEN3MmWACoT2g2+9aOj1C=vj7UcNxd3Lez_K4_sCS8jBQ@mail.gmail.com>
        <55A613C6.3040505@imgtec.com>
Date:   Wed, 15 Jul 2015 13:56:55 -0600
Message-ID: <CAAA5faHubPyT8D+QYB_M+qyCo-rRzPDO3fSH1HtSXCfCTj40HA@mail.gmail.com>
Subject: Re: compile failure linux 3.10 with gcc 4.9.3 for mips
From:   Reinoud Koornstra <reinoudkoornstra@gmail.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <reinoudkoornstra@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: reinoudkoornstra@gmail.com
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

Thanks for your answer.
Is this patch going in upstream
Thanks,

Reinoud

On Wed, Jul 15, 2015 at 2:03 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> On 07/14/2015 07:04 PM, Reinoud Koornstra wrote:
>> Hi Everyone,
>>
>> Did anybody enounter the following compiler problem with linux 3.10.81?
>> gcc version is 4.9.3 for mips and binutils 2.25
>>
>> arch/mips/kernel/r4k_fpu.S: Assembler messages:
>> arch/mips/kernel/r4k_fpu.S:59: Error: opcode not supported on this
>> processor: mips3 (mips3) `sdc1 $f0,272+0($4)'
>
> I think this is a known bug and it needs a backport of
>
> https://patchwork.linux-mips.org/patch/8355/
>
> --
> markos
>
