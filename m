Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2015 02:34:50 +0200 (CEST)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33191 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009471AbbDVAesN8H9J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2015 02:34:48 +0200
Received: by wiax7 with SMTP id x7so118581839wia.0;
        Tue, 21 Apr 2015 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Sa32blg0xiyhNHeg7rKKDI8q2Heldef8Isfa4m/MXRU=;
        b=DnzoTDBVaV5FkIh1wY7IkfkX+ghMI4SYdaRXO4FlxKHxfOjS2LMNq3OHxl9u7cy/Qa
         muwAUlJJ9xjTKzrYqEjExbdAdr7o4CICIWpUQT/SzSNhkoE65D+BaftY9E1zk7QWPf9s
         8uqOQzqT/4iyJMIRHCdmhAZPi+/OV2hg3x6x59DHYWcTSboxbswekhDSdxblE2o8Iycc
         ZZDbVuszReAe4j8HO//8sUtWMn6lQN8qFcRw9uQGh2NVZH/4sVw7Y1VmtDQZHB0eiAYV
         P8ysZyGiNuZgvh7baVTBpAG14QjZewmalkd+eQWPQXwfre+kZzBzC7isfmHIkEcBWTys
         QVYA==
MIME-Version: 1.0
X-Received: by 10.194.174.225 with SMTP id bv1mr46331994wjc.101.1429662884535;
 Tue, 21 Apr 2015 17:34:44 -0700 (PDT)
Received: by 10.28.62.131 with HTTP; Tue, 21 Apr 2015 17:34:44 -0700 (PDT)
In-Reply-To: <55361A86.9060000@imgtec.com>
References: <1429581635-26476-1-git-send-email-chenhc@lemote.com>
        <55361A86.9060000@imgtec.com>
Date:   Wed, 22 Apr 2015 08:34:44 +0800
X-Google-Sender-Auth: cl95rTPOIJeafnWPgWh0JMK-QGM
Message-ID: <CAAhV-H66XZB0Ytvc8mDQE6pqNmJsz4TY1zjh26Pp6rnSRU_Kcw@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: Loongson: Naming style cleanup and rework
From:   Huacai Chen <chenhc@lemote.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47002
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

Really? I have seen many patches with their changelog in commit messages.

Huacai

On Tue, Apr 21, 2015 at 5:38 PM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> Hi,
>
> On 04/21/2015 03:00 AM, Huacai Chen wrote:
>> Currently, code of Loongson-2/3 is under loongson directory and code of
>> Loongson-1 is under loongson1 directory. Besides, there are Kconfig
>> options such as MACH_LOONGSON and MACH_LOONGSON1. This naming style is
>> very ugly and confusing. Since Loongson-2/3 are both 64-bit general-
>> purpose CPU while Loongson-1 is 32-bit SoC, we rename both file names
>> and Kconfig symbols from loongson/loongson1 to loongson64/loongson32.
>>
>> V2: Update Kconfig description.
> This ^^^^ needs to be below the '---' part of the patch because it
> should not be part of the commit message. It is just a changelog for the
> patch itself.
>
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
> ^^^ Please add "V2:..." here instead.
>
> --
> markos
>
