Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2014 05:57:40 +0200 (CEST)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:51883 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821703AbaHTD5aCeOnO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Aug 2014 05:57:30 +0200
Received: by mail-ig0-f169.google.com with SMTP id r2so10623502igi.2
        for <multiple recipients>; Tue, 19 Aug 2014 20:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MRmOwYbtvJ9Myq5Ifq97LQAzUIgeCSLU2PvddfILUKk=;
        b=wcvgmEG4gk71dlmLuIPJkddTb3jhYQQ0d9stJusGvQ6ASJMAjs/U6EFtGiuT0+rNV7
         6mQF1+vkI03cgT+BBCAMFs6MOT2mapLg0Uv3EZFDfd5/zu8gmfDuocK8TTvTEa2nwDXi
         pvzMhfDqC1pjjpRXeKBgmpZPzyw4irkc4dpe6jFp0aIU4g+IThXF4EcsGOkQKlaRAlkV
         tzABSv15Asnp1MyB37xsFluLTnNnKq/T/Sv1wrv5L6zgve17/IcYJ6ZaZYKU3tGFZ9il
         yFceZi4CQ/uKW1zNOx1pDFx3e6K3/gseEsQUkIXdz50ecSs853CJtuAUTmXngYqMEIrp
         +v8Q==
MIME-Version: 1.0
X-Received: by 10.50.78.167 with SMTP id c7mr10186344igx.6.1408507042740; Tue,
 19 Aug 2014 20:57:22 -0700 (PDT)
Received: by 10.64.241.5 with HTTP; Tue, 19 Aug 2014 20:57:22 -0700 (PDT)
In-Reply-To: <20140813001849.GA27602@jayachandranc.netlogicmicro.com>
References: <1407467768-24097-1-git-send-email-chenhc@lemote.com>
        <20140808134738.GG29898@linux-mips.org>
        <20140813001849.GA27602@jayachandranc.netlogicmicro.com>
Date:   Wed, 20 Aug 2014 11:57:22 +0800
X-Google-Sender-Auth: CZyeWL-BalYq93mWdLuOaqRWKrU
Message-ID: <CAAhV-H7x3FDAXYcH6J8mDeBnrgV1CZZtizerjHRa4cj_oZ1PuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Move CPU topology macros to topology.h
From:   Huacai Chen <chenhc@lemote.com>
To:     "Jayachandran C." <jchandra@broadcom.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42158
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

Hi, Ralf,

Why this patch hasn't applied?

Huacai

On Wed, Aug 13, 2014 at 8:18 AM, Jayachandran C. <jchandra@broadcom.com> wrote:
> On Fri, Aug 08, 2014 at 03:47:38PM +0200, Ralf Baechle wrote:
>> Jayachandran,
>>
>> could you convert the netlogic platforms to use this scheme, too?
>> We then could drop the #ifdefs introduced by this patch.
>
> The same sequence is used by ip27 platform as well, so I think the
> ifndef may still be needed. This is the same ifndef pattern we use
> for all our mach-generic/*.h vs. mach-<platform>/*.h
>
> On second thought, I am not sure if the changes in Huacai's patch
> has to be in asm/topology.h, probably this has to be in
> mach-generic/topology.h
>
> JC.
>
