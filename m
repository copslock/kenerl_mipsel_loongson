Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 02:57:49 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:38826 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493649AbZLBB5q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 02:57:46 +0100
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
        by smtp6-g21.free.fr (Postfix) with ESMTP id E4109E08033;
        Wed,  2 Dec 2009 02:57:37 +0100 (CET)
Received: from [127.0.0.1] (sakura.staff.proxad.net [213.228.1.107])
        by smtp6-g21.free.fr (Postfix) with ESMTP id A5D84E08030;
        Wed,  2 Dec 2009 02:57:33 +0100 (CET)
Subject: Re: BCM63xx merge progress
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Hector Martin <hector@marcansoft.com>
Cc:     Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
In-Reply-To: <4B15B40D.70006@marcansoft.com>
References: <4B15974E.1060505@marcansoft.com>
         <1259709927.2926.608.camel@sakura.staff.proxad.net>
         <4B15B40D.70006@marcansoft.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 02 Dec 2009 02:57:32 +0100
Message-ID: <1259719052.2452.26.camel@kero>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Wed, 2009-12-02 at 01:25 +0100, Hector Martin wrote:

> Well, there's a commit (4059ddb4) that claims to "Add USB OHCI support",
> yet it only adds a #include to ohci-hcd.c and a few .h bits. The actual
> ohci-bcm63xx.c is missing, which means the OHCI driver probably won't
> even compile. It's also missing the relevant platform device stuff in

I cannot find this commit in linus' tree nor linux-mips master, where
does it come from ?

The remaining two patches that were not merged in 2.6.32 are on top of
this tree: http://www.linux-mips.org/git?p=linux-bcm63xx.git

They should apply with little difficulty on current upstream kernel and
besides the *_be stuffs that need to be cleaned up, they were ACKed by
the usb maintainer.

-- 
Maxime
