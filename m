Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 15:29:21 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:33871
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992517AbdEVN3Oobn9L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 15:29:14 +0200
Received: by mail-lf0-x244.google.com with SMTP id q24so5484303lfb.1;
        Mon, 22 May 2017 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VqcAclGWA5aCDnwa7iZukTAekiClW+xtcj8pJAjmJjE=;
        b=mGi/XBjpIPB75P/52w2HPZx8RkbvnVHwYuS1ylVxsQSHfRP2nDAMu+vZq73JIJs+CC
         jKLhxAaVU7k5sLkmZNg0xd6kzuJg2VzcBaPIm+ZOwP7jaxrU0GGkqG0D2eJf/63UEZ5r
         MSSA6v8eZxqZuP+wcni9vrP8tl159SWksEYtVU8vTm3nKDzrRfgieafTT+5dL5sx87Vq
         nb8gwi/yzcMUOuIuQExZiYFMFbd6JKeK0pRfVvchXtYxbLZI9EqtKsZQKcFeIhxDeecr
         p1sa6u0tYHz/nlVPi/p3SGTAQoJeuulHcRX1cr9ZHaVTAcXO/895ALjF3pBcQmWOkyJC
         ZfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VqcAclGWA5aCDnwa7iZukTAekiClW+xtcj8pJAjmJjE=;
        b=fxQlsuE8H137RHyl1+GbCDApjrO2MUlJy4VxE68O8ODFlCmKZ5fse+0JCy5v4+TgzF
         V0nTh3xPNe0Pnh1U3Z3V/8cLg2NL6X8tU/89X3N14sXvvpLKM64/klPMklNBIKiqpdxI
         ACHUQ3qdTu2dayUy9j0RBK2STgGgv8RGuUq+rBG1kUpU4GdbQqQ7aO+T9rIyMEoI25BA
         oWkbDYKJn4jD8e5/OnUmEnV0jsEHdo+vyYd8JoQJTKxe01qUE+aVJlPf/4H2QS4l5FD5
         38kezX8QkiSQouWegb2gl5QZ6TCAnJPl7u5EDhjIb1AdFFFeDxYXDwkeYD5KgnqH8rFE
         ftLQ==
X-Gm-Message-State: AODbwcCv6sRSaDuPKgQ1c8XVIIo/jKjKqNyIOGxrXsvTm6b8QT2nWGk+
        Zk3tRIW5vqRdTA==
X-Received: by 10.25.163.12 with SMTP id m12mr6066165lfe.6.1495459749197;
        Mon, 22 May 2017 06:29:09 -0700 (PDT)
Received: from mobilestation ([5.164.217.172])
        by smtp.gmail.com with ESMTPSA id t4sm3154964ljd.1.2017.05.22.06.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 06:29:08 -0700 (PDT)
Date:   Mon, 22 May 2017 16:29:14 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        robh+dt@kernel.org, frowand.list@gmail.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/21] MIPS memblock: Remove bootmem code and switch to
 NO_BOOTMEM
Message-ID: <20170522132914.GB20910@mobilestation>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <be0b6614-708d-a32a-029d-7e606a673e5b@imgtec.com>
 <20170522102643.GA17763@mobilestation>
 <ef3d7a8c-2a73-2082-0d64-bdb4f95df204@gentoo.org>
 <20170522130348.GA20910@mobilestation>
 <f14c7a41-ae2d-b19d-fb86-d6e9c9c53949@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f14c7a41-ae2d-b19d-fb86-d6e9c9c53949@nokia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Hello Alexandr,
Ok, I will.

Regards,
-Sergey

On Mon, May 22, 2017 at 03:20:44PM +0200, Alexander Sverdlin <alexander.sverdlin@nokia.com> wrote:
> Hello Serge,
> 
> On 22/05/17 15:03, Serge Semin wrote:
> >> I have an SGI Onyx2 and just recently acquired a working SGI Origin 200.  The
> >> Onyx2 has NUMA issues yet to be hunted down, but I got ~3 days uptime out of
> >> the Origin 200 running compiles before powering it down.  Mainline needs 2-3
> >> small patches to make IP27 workable, last I tested.
> >>
> >> I'd have to look at the IP27 code again and see if I can make sense of what
> >> it's doing.  I think it dealt with either setting up memory for an initrd
> >> (which I haven't used in over a decade), or it's for the NUMA stuff to discover
> >> all memory on each node.
> >>
> >> -- 
> >> Joshua Kinard
> >> Gentoo/MIPS
> >> kumba@gentoo.org
> >> 6144R/F5C6C943 2015-04-27
> >> 177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943
> >>
> >> "The past tempts us, the present confuses us, the future frightens us.  And our
> >> lives slip away, moment by moment, lost in that vast, terrible in-between."
> >>
> >> --Emperor Turhan, Centauri Republic
> > It's great to hear of your willingness to help. Since both Loonson64 and SGI IP27
> > problematic architecture-specific code will be appropriately altered, I'll publish
> > the fixed general MIPS-memblock patchset within two months. I'll also try to
> > involve Ralf in it when I'm ready, so to make sure all my alterations are made
> > within kernel arch-code coding style. While I'm working on it, you can still use
> > the current patchset for some limited tests.
> 
> Please Cc me in this case, I should be able to test on Octeon MIPS64 platform.
> 
> -- 
> Best regards,
> Alexander Sverdlin.
