Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 15:20:26 +0100 (CET)
Received: from forward103p.mail.yandex.net ([IPv6:2a02:6b8:0:1472:2741:0:8b7:106]:60022
        "EHLO forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994718AbeCGOUTT3B7g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2018 15:20:19 +0100
Received: from mxback15g.mail.yandex.net (mxback15g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:94])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 89B3221830EE;
        Wed,  7 Mar 2018 17:20:13 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback15g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id p7sat8WTOO-KCluRPog;
        Wed, 07 Mar 2018 17:20:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1520432413;
        bh=hlG+E4Om6pSy4bthp67Gy4R0ylvN6YaPIUm5gjN3+bs=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ob38HZY7Gv9XLJ+x2R3SIbZNXcEkApT8mspbgifT0+EdAL2wJjqOpHKO144KSww9B
         IoTpOzy8Vso73r0OFmwAJK9MAmdImDfof9eK8e+Cfx63cfIUywRznFuyGRCXs/E9L1
         hoadIJiI4UPIl6lTLEAJFjRaosBV71Q4BOcz0el4=
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Q8TVNhMo6r-Jvgqj0f9;
        Wed, 07 Mar 2018 17:20:09 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1520432412;
        bh=hlG+E4Om6pSy4bthp67Gy4R0ylvN6YaPIUm5gjN3+bs=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=OF7x02S7TZBnpjzm79b6OUcrtl6JQ+09vjvXJCqjxRK+EUUP7EuqSgLaQ9pcJP0Mj
         SXmhh6zdj+gf58bdlT3R+JmxthJY22BhmxuKUH2b7U9GLZYMQ3XtYXnAbkjyo12gwd
         LUY8owQ1Brua0yYkWld7L1+P7iAkfomv+UhgqzOI=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1520432391.3731.8.camel@flygoat.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Date:   Wed, 07 Mar 2018 22:19:51 +0800
In-Reply-To: <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
         <20170927151527.25570-4-prasannatsmkumar@gmail.com>
         <20180306000832.GL4197@saruman>
         <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

在 2018-03-07三的 19:14 +0530，PrasannaKumar Muralidharan写道：
> 
> I used to get my code tested from Domink but I could not reach him
> for
> quite some time. Before buying the development board myself I would
> like to see if anyone can help me in testing. Do you have any contact
> with Ingenic who can help in testing this?
> 

Hi PrasannaKumar

I'm resently working on Ingenic chips too. Ingentic guys have sent me a
X1000 development broad and it will arrive in about two weeks. I have a
ejtag debugger also (but not very suit with X1000 because X1000 have
different ejtag interface with standard MIPS cores, maybe we need some
modification on openocd). So maybe I can help in testing this after I
get my broad. Just ask if you need any help.
Thanks
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>
