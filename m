Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 23:59:51 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:51162 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990435AbeAJW7mdGJSI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 23:59:42 +0100
Date:   Wed, 10 Jan 2018 23:59:31 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v6 15/15] MIPS: ingenic: Initial GCW Zero support
To:     Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Message-Id: <1515625171.19070.0@smtp.crapouillou.net>
In-Reply-To: <CAOFm3uHr0a5Poz+PKUC=KpjTcowZUGr6pSxgPN+j8URr=Nu3pA@mail.gmail.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
        <20180105182513.16248-1-paul@crapouillou.net>
        <20180105182513.16248-16-paul@crapouillou.net>
        <CAOFm3uHr0a5Poz+PKUC=KpjTcowZUGr6pSxgPN+j8URr=Nu3pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1515625180; bh=5hZsFaZvC68+DW9zn5Ha2enx9zKBqOLuBOg/08j7+Oc=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ZauQ7Sv8DKs6rQsHCP/g0hrH2OaukUtt2q2OMw8YYGJ6+jiEfteHZuZb9MSlfLvg8tC+7XECd8bNbBpG/tu5zdAYMHVoR0rV/5gWVjEu4NhvtyiTAmdeuTidw088l8IXyx3IzGEKNO8x7lCeLPSeGdQFIWps+ZmzRjnCbjRR0tA=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi Philippe,

Le dim. 7 janv. 2018 à 17:18, Philippe Ombredanne 
<pombredanne@nexb.com> a écrit :
> On Fri, Jan 5, 2018 at 7:25 PM, Paul Cercueil <paul@crapouillou.net> 
> wrote:
>>  The GCW Zero (http://www.gcw-zero.com) is a retro-gaming focused
>>  handheld game console, successfully kickstarted in ~2012, running 
>> Linux.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Acked-by: Mathieu Malaterre <malat@debian.org>
>>  ---
>>   arch/mips/boot/dts/ingenic/Makefile |  1 +
>>   arch/mips/boot/dts/ingenic/gcw0.dts | 62 
>> +++++++++++++++++++++++++++++++++++++
>>   arch/mips/configs/gcw0_defconfig    | 27 ++++++++++++++++
>>   arch/mips/jz4740/Kconfig            |  4 +++
>>   4 files changed, 94 insertions(+)
>>   create mode 100644 arch/mips/boot/dts/ingenic/gcw0.dts
>>   create mode 100644 arch/mips/configs/gcw0_defconfig
>> 
>>   v2: No change
>>   v3: No change
>>   v4: No change
>>   v5: Use SPDX license identifier
>>       Drop custom CROSS_COMPILE from defconfig
>>   v6: Add "model" property in devicetree
> 
> For the use of SPDX tags for the whole patch set: thank you!
> 
> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

Is your Acked-by for the whole patchset? Or just this one patch?

-Paul
