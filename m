Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Aug 2014 10:32:52 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41507 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006602AbaHWOtxo0STd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Aug 2014 16:49:53 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 1F91C287B87;
        Sat, 23 Aug 2014 16:49:42 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qa0-f52.google.com (mail-qa0-f52.google.com [209.85.216.52])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D1D75289D11;
        Sat, 23 Aug 2014 16:49:02 +0200 (CEST)
Received: by mail-qa0-f52.google.com with SMTP id j15so10575971qaq.25
        for <multiple recipients>; Sat, 23 Aug 2014 07:49:12 -0700 (PDT)
X-Received: by 10.140.41.38 with SMTP id y35mr16598264qgy.69.1408805352634;
 Sat, 23 Aug 2014 07:49:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.84.244 with HTTP; Sat, 23 Aug 2014 07:48:52 -0700 (PDT)
In-Reply-To: <201408231556.42571.arnd@arndb.de>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
 <CAL1qeaGb-o0P7x4nZPJ+dGfoSKz+2ANrB0gGrBi19TtPxVTAZQ@mail.gmail.com>
 <20140823063113.GC23715@localhost> <201408231556.42571.arnd@arndb.de>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sat, 23 Aug 2014 16:48:52 +0200
Message-ID: <CAOiHx=noe=614vv4GyhuvfoAYj0jYDhO5vX+7M2RbQBpE-uPnQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>,
        Andrew Bresticker <abrestic@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Sat, Aug 23, 2014 at 3:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Another argument is that we plan to actually move all the dts files out of
> the kernel into a separate project in the future. We really don't want to
> have the churn of moving all the files now when they get deleted in one
> of the next merge windows.
>
> I don't know if we talked about whether that move should be done for
> all architectures at the same time. If that is the plan, I think it
> would be best to not move the MIPS files at all but also wait until
> they can get removed from the kernel tree.

I wonder how this is supposed to work with dtbs that are currently
expected to be built into the kernel?


Jonas
