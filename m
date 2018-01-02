Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 03:32:57 +0100 (CET)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:42542
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992105AbeABCcvDseka convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Jan 2018 03:32:51 +0100
Received: by mail-io0-x241.google.com with SMTP id x67so41517522ioi.9;
        Mon, 01 Jan 2018 18:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=meKQPYdGTZpMvRv5OIQtZRpIr4GgSBYqeLsnZAcXbaM=;
        b=bl0Y/5ReQrZOsg8KtCPwhkTR7tuD2zV0zmu8F4MPtt+uvaohCSDQ9iTYcrYaVdVCLQ
         JngrQOnSSYgx4ztXaeYvVSbBp6nPicbd0b6zCAAJCBXfJLxQxng0oXobidqE+6207C4G
         3BSGyy1ehiA9/wfUnlciXY0C7Wt6KsWeQubm9uiYCYZGF1RrGqCVj/M5tCkni6eJ89I4
         d3DAV0vogicWCINjIOtsN/hD3f0I9lMqdtsEpoez4BxoUi/U8W/pGFSgTtQPgb29apz6
         AfUOD7b96aOg9Vnx0Y2koDsp4RHct5h/hFPulaebw6BwRalY/y1GngsRppvmEePuqrjx
         ED8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=meKQPYdGTZpMvRv5OIQtZRpIr4GgSBYqeLsnZAcXbaM=;
        b=WW+L3EQovP4xSNwACuCJjox316OhxbDkPaqRgx3lw3p7W6QHdXUPKI7ydfjdh7iHPY
         +1GGQMTXR9oICKEzOsCgei/483fmk/wP3yOaAScjM0R39u2koQWLPTM+aNOLNu2P6N4n
         rHLmv8JjbC14uQLRG+slMV85lg2h0SCV2RVYjVT232ik4ybe81R9psJIfeBd9ym2tFP6
         XePZGNMNf/0njncF0gMxiou5r4KM9vHjue60YP3iaqQnna7i9at9f0LZkCXJNbObLCv2
         yVzFdseVUJEw9gol3Q3Wd4/8V0br0F6QzViPNOEeE1S2vcaUW75f6nKERlueqLxno/kZ
         ObGQ==
X-Gm-Message-State: AKGB3mIdRFWBPpGJRh2TquUxBBuSZURgBekcYGEunB5jR2W4U0LmOVjn
        49ZULiivPlI2ZFqddwWgNr5AvNUs23aQH/gNy2Q=
X-Google-Smtp-Source: ACJfBou+t21OV4cb0J1EDBJbaXvXdFPpsL540LNW5eRRDzh+M33vfTAew2lbkI8bWeTWaqZ/NBu/5tNzkHP84bJbj/w=
X-Received: by 10.107.52.20 with SMTP id b20mr2989622ioa.185.1514860364952;
 Mon, 01 Jan 2018 18:32:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.152.7 with HTTP; Mon, 1 Jan 2018 18:32:44 -0800 (PST)
In-Reply-To: <CAOFm3uHW1qyCS3U7jtrMtdDtOV=0XE+7mYwxMqGjWXaeWv0EFQ@mail.gmail.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-1-jiaxun.yang@flygoat.com> <20171230182830.6496-2-jiaxun.yang@flygoat.com>
 <CAOFm3uFM+7n_YaKBkZV6jV4VHCBhtGhUTLbB4uedMaCa+nf3PA@mail.gmail.com>
 <1514726063.1668.7.camel@flygoat.com> <CAOFm3uHW1qyCS3U7jtrMtdDtOV=0XE+7mYwxMqGjWXaeWv0EFQ@mail.gmail.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Tue, 2 Jan 2018 10:32:44 +0800
X-Google-Sender-Auth: 4hFrR_9TxnkZOOAKQ01xPZOQJuU
Message-ID: <CAAhV-H6NPejQwo2s_5T2ZvC6uChvGQT2P+NhGncH8xtpF7NcHQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/8] MIPS: Loongson64: cleanup all cs5536 files to use
 SPDX Identifier
To:     Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61810
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

Zhangjin Wu (wuzhangjin@gmail.com) is the original author, I hope he
can give a signed-off. I can only give an ack.

Huacai

On Sun, Dec 31, 2017 at 9:54 PM, Philippe Ombredanne
<pombredanne@nexb.com> wrote:
> On Sun, Dec 31, 2017 at 2:14 PM, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>> On 2017-12-31 Sun 12:17 +0100，Philippe Ombredanne wrote：
>>> Did you CC the original authors? You would need their signoff or at
>>> least an ack IMHO
>>
>> Yeah, I CC Huacai Chen in v1 as the Lemote staff who in charge of
>> Loongson's mainline kernel. Can he sign-off for all the original
>> authors who were from ICT and Lemote?
>> As far as I know, some authors are no longer working in Lemote. And I
>> can't see their new email addresses so it may hard to get their ack or
>> sign-off.
>> Thanks for your adivce.
>>
>> --
>> Best Regards
>> Jiaxun Yang
>
> It would best if you can get all acks, at least one authoritative from
> each org involved or from each individual involved if not part of an
> org. I reckon it may be difficult. But then you can document with your
> patch set who you contacted, who you got ack from and who you did not.
>
> Then again you are not changing anything about the licensing: just
> replacing licensing by value (e.g. a full notice) by a license by
> reference (e.g. an SPDX tag that references the full text).
>
> --
> Cordially
> Philippe Ombredanne
>
