Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Dec 2017 14:55:01 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:42769
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990426AbdLaNyxvLE2a convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Dec 2017 14:54:53 +0100
Received: by mail-wm0-x244.google.com with SMTP id b141so8184057wme.1
        for <linux-mips@linux-mips.org>; Sun, 31 Dec 2017 05:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ObLdAXjOt0EUsJRXPDQdL5KYvEJBR/9TXJ1n2m0Fn0w=;
        b=0NTqXXkELmlYoSOG6Mtm8wOcA6WpKdEO94RmWNS0Dva5OW6+Fsl+99nWeR9kQ5LwFP
         FqZaBEEhbSdBTaU/fkJW4lvpskQIENSR8l3HYV4JNZdwnLAvD1oeTPOafo3BX3QMkUye
         DGT+EkV3WRuVYk+LKB9GVLu4uvtVFDxlYRSpStZuzoTt8CzfZPg+B64E5jZrrtaCdpkZ
         9pPs+ZQ2iFcc5Kq8NHcrUn0/Apjeo6fxl5cKaQojzhRFmofdgcQ9AFWLeH7VpPOf80sJ
         /8phLI9b3PRNCiwbmrWcuk4NI0VNfqWkUljyykZd3SwNYNDpv7xLE7w5agfqjCRhrDU5
         CJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ObLdAXjOt0EUsJRXPDQdL5KYvEJBR/9TXJ1n2m0Fn0w=;
        b=IKQfhgpVUX2fALhHSgHsxb2tCwHRankkrZWSlP28IxprgP0BPoXWB6AhHjBYROCoJ0
         tfs2hb92p+wBA3kf6BAEQLXy0wdEVRAgr0qVAM9hvrxjXwmrUbdTs1Bxsm3xJTUwHBQZ
         ND1TUSXwXeHp64uVQLh7xgI73y6joWqV05Fi28UYhakBHtPKj6Nmq+T8+SOxyNwVsyqB
         Qk7+ESnG0GLJdbATl1leahExWvP/1ixOwVZapmEmNpWx1ArQKm3kfo5RwMnx3WkhgUZa
         suGuV9SjO5BSbEeyL3B5aeFd7JLS3qXDUGnWf2LyyobhPNa+TE3lZLTrAh3YHO/vEgWN
         wvBA==
X-Gm-Message-State: AKGB3mKVLOI55OLLWJ2eCNwNsd606Ayh7acCSzSZcvLwjGkswqu7zct3
        FDvVMHIDkOyodRi3EppWemnwd1lvmfm5I5XW1OCWbw==
X-Google-Smtp-Source: ACJfBosNbSS24N6kSSylPRBvZhcMX+pcS/Bn5BUMDgdLL6PXPx1emLTRLBE4q/6bo/E9vQ1AXghNpSjeAo5o1qdeM5c=
X-Received: by 10.28.136.15 with SMTP id k15mr31108953wmd.147.1514728488189;
 Sun, 31 Dec 2017 05:54:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.206 with HTTP; Sun, 31 Dec 2017 05:54:07 -0800 (PST)
In-Reply-To: <1514726063.1668.7.camel@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-1-jiaxun.yang@flygoat.com> <20171230182830.6496-2-jiaxun.yang@flygoat.com>
 <CAOFm3uFM+7n_YaKBkZV6jV4VHCBhtGhUTLbB4uedMaCa+nf3PA@mail.gmail.com> <1514726063.1668.7.camel@flygoat.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Sun, 31 Dec 2017 14:54:07 +0100
Message-ID: <CAOFm3uHW1qyCS3U7jtrMtdDtOV=0XE+7mYwxMqGjWXaeWv0EFQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/8] MIPS: Loongson64: cleanup all cs5536 files to use
 SPDX Identifier
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61801
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

On Sun, Dec 31, 2017 at 2:14 PM, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> On 2017-12-31 Sun 12:17 +0100，Philippe Ombredanne wrote：
>> Did you CC the original authors? You would need their signoff or at
>> least an ack IMHO
>
> Yeah, I CC Huacai Chen in v1 as the Lemote staff who in charge of
> Loongson's mainline kernel. Can he sign-off for all the original
> authors who were from ICT and Lemote?
> As far as I know, some authors are no longer working in Lemote. And I
> can't see their new email addresses so it may hard to get their ack or
> sign-off.
> Thanks for your adivce.
>
> --
> Best Regards
> Jiaxun Yang

It would best if you can get all acks, at least one authoritative from
each org involved or from each individual involved if not part of an
org. I reckon it may be difficult. But then you can document with your
patch set who you contacted, who you got ack from and who you did not.

Then again you are not changing anything about the licensing: just
replacing licensing by value (e.g. a full notice) by a license by
reference (e.g. an SPDX tag that references the full text).

-- 
Cordially
Philippe Ombredanne
