Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 09:36:13 +0100 (CET)
Received: from smtp1-g21.free.fr ([212.27.42.1]:27644 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010629AbcBOIgLn00El (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Feb 2016 09:36:11 +0100
Received: from tock (unknown [78.54.121.46])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 9A75694003C;
        Mon, 15 Feb 2016 09:33:44 +0100 (CET)
Date:   Mon, 15 Feb 2016 09:36:01 +0100
From:   Alban <albeu@free.fr>
To:     Marek Vasut <marex@denx.de>
Cc:     Aban Bedel <albeu@free.fr>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 05/10] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop
 unused alias node
Message-ID: <20160215093601.1d1ae6c8@tock>
In-Reply-To: <56C0851D.5090105@denx.de>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
        <1455400697-29898-6-git-send-email-antonynpavlov@gmail.com>
        <56C0851D.5090105@denx.de>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52054
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

On Sun, 14 Feb 2016 14:46:05 +0100
Marek Vasut <marex@denx.de> wrote:

> On 02/13/2016 10:58 PM, Antony Pavlov wrote:
> > The TP-LINK TL-WR1043ND board has only one serial port,
> > so replacing the default of 0 with 0 does nothing useful.
> 
> I'd suggest to keep the aliases node, since it can be used by other
> non-Linux systems to access the serial port 0 . This might be useful in
> case you add some additional UART chip(s) too.

I have no strong preference, the DT people preferred to see it removed
has it had been never used. I agree other systems might need it, but if
you hack the board to add some stuff you will need your own DTS. So it
make no sense to take such eventual hack in consideration here.

Alban
