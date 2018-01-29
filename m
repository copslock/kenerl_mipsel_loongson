Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2018 21:28:04 +0100 (CET)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:64904 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994678AbeA2U14rK1lf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2018 21:27:56 +0100
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id A0F043F3B8;
        Mon, 29 Jan 2018 21:27:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id maBmuhFI_FM3; Mon, 29 Jan 2018 21:27:33 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id EC91F3F366;
        Mon, 29 Jan 2018 21:27:17 +0100 (CET)
Date:   Mon, 29 Jan 2018 21:27:16 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20180129202715.GA4817@localhost.localdomain>
References: <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk>
 <20170920145440.GB9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171111160422.GA2332@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej & Jürgen,

I have updated the PS2 patchset to v4.15 now. For the initial submission,
I'm hoping to include device drivers for USB and serial support. The first
20 or so patches are ready for review, with 5-10 additional patches needing
clean-ups.

USB maintainer Alan Stern has previewed the PS2 OHCI driver:

https://marc.info/?l=linux-usb&m=151198476018400

Simple devices such as a USB keyboard work. Jürgen Urban has reported
issues with USB mass storage devices, possibly due to lost interrupts.

I tried a wireless AR9271 USB device. It had at least two problems: First
error was "ath9k_htc: Unable to allocate URBs", due to the (very) limited
amount of reserved IOP memory (256 kb). I then adjusted a few hardcoded
ath9k_htc buffer limits. The following error was "ath9k_htc: Target is
unresponsive" which remains to investigate.

Jürgen: In ps2_uart.c for v4.15, the init_timer call needs to be replaced
with timer_setup.

Work in progress:

https://github.com/frno7/linux/tree/ps2-v4.15-n0

Fredrik
