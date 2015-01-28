Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2015 16:39:41 +0100 (CET)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:39909 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012124AbbA1PjjtXIPz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jan 2015 16:39:39 +0100
Received: by mail-ig0-f179.google.com with SMTP id l13so11805845iga.0;
        Wed, 28 Jan 2015 07:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9/7pJaYQ6WzssUdPLEVlzNWJc2gfbakU9khev9u0QKA=;
        b=T8Ae28RXFsF4T1GoTrMOHTC3mWbJOxgJaxaTsQLTUFCG2sRGQSourGXLVU51kiMD8+
         I5c8BeAQ5wRYgHzspkajI+tJM7z4CNBDmFsp1it/zgoEJWVqRLRqWWNYHNv55+qRHNZn
         oSUbSQcCR7tdiuatoGfEpxuFFGRwn2HUAKS9mey7If4SXfb6qSHmPnibrc6JjgEZ9NQe
         /ses/XRdWq2qpeLAx6B7vUMNNJtnPZWm60137WI55AjlhLRm5JL6ZH/O26VvnK1MeotP
         +48NXU84gIU5X8Op1TObfhaycINDTiY3nDnFz+LsRjrKiewLkx0zYnSahtBkcmo5yxo6
         brTQ==
MIME-Version: 1.0
X-Received: by 10.42.235.140 with SMTP id kg12mr3753575icb.55.1422459573791;
 Wed, 28 Jan 2015 07:39:33 -0800 (PST)
Received: by 10.64.9.67 with HTTP; Wed, 28 Jan 2015 07:39:33 -0800 (PST)
In-Reply-To: <1418904340-13464-1-git-send-email-helmut.schaa@googlemail.com>
References: <1418904340-13464-1-git-send-email-helmut.schaa@googlemail.com>
Date:   Wed, 28 Jan 2015 16:39:33 +0100
Message-ID: <CAGXE3d-xHPfQMq3h=V1TTm1UUc0qq7Hm373c4CdDRCR1Z77zuw@mail.gmail.com>
Subject: Re: [PATCH] ath79: Increase max memory limit to 256MByte
From:   Helmut Schaa <helmut.schaa@googlemail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <helmut.schaa@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helmut.schaa@googlemail.com
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

Hi,

On Thu, Dec 18, 2014 at 1:05 PM, Helmut Schaa
<helmut.schaa@googlemail.com> wrote:
> At least QCA955x can handle up to 256MBytes.
>
> Signed-off-by: Helmut Schaa <helmut.schaa@googlemail.com>
> ---
>
> Only tested on QCA955x, not sure if this would affect older SoCs in some way.

Any objections to this? In the meantime I was able to test on AR9344
as well (with 128MByte of RAM).

Thanks,
Helmut
