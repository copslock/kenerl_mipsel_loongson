Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 03:41:11 +0100 (CET)
Received: from mail-oi0-f42.google.com ([209.85.218.42]:45310 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992391AbdLAClEUg0ZS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 03:41:04 +0100
Received: by mail-oi0-f42.google.com with SMTP id x20so6251887oix.12
        for <linux-mips@linux-mips.org>; Thu, 30 Nov 2017 18:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ANNXmmi7RRd29aMUXxsxFQtX9V0WRAD1uwYYb8AIoWA=;
        b=ebzSNdSwAU48NeNNgKVkzqVgvGfWfoMOVluZXsmraAJm1z0H9SPrcBXqgqyMAueok5
         83IXoVAu/07V5al+9IXfDy0YzbgGWhIU4dLvfzB6FGI1CHqzjzAWp11iMu5oK5CRYo+6
         8M0Oy34/b1H/8mnX8L2sV1AymMrJRMGp2MiMh3vvMnTSGrR7I33eOVx6gLOLN2FZLZno
         PyhjFboFfZCtwpZ3djoUiueS/cCThwGRyAfcSblBJZ5QquB1uOPxMyTXLJXsFGICkdBW
         7/b4BGkCQlkY57gHHatVKC+n4rfKh+cEECLWNiOoB+GrXZjKRtWfdUBljJ1Lmr3POkad
         lCGA==
X-Gm-Message-State: AJaThX4TjWd0ZN5MS2P390t6SGTSbWVpO6YpZbec0SjTeuInFlm6uZLP
        Ymmp805GGFsc2HmKgFPwig==
X-Google-Smtp-Source: AGs4zMayCwsUZrzJ1EnDgEohWQs0DZ2pbEUp5YuTAHb6WKZcvl+seHD3WYhgYLN4Q18fPOmXp+evPA==
X-Received: by 10.202.195.69 with SMTP id t66mr6497869oif.2.1512096057890;
        Thu, 30 Nov 2017 18:40:57 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id i31sm2510067otb.28.2017.11.30.18.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 18:40:57 -0800 (PST)
Date:   Thu, 30 Nov 2017 20:40:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Marco Franchi <marco.franchi@nxp.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] dt-bindings: Remove leading 0x from bindings notation
Message-ID: <20171201024056.ij4jg3cfwq474db3@rob-hp-laptop>
References: <20171129205515.9009-1-malat@debian.org>
 <c7200904-f016-8789-ee5e-fe5a281be215@caviumnetworks.com>
 <CA+7wUszQAjcOkaWyEhJ9GnqL0+PQOvsMx3rOaHMOnq_0HnUDeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUszQAjcOkaWyEhJ9GnqL0+PQOvsMx3rOaHMOnq_0HnUDeQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61258
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

On Thu, Nov 30, 2017 at 08:57:11AM +0100, Mathieu Malaterre wrote:
> Hi David,
> 
> On Thu, Nov 30, 2017 at 12:21 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> > On 11/29/2017 12:55 PM, Mathieu Malaterre wrote:
> >>
> >> Improve the binding example by removing all the leading 0x to fix the
> >> following dtc warnings:
> >>
> >> Warning (unit_address_format): Node /XXX unit name should not have leading
> >> "0x"
> >
> >
> > How does it fix the warnings?  You are not changing the .dts files that are
> > compiled.

If the examples were compiled, then they would have this warning...

> 
> I originally only wanted to fix [...]watchdog/ingenic,jz4740-wdt.txt,
> but when I lookup git log, I eventually found out about the commit I
> refer to in my commit message:
> 
> https://github.com/torvalds/linux/commit/48c926cd3414
> 
> and I simply followed suggestion from Rob:
> 
> https://lkml.org/lkml/2017/11/1/965
> 
> > This may also cause the binding documentation to differ from the reality of
> > what the actual device trees contain.
> 
> 
> Chicken or the egg dilemma, but you understand that linux master tree
> still has the original warning:
> 
> $ perl -p -i -e 's/\@0+([0-9a-f])/\@$1/g' `find ./ -type f \( -iname
> \*.dtsi -o -iname \*.dts \)`
> $ git diff | diffstat
> [...]
>  40 files changed, 160 insertions(+), 160 deletions(-)
> 
> And those are real W=1 actual warnings. Do you want me to re-submit it
> as patch series instead which fix both the documentation side and the
> dts* files ?

Some of those I skipped on purpose (they don't really follow standard 
unit-address), but I does look like some new ones got in. I'm not sure 
why I skipped PPC and xtensa altogether.

No need to fix everything, everywhere (but more patches always welcome 
:) ).

I'll apply this. Thanks. 

Rob
