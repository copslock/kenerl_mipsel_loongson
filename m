Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2018 23:31:24 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46639 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994608AbeERVbQ5HT37 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 May 2018 23:31:16 +0200
Received: by mail-oi0-f68.google.com with SMTP id y15-v6so8313901oia.13;
        Fri, 18 May 2018 14:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TcLs4kcXTDMTqNwPQjx4ZfBmIENUblUdhBy1kHJa1k0=;
        b=FZhFxPc91s5PhTzhi6zdiVey/196jofdvtaoynf2OtNtcF1O/YWFS/+xwbcJsCYZdb
         1iXPxUBP5nMy085V6HFSxkDeakDG0mVRxx1U5FCuwW8jPtKlospNjbjNtSeR2FIRmgHu
         SywbluL8QBUWgrySega4noAXOmpz7EETSl4notJrsmRDh6i6/WSry5SZPjrzdgPJMFYo
         qGVyo4lQ5XjKQn8xbz/xzbzwyuIPdWgJ+j921B0swaD0dnT9AENIQ5QXAj6zorh/MpDU
         Kqjc7sTwRsl92LbO3R6PjKThHfoDDDaTCcLCHGcpTFWCTBjJ/WakqwtxBUvoJDlQ2Fre
         3PNw==
X-Gm-Message-State: ALKqPwcFVmOD710DdLfKxFE85RSWwWbynXYQSAzh8QaQjpjeJXY/ADEn
        iNZsv/GrmPAxTxNKzPC7dw==
X-Google-Smtp-Source: AB8JxZpP+HSXrt2x2ZkbijnyWSDm7MhL67obgmHigWQiYe3ITt4RhlxiDhzTTs06LWZguyCG5UEABg==
X-Received: by 2002:aca:1906:: with SMTP id l6-v6mr6883138oii.183.1526679070945;
        Fri, 18 May 2018 14:31:10 -0700 (PDT)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id n82-v6sm4172998oif.4.2018.05.18.14.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 May 2018 14:31:10 -0700 (PDT)
Date:   Fri, 18 May 2018 16:31:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 6/8] MIPS: jz4780: dts: Fix watchdog node
Message-ID: <20180518213109.GA28202@rob-hp-laptop>
References: <20180510184751.13416-1-paul@crapouillou.net>
 <20180510184751.13416-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510184751.13416-6-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Thu, May 10, 2018 at 08:47:49PM +0200, Paul Cercueil wrote:
> - The previous node requested a memory area of 0x100 bytes, while the
>   driver only manipulates four registers present in the first 0x10 bytes.
> 
> - The driver requests for the "rtc" clock, but the previous node did not
>   provide any.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Mathieu Malaterre <malat@debian.org>
> Acked-by: James Hogan <jhogan@kernel.org>
> ---
>  Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt | 7 ++++++-
>  arch/mips/boot/dts/ingenic/jz4780.dtsi                            | 5 ++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
>  v2: No change
>  v3: Also fix documentation

Reviewed-by: Rob Herring <robh@kernel.org>
