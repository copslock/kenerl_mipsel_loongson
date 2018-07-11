Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 13:28:06 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:36105
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeGKL17msTb0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 13:27:59 +0200
Received: by mail-lf0-x244.google.com with SMTP id b22-v6so8558773lfa.3;
        Wed, 11 Jul 2018 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ca8b7zCRD7QfcZgaaQWna+FW7Q09KT4sKQo+iY7yTBc=;
        b=GP1IiikSJ4fu0x6j8fhYogv/dl84FlglC9uLkFnujXDMvnZLZ/8o0bSmg7DwX/eBRf
         WS+FiAqlFX5ofWKyKSFAjWKtWNEw4FLWxPk6SLQshEm4xAqKo7oLU08UB6JtYBKAsZ/T
         nLPUxAk/aVJ501+1bkiJ+sV4Z8kbCd+Flf3vxDUl8gfkGy+JnPObj17gdL8t9LvFod7l
         Gmb0vId55bkP6Oi5Vkju/D/BCaKlvFV+dkTvHYsypO5i/r1w+Q8DyTJcLiMl7s/6D0Pp
         wR8nCR8kPwd/8S8nkgsF/Q370btPCPPj0hrF8LkWJQTL9zMOGFSIgM1brGN2fRvMAHMg
         IwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ca8b7zCRD7QfcZgaaQWna+FW7Q09KT4sKQo+iY7yTBc=;
        b=RVY1qoSAruB+3ZJm5fTWybOBxQkmSpUn1TRb5EbzriQbG0UfO5pRUZAQh/pOCv1NNx
         BjbALE2W2iYtRshPqrWOVk76pBTpnCC1IQm5f5y162dmNn2Q43lVkeKSXiVOafUWv5tI
         rTooOddppDTKCKVU6eAVXkrRdF7MQ3wWy4z21sQhaXXOjBR1xXsjevNDuvqSoKFnEYNo
         FXcA3yHQpuihTcIW/FVuOwtjMzqYBF4Km2WR0Qbu3AePqL7dXu6+6QW7ydH80FYEwlCe
         jv4IeiadBNsKgbGzQVqwjmUImhkNADAX5I/GbmDhFtJkary7CDz7t0fvqKedFz7gv3oO
         qV1Q==
X-Gm-Message-State: APt69E0kN5dHxqU1+7PqQbvh2u08aCtfzqqfmeg7xqTbN5DVw2M6z0Dp
        UtwSsvi0lYREyJbHZ87ZD/x/8nOTcYxJMJ19sTk=
X-Google-Smtp-Source: AAOMgpczZrSE7DKbwcBWWuPHhq49OEgFlDFxaTg9niL+3OFuxtWriFhutfEcK2MlsznX7iQ3RKI+t+CyHU4QRtDMGlE=
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr5526466lfe.60.1531308474036;
 Wed, 11 Jul 2018 04:27:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 04:27:53
 -0700 (PDT)
In-Reply-To: <20180711131626.732967be@bbrezillon>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
 <20180709200945.30116-5-boris.brezillon@bootlin.com> <20180711131626.732967be@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 13:27:53 +0200
X-Google-Sender-Auth: FZJ4Ur3iBBNMAdPvqQvfvmwXapU
Message-ID: <CAK8P3a1CR_sN2KW4fZjADHrbKyB1ZSi=6+hPAPYoVeAeLGK_3g@mail.gmail.com>
Subject: Re: [PATCH v2 04/24] mtd: rawnand: s3c2410: Allow selection of this
 driver when COMPILE_TEST=y
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Jul 11, 2018 at 1:16 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Mon,  9 Jul 2018 22:09:25 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>
>> It just makes NAND maintainers' life easier by allowing them to
>> compile-test this driver without having ARCH_S3C24XX or ARCH_S3C64XX
>> enabled.
>>
>> We add a dependency on HAS_IOMEM to make sure the driver compiles
>> correctly, and a dependency on !IA64 because the {read,write}s{bwl}()
>> accessors are not defined for this architecture.
>
> I see that SPARC does not define those accessors either. So I guess we
> should add depends on !SPARC.
>
> Arnd, any other way to know when the platform implements
> {read,write}s{bwl}() accessors?

I'd just consider that a bug, and send a patch to fix sparc64 if it's broken.
sparc32 appears to have these, and when Thierry sent the patch
to implement them everywhere[1], he said that he tested sparc64 as
well, so either something regressed since then, or his testing
was incomplete. Either way, the correct answer IMHO would be to
make it work rather than to add infrastructure around the broken
configurations.

      Arnd

[1] https://lwn.net/Articles/604819/
