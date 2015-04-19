Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 13:51:16 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:20379 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007043AbbDSLvOjcmco convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Apr 2015 13:51:14 +0200
Received: from tock (unknown [85.177.79.58])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8F0E9940069;
        Sun, 19 Apr 2015 13:48:44 +0200 (CEST)
Date:   Sun, 19 Apr 2015 13:50:55 +0200
From:   Alban <albeu@free.fr>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATH] MIPS: ath79: Add OF support and DTS for TL-WR1043ND
Message-ID: <20150419135055.7f14f014@tock>
In-Reply-To: <5532BF90.2040907@gmail.com>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
        <5532BF90.2040907@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sat, 18 Apr 2015 13:33:20 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> Le 17/04/2015 07:24, Alban Bedel a écrit :
> > This series add OF bindings and code support for the interrupt
> > controllers, clocks and GPIOs. However it was only tested on a
> > TL-WR1043ND with an AR9132, others SoCs are untested, and a few are
> > not supported at all.
> > 
> > Most code changes base on the previous bug fix series:
> > [PATH] MIPS: ath79: Various small fix to prepare OF support
> 
> Any reasons why Gabor Juhos is not CC'd on these patches?

Because get_maintainer.pl didn't return him, I'll add him from now on.

Alban
