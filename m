Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2016 11:40:48 +0200 (CEST)
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38361 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992168AbcJDJklBG3Hq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Oct 2016 11:40:41 +0200
Received: by mail-wm0-f42.google.com with SMTP id p138so200959896wmb.1
        for <linux-mips@linux-mips.org>; Tue, 04 Oct 2016 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=jPHOORQXq10Xo/dAbVINcJh1qS2rkQV6gCPnoPgMTBY=;
        b=1w+Fa4/eegl8jXVHQLUSEKYesX8aUpAv5MuNL2hwnM2KOEuvdKBP/o78NGC8LxBesB
         cztqdYvpgEtDOU/7Bv6imW37yxneQxlKVm5GHK9IquxNbVc1SxxjPS2vg1Qi00JwEj8f
         M/+a7STgD+EQ8rh51idQvw9M4CQx+t56rpEbzqtAfIOPJ6C1oddAL7BgphGPA3XPv0We
         CPlb/RM1Lw7RnWWrYMX+wb1aU6G5W1N0ptgzrjD3FxvGTVt1xAwBH6uq2sdO/Vh1c+3P
         LxsnN5SRR9eVMUgfe0zfPPQW6ClBsC78VkZnMhTCmTKeQrbIOjpTHWiYFlaQ8iHl4BLK
         2lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=jPHOORQXq10Xo/dAbVINcJh1qS2rkQV6gCPnoPgMTBY=;
        b=WkYLkiE/8dPQUER3p4C+d+BPW/QU2+MmNVVkZxzwcEza/zn9loKpZek9oonMXIDeln
         vllPm0X+6q9mgReeqhu0MA6KnTnouKv+STBQSjYRJFK9QHE81P0Jg8YK0V0l3yQqkmT7
         bor5gwOtdthFiCzZYlGiwvFICen4faft/q5aBbDIksLWnel2pfiLgD4HjIxtTf5eorjg
         +VsCVlRWvhazsFV5WXMSHsOabEANRtXHZN7TfKurZiMRfCjHYkSqB0V5a7HeFZKMKSVJ
         qDo17jd7/uHDtpKxw2fUTrNu8Ps2xDOp35g2yoR+2BaL43JprR1VMtaxJMwjyO/HiVi8
         8PsA==
X-Gm-Message-State: AA6/9RmquxbtCFdJylLnEOOKA5sFjuF7YbWV+QbC7wkgvrJZMUb4TsN0QtlKCp/E3B6p+y6x
X-Received: by 10.28.203.194 with SMTP id b185mr2684318wmg.36.1475574034590;
        Tue, 04 Oct 2016 02:40:34 -0700 (PDT)
Received: from [192.168.1.21] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id jr3sm2572682wjb.13.2016.10.04.02.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 02:40:33 -0700 (PDT)
Subject: Re: [PATCH] MIPS: ath79: Add initial support for the HAPROXY Aloha
 Pocket board
To:     Alban <albeu@free.fr>
References: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
 <20161004110940.57d112df@tock>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <3b41a114-7ec7-cd50-6967-9a1be96e2c2f@baylibre.com>
Date:   Tue, 4 Oct 2016 11:40:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161004110940.57d112df@tock>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jPvjRB9x9q5wTttxjWmmkMQT7BlGqsFlD"
Return-Path: <narmstrong@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: narmstrong@baylibre.com
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jPvjRB9x9q5wTttxjWmmkMQT7BlGqsFlD
Content-Type: multipart/mixed; boundary="KCwcwbxhjShN9k6xnVNSjhOHwXxFX4d3C";
 protected-headers="v1"
From: Neil Armstrong <narmstrong@baylibre.com>
To: Alban <albeu@free.fr>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
 linux-kernel@vger.kernel.org
Message-ID: <3b41a114-7ec7-cd50-6967-9a1be96e2c2f@baylibre.com>
Subject: Re: [PATCH] MIPS: ath79: Add initial support for the HAPROXY Aloha
 Pocket board
References: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
 <20161004110940.57d112df@tock>
In-Reply-To: <20161004110940.57d112df@tock>

--KCwcwbxhjShN9k6xnVNSjhOHwXxFX4d3C
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/04/2016 11:09 AM, Alban wrote:
> On Mon,  3 Oct 2016 17:35:31 +0200
> Neil Armstrong <narmstrong@baylibre.com> wrote:
>=20
>> The HAPROXY Aloha pocket board is a Load Balancer demo board based on =
the
>> Atheros AR9331 SoC with 64Mbytes DDR and 16Mbytes on-board SPI Flash.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>=20
> Please use device tree instead of adding another board file.
>=20
> Alban
>=20

Hi Alban,

I'm quite surprised since it seems no device tree support is available fo=
r ath79,
I would really like to have device tree for this board, but this is only =
a copy/paste of
the mach-ap121 with button/leds gpio differences.

Could it be possible to merge it ? I would be happy to support this board=
 once device tree
support is landed on the mips tree !

Thanks,
Neil


--KCwcwbxhjShN9k6xnVNSjhOHwXxFX4d3C--

--jPvjRB9x9q5wTttxjWmmkMQT7BlGqsFlD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX83kPAAoJEHfc29rIyEnROngQAKTOZgC5cF3ey/pSAR9Xnd3B
K56ql1LrGC05QcOZ3EgVa0Gm39WhLYNxmTgboq8R6mBLaXyaE7s1CR9EohsV1clo
Van3bBP6aOCGcwpRUZTNLmQ9f1UO7AwfyQ1U46DFjLWHhlo9oofa7vPCZR9X23Hm
yTYaZnJ2qELzp0JggNv+K7q801HtRTf2MmSEh3gvSHmA0YW2ax3M/QauepfkLxZD
GtU4gfnaYtijGIdr9ZlJgQdjoRMVLZ1ZbkLGw+mtbFYhbwGDpphGjgA10T3V217s
RTz2/JPB5mrhP/mYWUe8+k4wp23+e+UlxJF1kbYTtRfKhq7kWbo5v0f9hohGDrO1
AYskS8E75al8ccmHlYr7AuXvjaPcHMhS/Tiin4MuWx6F7NN4Td7W92kqBPVHphAv
XlLh6SplZsqDPjZm7hXZG4JvxX2Ywmuf6v7iLbZf2sWVOk8b2SHxIlbVi8wYrOnZ
arW9t3tZX05xxPU/a8nqEAUZVYMg8j0aW8aAQJFowG+o8pUSJVAZEPCd8f0A4LoZ
CgN8MPSyTK7E9S628jvpC6CHoazQMvFzUvPeS6szVgsK7EUZl/JkZ3xhkwzZeo0N
ZMush7x6HvEuK0qFr2meDBsOkULfIzdL5k1AlQwfdpmD4haW4x+kjSgujAhHxQiv
6glp/7rQZj6a13iEPM8U
=52hJ
-----END PGP SIGNATURE-----

--jPvjRB9x9q5wTttxjWmmkMQT7BlGqsFlD--
