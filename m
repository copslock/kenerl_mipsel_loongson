Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2015 08:53:13 +0200 (CEST)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36477 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008199AbbJSGxLNd-8L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Oct 2015 08:53:11 +0200
Received: by obcqt19 with SMTP id qt19so53316334obc.3
        for <linux-mips@linux-mips.org>; Sun, 18 Oct 2015 23:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EfWyGykW8H/uixdLeVPrtIXV+rnE8bmS4z0PYzK7QxI=;
        b=monQJ5Ef9wgZkvS45znvO9n2bCDgN01Bge8zVP2cU2eZhv6htfyktlLxvcptrYODhz
         GUr4r/w7K0zOVtbyOO4VpGx8T3VdqaiOL0dFUA+T37Oi59sYFdWo3CEQIrAry3YR8JXF
         8XzKRSvmgTLSh2Zl+kK9DQWfuHMFuAXUfl1i+X1IldJhrKPsqrIQMITavt3ahR2aiQhR
         SYyhnYTZrEJm//0tMlmdQw1hLFxhxgBcjEDmaYHYGeVzuc4wy0rB1vxPSb7c6PsRa7DE
         tTgnUS8t8RGxGdNneflzOm31rBWOH6NgoJHtKx4QBxZTSGKHXh3XCzUKl7MaXldN6YNM
         HK+A==
X-Gm-Message-State: ALoCoQlUcukGulx5s2J4toC3USLpAHXzryGGuxe5jVm5qkpJhDAwzilmsSbV5B+mRKTsksy6iiQY
MIME-Version: 1.0
X-Received: by 10.182.153.136 with SMTP id vg8mr17032293obb.21.1445237585093;
 Sun, 18 Oct 2015 23:53:05 -0700 (PDT)
Received: by 10.182.214.104 with HTTP; Sun, 18 Oct 2015 23:53:05 -0700 (PDT)
In-Reply-To: <1444827117-10939-3-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
        <1444827117-10939-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Date:   Mon, 19 Oct 2015 08:53:05 +0200
Message-ID: <CACRpkdazQm722wx6c+YgTqLFv65_J=TUBBKRtq=37r5NJZe2nQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpio/xilinx: enable for MIPS
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Wed, Oct 14, 2015 at 2:51 PM, Zubair Lutfullah Kakakhel
<Zubair.Kakakhel@imgtec.com> wrote:

> MIPSfpga uses the axi gpio controller. Enable the driver for MIPS.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Patch applied.

Yours,
Linus Walleij
