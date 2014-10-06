Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2014 14:43:35 +0200 (CEST)
Received: from mail-yh0-f42.google.com ([209.85.213.42]:41810 "EHLO
        mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009833AbaJFMneC4vwY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Oct 2014 14:43:34 +0200
Received: by mail-yh0-f42.google.com with SMTP id t59so1995821yho.1
        for <multiple recipients>; Mon, 06 Oct 2014 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CTo2rsfoK1YUlS5tMQsHFP6YU0jHZWKaDuuGFqWznRs=;
        b=KwJ2xhKySGDD5pHdo87phsf4S6XMNYEe5asesY707vnlrQYn8XiNCc3Jz+EyNPBxbm
         RY48jAbfMiYsTsLwTAhx2Rl0R58Gll0SMUj14Ta5sWpW2KcnCV9m9y53yXMH3mZ6VQVi
         Nv8c4TJVWFOBS/OHH2ILpAT9f5qRWpuixEQrriw6mGrTsqlNkSM1ul8pV5qrfOU6pssk
         LYWqjGfuESNte+Y0py+s5i+j8KMG8w1NPLP/1/jHZW32sodQdqblxWJij7q6rrHJiwcE
         3HWxw3ZoI9Tg8OJguZ5bG/hTJPV4BNVV32q3ZdNL8w2l/tCRB5bKNYvJa2hbNayTjc7r
         iQCQ==
MIME-Version: 1.0
X-Received: by 10.236.41.199 with SMTP id h47mr35831310yhb.1.1412599407770;
 Mon, 06 Oct 2014 05:43:27 -0700 (PDT)
Received: by 10.170.153.135 with HTTP; Mon, 6 Oct 2014 05:43:27 -0700 (PDT)
In-Reply-To: <CAHNKnsTkeeg6c4NGqBRVbaG4gF7_rkrGuGxZ3Ty5MeQOF6ox6g@mail.gmail.com>
References: <CAHNKnsTkeeg6c4NGqBRVbaG4gF7_rkrGuGxZ3Ty5MeQOF6ox6g@mail.gmail.com>
Date:   Mon, 6 Oct 2014 16:43:27 +0400
Message-ID: <CAHNKnsR5DCGnw0N1TdB_FDfTzv4fC-XHaRXxyTp3a4Fzs7HckQ@mail.gmail.com>
Subject: Re: Atheros AR231x MIPS machine name (ex [PATCH 01/16] MIPS: ar231x:
 add common parts)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        OpenWrt Development List <openwrt-devel@lists.openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-10-03 22:46 GMT+04:00, Sergey Ryazanov <ryazanov.s.a@gmail.com>:
> Add owrt mailing list to cc.
>
> Any suggestions?
>
> 2014-09-30 0:57 GMT+04:00 Sergey Ryazanov <ryazanov.s.a@gmail.com>:
>> 2014-09-29 13:30 GMT+04:00 Jonas Gorski <jogo@openwrt.org>:
>>> On Sun, Sep 28, 2014 at 8:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com>
>>> wrote:
>>>> Add common code for Atheros AR5312 and Atheros AR2315 SoCs families.
>>>>
> [...]
>>>>
>>>> +config AR231X
>>>
>>> I would suggest naming it ATH25, to match the other atheros target
>>> (ATH79).
>> I have been thinking about such name. But decided to keep code closer
>> to owrt realization. May be maintainers could suggest smth. Ralf, what
>> do you think?
>>

Any thoughts?

-- 
BR,
Sergey
