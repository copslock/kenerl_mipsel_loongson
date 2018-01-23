Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2018 11:32:01 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:39964
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992368AbeAWKbxNeppI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Jan 2018 11:31:53 +0100
Received: by mail-wm0-x241.google.com with SMTP id v123so826009wmd.5
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2018 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a8a/L8JpJXxaMsDvU4MFqrZ8G6ZY3iCey6HvDquiYLo=;
        b=Olvp5qlmCYQ5EszwZNwxnKEVWXalzbWn2Vul1dGKQFZMDC2DEVWJ1GKh7+TZnbxdG9
         NmXP3AUX89jV1S2pb4AR6HCtZeKFoNdURXNGEQLYpMwal06NCkUFG+dlTZIzR2ooz4nD
         kvjmtOeJscEIKFvJ5s/+kXq29adS42OnbCf9L5OTRGo0JLnvj3LIKPlWiWMNp4joysAK
         BX+Q+9Ukr6GtyjNau4n+d6U4L2CmJld5UmUPkFUx3eBKwMHmwCSIOoWtxHXJYaG0YITJ
         CQNXur4uNUv1mlxU5qVaSYqB18fSSjddoaKdBATz31oknqTdyp80aXX196dj7v4Gsryb
         mLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a8a/L8JpJXxaMsDvU4MFqrZ8G6ZY3iCey6HvDquiYLo=;
        b=If9XdM4Q6XCbcck9SQd3+EC7/6A1Q0z3frda6PYYDLSNq+TC7sCGdaEtpdfNHEm389
         X6uCB7WK8QvHsmENSJEY16huP81IuFq7G1uI9tCmUuZi36/f8kLQg2FPDDVmQ0NegrBx
         5ly8a40RGwq5Nrg48qc8TtFsCZUgA8Sm1jhFerB7M4hKBK9ZTflNoTUshysf0r/JsGgc
         dbvFkO3qLpvPViRJyAgcqUdq3SAwlD/H2ZrdTN3M2siuAYCxtCZxG8HKbN6J8q2+/7aM
         3SncHP6W2BElQ1cbwCPioz8HLVN+EbFjGV8I/+LLdxCVE6+fmaw+cC51KHbsgZcQ8AW9
         h/PQ==
X-Gm-Message-State: AKwxytc/NtH829aFKT1HzVwOJtTXMM/rmoaBcfwyAj60ULyhsQw5jdk0
        jpxW9ugVpmBPCLqOT1tLoQAPUTxNx5V5UAJpmpz57A==
X-Google-Smtp-Source: AH8x226yxQlZbu1dH5cVFjSrhAZTb++yt6EOy/To1HGcF0wLu17kDsfZHgxc4pylBQKdE2GBLyS72vaU5oQCA6C6hRU=
X-Received: by 10.28.84.14 with SMTP id i14mr1325888wmb.30.1516703507773; Tue,
 23 Jan 2018 02:31:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.175.81 with HTTP; Tue, 23 Jan 2018 02:31:07 -0800 (PST)
In-Reply-To: <1515625171.19070.0@smtp.crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net> <20180105182513.16248-1-paul@crapouillou.net>
 <20180105182513.16248-16-paul@crapouillou.net> <CAOFm3uHr0a5Poz+PKUC=KpjTcowZUGr6pSxgPN+j8URr=Nu3pA@mail.gmail.com>
 <1515625171.19070.0@smtp.crapouillou.net>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Tue, 23 Jan 2018 11:31:07 +0100
Message-ID: <CAOFm3uG0_YHgEMFKJaa+EPcDbnDafo-LJfJKM3SxY0Km7-hOHA@mail.gmail.com>
Subject: Re: [PATCH v6 15/15] MIPS: ingenic: Initial GCW Zero support
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

Paul:

On Wed, Jan 10, 2018 at 11:59 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> Hi Philippe,
>
> Le dim. 7 janv. 2018 à 17:18, Philippe Ombredanne <pombredanne@nexb.com> a
> écrit :
>>
>> On Fri, Jan 5, 2018 at 7:25 PM, Paul Cercueil <paul@crapouillou.net>
>> wrote:
>>>
>>>  The GCW Zero (http://www.gcw-zero.com) is a retro-gaming focused
>>>  handheld game console, successfully kickstarted in ~2012, running Linux.
>>>
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  Acked-by: Mathieu Malaterre <malat@debian.org>
>>>  ---
>>>   arch/mips/boot/dts/ingenic/Makefile |  1 +
>>>   arch/mips/boot/dts/ingenic/gcw0.dts | 62
>>> +++++++++++++++++++++++++++++++++++++
>>>   arch/mips/configs/gcw0_defconfig    | 27 ++++++++++++++++
>>>   arch/mips/jz4740/Kconfig            |  4 +++
>>>   4 files changed, 94 insertions(+)
>>>   create mode 100644 arch/mips/boot/dts/ingenic/gcw0.dts
>>>   create mode 100644 arch/mips/configs/gcw0_defconfig
>>>
>>>   v2: No change
>>>   v3: No change
>>>   v4: No change
>>>   v5: Use SPDX license identifier
>>>       Drop custom CROSS_COMPILE from defconfig
>>>   v6: Add "model" property in devicetree
>>
>>
>> For the use of SPDX tags for the whole patch set: thank you!
>>
>> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
>
>
> Is your Acked-by for the whole patchset? Or just this one patch?

Sorry for the late reply!
This is  for the whole patchset for your use of SPDX tags.

-- 
Cordially
Philippe Ombredanne
