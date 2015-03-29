Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2015 22:18:58 +0200 (CEST)
Received: from ftx-008-i773.relay.mailchannels.net ([50.61.143.73]:49770 "HELO
        relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S27010153AbbC2US51gxo8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Mar 2015 22:18:57 +0200
X-Sender-Id: duocircle|x-authuser|jac299792458
Received: from smtp2.ore.mailhop.org (ip-10-33-12-218.us-west-2.compute.internal [10.33.12.218])
        by relay.mailchannels.net (Postfix) with ESMTPA id 09346A0D16;
        Sun, 29 Mar 2015 20:18:54 +0000 (UTC)
X-Sender-Id: duocircle|x-authuser|jac299792458
Received: from smtp2.ore.mailhop.org (smtp2.ore.mailhop.org [10.83.15.107])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA)
        by 0.0.0.0:2500 (trex/5.4.8);
        Sun, 29 Mar 2015 20:18:54 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: duocircle|x-authuser|jac299792458
X-MailChannels-Auth-Id: duocircle
X-MC-Loop-Signature: 1427660334217:2523509780
X-MC-Ingress-Time: 1427660334217
Received: from pool-72-84-113-125.nrflva.fios.verizon.net ([72.84.113.125] helo=io)
        by smtp2.ore.mailhop.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.82)
        (envelope-from <jason@lakedaemon.net>)
        id 1YcJfZ-00007o-80; Sun, 29 Mar 2015 20:18:53 +0000
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 113E0805BE;
        Sun, 29 Mar 2015 20:18:50 +0000 (UTC)
X-Mail-Handler: DuoCircle Outbound SMTP
X-Originating-IP: 72.84.113.125
X-Report-Abuse-To: abuse@duocircle.com (see https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information for abuse reporting information)
X-MHO-User: U2FsdGVkX18/lF18355qH7pPOVxWHX7tN1oazabMCTE=
X-DKIM: OpenDKIM Filter v2.6.8 io 113E0805BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1427660330;
        bh=KPluKDP6G2rGuljjgPIqq5mLwq5o+QS7WJbpwXHignc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=paMLo4dpL6VaK1l4I7wv9a1TmlTXgPDKIGfJ3fIf7lETVT8TOJv/NBzH8A8Ka2EXU
         VKIlWInzEMLi4uHA+bh7y20LsBzrefvDtfckBKm8vjA+Nj+Cn4wNFUEk9dCNjYUDcN
         UPefGBSjPk/g6ZSM8JWZhMVythwEYTeKhVicg0thV9oooxOS60wqH77bgf3DVKSOKv
         s11FYvVN6mhHWzeXMJ7OEseGMnkh1j8pu9UWPDE48Smrs6HC6RmczNe3qxaDMotLki
         ErpRFVJSI7GuoGIDuDZ1wYf3YQtXmHsLgrdl6cT0ULmitKJAP+MW8we2HOZhgFmqCq
         HseU9XGaa3uLA==
Date:   Sun, 29 Mar 2015 20:18:49 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>, ralf@linux-mips.org,
        jaedon.shin@gmail.com, abrestic@chromium.org, tglx@linutronix.de,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 00/25] Generic BMIPS kernel
Message-ID: <20150329201849.GE25778@io.lakedaemon.net>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
 <5511E9A8.6090908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5511E9A8.6090908@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-AuthUser: jac299792458
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

On Tue, Mar 24, 2015 at 03:48:08PM -0700, Florian Fainelli wrote:
> On 25/12/14 09:48, Kevin Cernekee wrote:
> > V5->V6: Incorporate several fixes/enhancements from Jaedon Shin:
> > 
> >  - Fix register read/modify/write in RAC flush code.
> > 
> >  - Fix use of "SYS_HAS_CPU_BMIPS32_3300" Kconfig symbol.
> > 
> >  - Add base platform support for 7358 and 7362.
> > 
> > The DTS files follow Andrew Bresticker's new per-vendor directory layout.
> > 
> > This series applies on top of Linus' current head of tree.
> > 
> > Patch 01 (Fix outdated use of mips_cpu_intc_init()) is REQUIRED for 3.19
> > to fix a build failure seen in 3.19-rc.  The other patches can
> > be queued for 3.20 or later.
> 
> Jason, can you merge the irqchip patches through your tree? They still
> apply cleanly to your irqchip/core branch as of today, except the last
> one which has a small hunk to be fixed in drivers/irqchip/Makefile.

Shouldn't be a problem, but could you please have you or Kevin do a resend?

thx,

Jason.
