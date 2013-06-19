Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 12:00:30 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:52449 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818476Ab3FSKA2eXU1W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 12:00:28 +0200
Received: from wuerfel.localnet (HSI-KBW-095-208-002-043.hsi5.kabel-badenwuerttemberg.de [95.208.2.43])
        by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
        id 0LgjGE-1UUofJ0kSs-00niDH; Wed, 19 Jun 2013 12:00:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Date:   Wed, 19 Jun 2013 12:01:06 +0200
Message-ID: <2302882.NVjP8DdXWY@wuerfel>
User-Agent: KMail/4.10.3 (Linux/3.9.0-2-generic; KDE/4.10.4; x86_64; ; )
In-Reply-To: <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com> <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:mzmZ9+bBWurp4/xnwCM5dwHtFCAcxYpyIoJpQwkoytV
 0VXYdcNHpridv+kXgnFk9f00byrFBKJQGQv5iJrXUWBxNyrg1K
 sy0CQMAFpPsiXF/+QHCiMWRpsVys6sGl7eyXfqVe3TWcRXnExp
 thBu9Z/Vpx8Gb33m3ZAAd/Y8f0IXo3fjneWUAUDM0FcGuL4CXg
 HvZ2KxnimvU9BQiMwDo6fy8n98NBlrKmV3SbJYeKpoNlc02+Xe
 vYArhr0lhLJHH9ww+65tBOBETojTaOSshpjIywZE0h4opxFJP8
 aAiPRSOD3jiysE75iAJ8mcl1Wit4kPvctBRpJ8U4H8AqPJ6rKo
 HcVFLZ0qFQ0wfakU8Fa4=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37007
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

On Tuesday 18 June 2013 12:12:53 David Daney wrote:
> +static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
> +{
> +       offset <<= p->regshift;
> +
> +       return (u8)__raw_readq(p->membase + offset);
> +}
> +
> +static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
> +{
> +       struct dw8250_data *d = p->private_data;
> +
> +       if (offset == UART_LCR)
> +               d->last_lcr = value;
> +
> +       offset <<= p->regshift;
> +       __raw_writeq(value, p->membase + offset);
> +       dw8250_serial_inq(p, UART_LCR);
> +}

This breaks building on 32 bit architectures as I found on my daily ARM
builds: __raw_writeq cannot be defined on architectures that don't have
native 64 bit data access instructions. It's also wrong to use the
__raw_* variant, which is not guaranteed to be atomic and is not
endian-safe.

	Arnd
