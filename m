Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2016 23:32:56 +0100 (CET)
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:47857 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010164AbcAFWcyJxt04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jan 2016 23:32:54 +0100
Received: from localhost.localdomain (proxy [81.2.110.250])
        by lxorguk.ukuu.org.uk (8.15.2/8.14.1) with ESMTP id u06N5XMH012644;
        Wed, 6 Jan 2016 23:05:38 GMT
Date:   Wed, 6 Jan 2016 22:32:47 +0000
From:   One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To:     <Paul.Thacker@microchip.com>
Cc:     <Joshua.Henderson@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <Andrei.Pistirica@microchip.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 10/14] serial: pic32_uart: Add PIC32 UART driver
Message-ID: <20160106223247.409a1d2b@lxorguk.ukuu.org.uk>
In-Reply-To: <F2D704DDA6AE8B4A87FF87509480F4A449E46187@CHN-SV-EXMX01.mchp-main.com>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
        <1450133093-7053-11-git-send-email-joshua.henderson@microchip.com>
        <20160105204322.2dc5ab3f@lxorguk.ukuu.org.uk>
        <F2D704DDA6AE8B4A87FF87509480F4A449E46187@CHN-SV-EXMX01.mchp-main.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.29; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnomes@lxorguk.ukuu.org.uk
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

On Wed, 6 Jan 2016 22:00:43 +0000
<Paul.Thacker@microchip.com> wrote:

> On 01/05/2016 03:50 PM, One Thousand Gnomes wrote:
> >
> >> +#define PIC32_SDEV_NAME		"ttyS"
> >> +#define PIC32_SDEV_MAJOR	TTY_MAJOR
> >> +#define PIC32_SDEV_MINOR	64
> >
> > No. Same goes for you as every one of the forty other people a year who
> > try and claim their console is ttyS. If it's not an 8250 it isn't.
> >
> > ttyS is the 8250, use dynamic major and minor and a different name.
> 
> Ok. Is there a naming convention documented anywhere? How about ttyPIC?

We used to document it but the document was always stale. ttyPIC sounds
fine providing nobody else is using it (and I don't think they are but
grep is your friend). We enforce the rule because in the early days lots
of people re-used ttyS for their chip. Then their chip grew an external
bus or turned into a SoC and a 16x50 got added and it all broke.

ttyPIC ought to be fine because even if you get new PIC devices with a
different uart you aren't likely to have both of the PIC cores on the
same device.

Alan
