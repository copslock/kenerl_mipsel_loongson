Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 09:08:58 +0100 (CET)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36141 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007617AbcAGII4grkM4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 09:08:56 +0100
Received: by mail-ig0-f173.google.com with SMTP id z14so28698305igp.1
        for <linux-mips@linux-mips.org>; Thu, 07 Jan 2016 00:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/Lyu/Y4WAzT8QxBGjVOegUdJqj9E7pS3p6P6rcJBIxE=;
        b=UglLFQc8rULpBfTGOM2IVewJQKQdrVHroa3/cn+O1FqlALUmLh0nCJ34pbfjdAGMpe
         7J14HlD2cozIkXE05O8BFx3CbzO29uwBgBXUjiskN2qknjdGOLBuiWqss24KfVynZFoV
         kpJzHy5Y7hWNXqJX/iIiD1z7sGND/mRNFIlszMmJSJx+x5cbt+YW0S6VLyqE4jPtS4JO
         fdYYRWOq/r8UW8bV1fMS5cQml5xs9dWYd0xeB15qJDA4QTuR4aODj99XcYLp8cXqfAVu
         rfTj0n7N6z69RMNqGg27RSfDvk6BTW3NLY/8d+R1DkDl7kZtxaReu0ArunFyuwUc1iPZ
         mPvA==
X-Received: by 10.50.43.136 with SMTP id w8mr13848969igl.96.1452154130629;
 Thu, 07 Jan 2016 00:08:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.125.69 with HTTP; Thu, 7 Jan 2016 00:08:21 -0800 (PST)
In-Reply-To: <1452106523-11556-3-git-send-email-f.fainelli@gmail.com>
References: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com> <1452106523-11556-3-git-send-email-f.fainelli@gmail.com>
From:   Gregory Fong <gregory.0xf0@gmail.com>
Date:   Thu, 7 Jan 2016 00:08:21 -0800
Message-ID: <CADtm3G5TPUVgdkrumAx1DmkxzCNwFd1KGMR6Ku+HQmGF4SYL-w@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: brcmstb: Set endian flags for big-endian MIPS
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        jaedon.shin@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregory.0xf0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.0xf0@gmail.com
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

On Wed, Jan 6, 2016 at 10:55 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Broadcom MIPS-based STB chips endianness is configured by boot strap,
> which also reverses all bus endianness (i.e., big-endian CPU + big
> endian bus ==> native endian I/O).
>
> Other architectures (e.g., ARM) either do not support big endian, or
> else leave I/O in little endian mode.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
