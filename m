Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2016 10:39:07 +0200 (CEST)
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34149 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034303AbcEZIjELysQk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 May 2016 10:39:04 +0200
Received: by mail-oi0-f46.google.com with SMTP id b65so113850852oia.1
        for <linux-mips@linux-mips.org>; Thu, 26 May 2016 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=IZi6xOrp/6z8qVntvOh4Xgtym8raVk9fBdRCVhSe28I=;
        b=NUNbwCwWy5oUhsslz0Oz+8HRUVjsD68dZHBg/GVcjB2TNdZYAR6CNF/MaE0OrnWyOc
         QUXI/K3R3Rh3BcizPcHtWfgTZ8tiK4DhOTSYUoF3vVPh9oyPOzZ3ivIE4/IEPjeI40/u
         /NcHOoxntPM49wgjeP9ydUfXWn2Q4jIJ0JmBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IZi6xOrp/6z8qVntvOh4Xgtym8raVk9fBdRCVhSe28I=;
        b=Cr0wOck31weAEcKiO5kBW2vRdXcsKJ4m4ZDy7Jg26KpPdABttm77+It26uogiet1hM
         oNR0FK5gJ9w4+KbuPCPhTlIcisV+6T6/oPYfvHprA3faiRO7yniLxc85dX6WBxeLFo4D
         DiGLPEJz5AfK5nuBK0T7/bvGbMLRHmEavZajutWHU/81q0ALdIlFaaxiYhhrCl+B+zP6
         gmm9LTCc9nsqqQxU0J5OvMy1RCmxI8g0h1fdtD6ggF496FSXXSLDQTjp9uCQzfnu38Ad
         x6xXIKrm1O9W+YODL/RtCNgSQiUHVs3hOXA5UHRw5FsAvIWtLWaY7iWGEdxiDFBOwyiw
         t6Tw==
X-Gm-Message-State: ALyK8tJGzUC/ex0PdWDT2crQ8FhYXJFi1AD+d4C6ujgkNTrzO+EbaN09ddC8hjaHHrlaMNn/mRC6x+I7T1yZpRmN
MIME-Version: 1.0
X-Received: by 10.202.168.143 with SMTP id r137mr5251644oie.40.1464251938590;
 Thu, 26 May 2016 01:38:58 -0700 (PDT)
Received: by 10.182.176.104 with HTTP; Thu, 26 May 2016 01:38:58 -0700 (PDT)
In-Reply-To: <1463461560-9629-11-git-send-email-purna.mandal@microchip.com>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
        <1463461560-9629-11-git-send-email-purna.mandal@microchip.com>
Date:   Thu, 26 May 2016 10:38:58 +0200
Message-ID: <CACRpkdbXvKyqjtGREUbHhgVm=DU9p4P2HysqnfOu7DAvZ--eRw@mail.gmail.com>
Subject: Re: [PATCH 11/11] dt/bindings: Correct clk binding example for PIC32 gpio.
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Courbot <gnurou@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53660
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

On Tue, May 17, 2016 at 7:06 AM, Purna Chandra Mandal
<purna.mandal@microchip.com> wrote:

> Update binding example based on new clock binding scheme.
> [1] Documentation/devicetree/bindings/clock/microchip,pic32.txt
>
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>

Patch applied and squashed into the other pic32 patch
with Rob's ACK.

Yours,
Linus Walleij
