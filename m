Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 15:19:35 +0200 (CEST)
Received: from frisell.zx2c4.com ([192.95.5.64]:57461 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990947AbeITNTc00Hdp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Sep 2018 15:19:32 +0200
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 43e783cf;
        Thu, 20 Sep 2018 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=NHyiYwi6nEMe5Tx+fPvDHk4MCU8=; b=QDsone
        KF0pVH4UnGLf4z1hWZED+9kocErWsmVsP68iZ+UVucGKRBG6e6HnjgTjv1UPvgxB
        QHssaMyRWSoPz972xTzYAhFs1MEXC3gF3DMqawvPo9WzT0+54Z6bR0nSqE1giaqD
        2qP9SjqWeohpw94BM8Suklnf1Jr7v5itNyx6/ICn/U3ss/JUBxyReFGe1aldEu3g
        wrhMjtlF9jHyrZAzUJbL2SottPkm8k/tjhg4Ipzo1R+IdXWgrxyNMsBc44g6ltpn
        y3X5nUrfQLz4AZ1FOFG8XQoPS18hruIWKXX58XPW/FSio6UDvlhxuJ64iWl9NtxD
        nOM7ygJBHOdKE+4Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id db8d233f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 20 Sep 2018 13:01:30 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id j9-v6so9386406otl.2;
        Thu, 20 Sep 2018 06:19:19 -0700 (PDT)
X-Gm-Message-State: APzg51C+zN39hBPmAlB6Br4rgL5Sx9OhHu8Z8LwaJEaiAm1BrNXgbuFp
        6pxG/CHp9apEfDVU5gNXsoWYmlSinj/s54eM2Oo=
X-Google-Smtp-Source: ANB0VdalXBPhLl0gOCOE0waNb7VEgcf/CP3YB42L2opNmZcwFQZ+eKU9PxemWIJXtGkvNRRlGCrZ6RKBl4883xVDMM4=
X-Received: by 2002:a9d:56b6:: with SMTP id o51-v6mr20914677oth.393.1537449558024;
 Thu, 20 Sep 2018 06:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-7-Jason@zx2c4.com>
 <20180918202549.ogfyunppxaha7sfu@pburton-laptop>
In-Reply-To: <20180918202549.ogfyunppxaha7sfu@pburton-laptop>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 20 Sep 2018 15:19:06 +0200
X-Gmail-Original-Message-ID: <CAHmME9rm9dqa6wtBDLngdXfv+3DCCsgM51z9nbGg3Bb_Q_zdwg@mail.gmail.com>
Message-ID: <CAHmME9rm9dqa6wtBDLngdXfv+3DCCsgM51z9nbGg3Bb_Q_zdwg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 06/20] zinc: ChaCha20 MIPS32r2 implementation
To:     paul.burton@mips.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, jhogan@kernel.org,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

Hi Paul,

Thanks a bunch for the review.

On Tue, Sep 18, 2018 at 10:25 PM Paul Burton <paul.burton@mips.com> wrote:
> Should this be .set reorder?

Nice catch. Fixed here:
https://git.zx2c4.com/WireGuard/commit/?id=23d97fc333cf85dd07445a9d21a28cbef47c553c
But then...

> Even better - could we not just place the addiu before the bne & drop
> the .set noreorder, allowing the assembler to fill the delay slot with
> the addiu? Likewise in many other places throughout the patch.
>
> That would be more future proof - particularly if we ever want to adjust
> this for use with the nanoMIPS ISA which has no delay slots. It may also
> allow the assembler the choice to use compact branches (ie. branches
> without visible delay slots) when targeting MIPS32r6. I know neither of
> these will currently build this code, but I think avoiding all the
> noreorder blocks would be a nice cleanup just for the sake of
> readability anyway.

Great idea. Rene has committed that here:
https://git.zx2c4.com/WireGuard/commit/?id=5c153a59ac3aa58a3ff17c69fee63d599e5f2758

These will be in the v6 patchset whenever that's posted, and it's
already been merged into the dev tree:
https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/log/?h=jd/wireguard

Regards,
Jason
