Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 04:06:15 +0100 (CET)
Received: from mail-ot0-x230.google.com ([IPv6:2607:f8b0:4003:c0f::230]:57298
        "EHLO mail-ot0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdKNDGHuXyTl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 04:06:07 +0100
Received: by mail-ot0-x230.google.com with SMTP id j29so12062607oth.13
        for <linux-mips@linux-mips.org>; Mon, 13 Nov 2017 19:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8L2t9FO9emHhHK71HRZozkWKE1cFcr4ti3bQbbWp48=;
        b=ZgQxRAjer3BtI1nXrnMddy8LBGvA8qPNy72iSlShXVO6rNdrvZu3Fvv7ig3QbVD5/n
         bSuP049Zay5cDr7i6ssh/ztQ98JW4bad5D3MOskEr9huGF9ambKo01WjiaIiSafkSmEn
         PJWn3lod3wNMofChvtlHr07yUO8bziVMZnkz8ymEjDrIE2ZkD21M5a2VjO6q/E+7LdR1
         6tg+Fdas6NWYJEtfL63MHQiZ0nDz/X3CR8006mDn1lwaJieX3DMk6tRvBfdtrbWNUBNc
         Rcw03CCRxJAu/0xnd+p2O60XJLUrXY9lxCb7fG+BRft6zRZuKH+D4xRq33IYuVHNZpBy
         2o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8L2t9FO9emHhHK71HRZozkWKE1cFcr4ti3bQbbWp48=;
        b=FIT7J9I7PwbxAagjfEIUQfVt76LASdirU3QZNLAF2zHOK1lit94I/R+I0ijb/FESDm
         KZUvt+bM/Td0L0UFPeT+2C57fjECuF++zszJeA2WYY/kEx4JyIrs9Fmq72POsxXDXzsu
         rBVf5HzJ814G5P4ASkHRtJWYtT97cVZGuMyTPC/fzIHavGgu7/jGtf96mnTIY1UP/y/I
         P65dqy/3aQHPsboB6Z6TF4YdnJBkqmxBtVkDqo32a/D9CVuMUjL0Wqwp6XuiXO1ri33h
         Uo8QU1JkERzpY2oAIEnhmupncn4B1v3x48ktfDXm/0aG7dS9smDo4ZdqkQjVzRh+5GI4
         URag==
X-Gm-Message-State: AJaThX5cOzY7O0VVPrfx7TIpOG1XVVXTEYW9zpvEMhJbTePsJudlKgQb
        mG4nlILxmqWVZQVUGNKm5PwyDg==
X-Google-Smtp-Source: AGs4zMbTK6ysCnOLJbhjaYabwoVGdkrGpL9m+4LiXPebHdlshGlJRvDTchKnjw816ccEZxIW+Kqo3A==
X-Received: by 10.157.82.95 with SMTP id q31mr5448092otg.414.1510628758683;
        Mon, 13 Nov 2017 19:05:58 -0800 (PST)
Received: from ?IPv6:2600:1700:9da0:c90:2dfe:10bb:b575:1c3e? ([2600:1700:9da0:c90:2dfe:10bb:b575:1c3e])
        by smtp.gmail.com with ESMTPSA id g21sm2072671ote.79.2017.11.13.19.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 19:05:58 -0800 (PST)
Message-ID: <1510628754.14209.27.camel@chimera>
Subject: Re: [PATCH] MIPS: implement a "bootargs-append" DT property
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Nov 2017 19:05:54 -0800
In-Reply-To: <CAL_JsqJRVB928DVOAVQGrtT_EOuQBHkBhcd9+XFzqemutG65GA@mail.gmail.com>
References: <1510420788-25184-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
         <20171113112312.GZ15260@jhogan-linux>
         <CAL_JsqJRVB928DVOAVQGrtT_EOuQBHkBhcd9+XFzqemutG65GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Mon, 2017-11-13 at 10:34 -0600, Rob Herring wrote:
> This is a kernel problem. What's the use case where you want the DT to
> override the kernel?
> 
> One way you could handle this is make bootargs be multiple strings.
> Well 2 specifically, the first string is prepended and the 2nd is
> appended. That complicates how you'd implement /append-property/
> though as you'd probably want to support both string cat and 2
> strings. Though the latter works more generically without knowing the
> data type.

Let's say the bootloader tells the kernel that the command line is "foo
bar" and that "baz" is in the dtb. Currently, there are kernel
configuration options to control whether this means the kernel's command
line will be "baz" or "baz foo bar" instead, but there is no way to turn
it into "foo bar baz" without either creating new kernel configuration
options or this patch. Implementing it via this patch would allow a
theoretical distro to use a generic kernel across different devices that
need the arguments from their bootloader manipulated in different ways.

Ideally, the MIPS-specific kernel configuration options for how to treat
the dtb's bootargs with respect to the bootloader's bootargs should go
away in favor of an analogous device tree property "bootargs-prepend"
for this reason. The kernel configuration options to supply a hard-coded
default command line if the bootloader does not supply one, and to
override what the bootloader and dtb supply, would remain. This would
separate the need for an alternate or "recovery" kernel to supply its
own bootargs to override the dtb from the need to have device-specific
bootargs in the dtb override a legacy bootloader, where the manner its
bootargs are overridden may be device-specific.
