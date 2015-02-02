Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 17:32:41 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36235 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012407AbbBBQcjWVF3A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 17:32:39 +0100
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DC998AFB;
        Mon,  2 Feb 2015 16:32:32 +0000 (UTC)
Date:   Mon, 2 Feb 2015 08:32:32 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 26/36] serial: 8250_jz47xx: support for Ingenic jz47xx
 UARTs
Message-ID: <20150202163232.GA7055@kroah.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
 <1421620881-25136-1-git-send-email-paul.burton@imgtec.com>
 <20150130233105.GA10564@kroah.com>
 <54CFA5BC.2070103@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54CFA5BC.2070103@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Mon, Feb 02, 2015 at 04:28:44PM +0000, Zubair Lutfullah Kakakhel wrote:
> Hi Greg,
> 
> On 30/01/15 23:31, Greg Kroah-Hartman wrote:
> > On Sun, Jan 18, 2015 at 02:41:21PM -0800, Paul Burton wrote:
> >> Introduce a driver suitable for use with the UARTs present in
> >> Ingenic jz47xx series SoCs. These are described as being ns16550
> >> compatible but aren't quite - they require the setting of an extra bit
> >> in the FCR register to enable the UART module. The serial_out
> >> implementation is the same as that in arch/mips/jz4740/serial.c - which
> >> will shortly be removed.
> >>
> >> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Lars-Peter Clausen <lars@metafoo.de>
> >> Cc: linux-serial@vger.kernel.org
> >> ---
> >>  drivers/tty/serial/8250/8250_jz47xx.c | 228 ++++++++++++++++++++++++++++++++++
> >>  drivers/tty/serial/8250/Kconfig       |   8 ++
> >>  drivers/tty/serial/8250/Makefile      |   1 +
> >>  3 files changed, 237 insertions(+)
> >>  create mode 100644 drivers/tty/serial/8250/8250_jz47xx.c
> > 
> > This patch blows up on x86 systems, breaking the build :(
> 
> Ouch.
> 
> Did you compile after all the patches applied? Or after every single patch.

After every individual patch, like is required :)

> I can't manage to reproduce the build error with all of them applied.

Try it with just this one patch applied.

thanks,

greg k-h
