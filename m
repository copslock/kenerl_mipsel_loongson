Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2015 23:55:30 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:45397 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007881AbbEaVz1g2po4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2015 23:55:27 +0200
Received: from localhost (p33062-ipbffx02marunouchi.tokyo.ocn.ne.jp [220.96.46.62])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8784B68;
        Sun, 31 May 2015 21:55:18 +0000 (UTC)
Date:   Mon, 1 Jun 2015 06:49:43 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Jiri Slaby <jslaby@suse.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v5 34/37] serial: 8250_ingenic: support for Ingenic SoC
 UARTs
Message-ID: <20150531214943.GA17410@kroah.com>
References: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
 <1432480307-23789-35-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432480307-23789-35-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47753
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

On Sun, May 24, 2015 at 04:11:44PM +0100, Paul Burton wrote:
> Introduce a driver suitable for use with the UARTs present in
> Ingenic SoCs such as the JZ4740 & JZ4780. These are described as being
> ns16550 compatible but aren't quite - they require the setting of an
> extra bit in the FCR register to enable the UART module. The serial_out
> implementation is the same as that in arch/mips/jz4740/serial.c - which
> will shortly be removed.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-serial@vger.kernel.org

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
