Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2018 22:39:28 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:52163
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992336AbeBNVjV1AqtM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Feb 2018 22:39:21 +0100
Received: by mail-wm0-x242.google.com with SMTP id r71so25422086wmd.1
        for <linux-mips@linux-mips.org>; Wed, 14 Feb 2018 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oDYf7pJD9AuIFnwTR2RoBOSlEI2E9wvEseVLIjqjieY=;
        b=cyzGcWdo8NwDw5+gpSut0VASA0h85+8u68XK55HAfHFxXzH5A+j0fwSkVWI9FB9daH
         i3yMNi8pcOCwtwSlMIwxMSGXqkskYVtXW+y9SOZbKgjsj99MFbM3tZN5jjS8ra2vNP2K
         MInxW1lCwq+C5+ijvIo3FuQilrceDRdAeDIdyN7hh2kW2fvWUzIk2WCBMQi4OaG4gYXD
         t5vcsigyUdZXhLkZyMfElRxYcNNPPEeDtUOk+3kof7HJujUWKuKA/1NMC0TyJ8YGDwf8
         r9eKL0N/0twhim1ZG8ioE9WRh5e8xVNGEXHQ242mu53lm7bWKHmAzSO5tbsi4b34on8h
         cGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oDYf7pJD9AuIFnwTR2RoBOSlEI2E9wvEseVLIjqjieY=;
        b=bMbsnBSep64KVrW0cFqjiPuoawIaK/XwcRsgA6Zh/zVUkdr5eJAMT8OnedIfmYF3Mu
         6LySC1OH9VImid/BW6NckBXmZLF+hOV6OF0CYFCilHsPA7/oLZP1BZxDYT5kJPiwlEPW
         9TzOPpj0rtRI7mokmp0zO5mV0uAUEKey7o8YnPztHEP2h64+wEbFTaid+7ufyfvMVLWF
         uClOMO58907oEasBe+HTJ3g1a0jRb8Tu1eZdYWtIKJe23yUVbSSot8xs4e/0uxfx303q
         LLreHpxigXRjHJQt9Eop2KChnITXGXwBdqidwWRkhDw2tBrFrsmn1ZG+HeYT1/mt9DQk
         iteA==
X-Gm-Message-State: APf1xPBDTxeeqKnTz+oupe+sbKmynWeoxZCH184UaC6kB45lYTc7UdSi
        S6sKgrokhc3Ba/Ie9LoRp2aBgTu7BeXh9KLAps3itg==
X-Google-Smtp-Source: AH8x225KC7OIjbw0IJYK+2RTcUSUgY2yKWEO1FF/3ijN0ktpY+Qnjzk+ykRMH5CT46esX65TO/ml+AknGMY79hiRSnY=
X-Received: by 10.28.45.74 with SMTP id t71mr368293wmt.90.1518644356052; Wed,
 14 Feb 2018 13:39:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.195.139 with HTTP; Wed, 14 Feb 2018 13:38:35 -0800 (PST)
In-Reply-To: <20180214165135.GC3986@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-5-alexandre.belloni@free-electrons.com> <20180214165135.GC3986@saruman>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Wed, 14 Feb 2018 22:38:35 +0100
Message-ID: <CAOFm3uHTMbr=uTHr73JMFkscb86NMgucuopeQt_5AiOUiQZu=g@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] MIPS: mscc: Add initial support for Microsemi MIPS SoCs
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62547
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

Alexandre,

On Wed, Feb 14, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:
> On Tue, Jan 16, 2018 at 11:12:36AM +0100, Alexandre Belloni wrote:

...

>> diff --git a/arch/mips/mscc/Platform b/arch/mips/mscc/Platform
>> new file mode 100644
>> index 000000000000..9ae874c8f136
>> --- /dev/null
>> +++ b/arch/mips/mscc/Platform
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +#
>> +# Microsemi MIPS SoC support
>> +#
>> +# License: Dual MIT/GPL

IMHO you should remove this line as it exactly repeats the
SPDX-License-Identifier: (GPL-2.0 OR MIT) line in a less clear and
precise way.
The whole purpose of the SPDX things is to make licensing eventually
as clear ass possible
Thanks!
-- 
Cordially
Philippe Ombredanne
