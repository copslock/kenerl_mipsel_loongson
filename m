Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 20:52:29 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.186]:63311 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824790Ab3FSSw1z20ib (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 20:52:27 +0200
Received: from klappe2.localnet (HSI-KBW-095-208-002-043.hsi5.kabel-badenwuerttemberg.de [95.208.2.43])
        by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
        id 0MAAX7-1V03ff48PR-00BW01; Wed, 19 Jun 2013 20:52:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Date:   Wed, 19 Jun 2013 20:52:09 +0200
User-Agent: KMail/1.12.2 (Linux/3.8.0-22-generic; KDE/4.3.2; x86_64; ; )
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com> <2302882.NVjP8DdXWY@wuerfel> <51C1E028.2040700@caviumnetworks.com>
In-Reply-To: <51C1E028.2040700@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201306192052.09575.arnd@arndb.de>
X-Provags-ID: V02:K0:ZbYxcUpUyS76u1/rRQTN2kLUR9D28x30SfPTuHYQJER
 WAFUaIwoHq3z+luwzRdlpp7McZt5/snat/+Nntz4UUqTlUBT8F
 ovyG2KZm46NCfQeflT6Bq8fFCtUafbK/VOf8SeApbhTeOIgkBK
 lb7gyNWg20jZSqA06ji8eXWzRPhRDbCqyEXq+npMqI6MfmJy4H
 9vHmMBFpFQPQDQBGEob+y9wwQQE98q8m3NbiXXVkrZFVJGszWk
 ARX7qQt8QV8Ido5qrlh5Na+Pxi9SaJnrLWM8hj4WsVh5VCTF8s
 WnwtkBPBtxQ+TREcDmn1fKVk6wqabG2T7MNRxHyFmoVg8XdLhw
 dXINtU6n9qW41CcX9DQk=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 19 June 2013, David Daney wrote:
> On 06/19/2013 03:01 AM, Arnd Bergmann wrote:

> > It's also wrong to use the
> > __raw_* variant, which is not guaranteed to be atomic and is not
> > endian-safe.
> 
> We do runtime probing and only use this function on platforms where it 
> is appropriate, so atomicity is not an issue.  As for endianess, I used 
> the __raw_ variant precisely because it is correct for both big and 
> little endian kernels.

You don't know what the compiler turns a __raw_writeq into, it could
always to eight byte wise stores, that's why typically writeq is
an inline assembly while __raw_writeq is just a pointer dereference.

__raw_* never do endian swaps, so it will be wrong on either big-endian
CPUs or on little-endian CPUs, depending on what the MMIO register
needs.

	Arnd
