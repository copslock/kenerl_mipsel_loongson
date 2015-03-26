Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 16:09:14 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42075 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006155AbbCZPJMjhJ70 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 16:09:12 +0100
Received: from localhost (samsung-greg.rsr.lip6.fr [132.227.76.96])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5C65BB12;
        Thu, 26 Mar 2015 15:09:05 +0000 (UTC)
Date:   Thu, 26 Mar 2015 16:09:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 7/9] tty: Add MIPS EJTAG Fast Debug Channel TTY driver
Message-ID: <20150326150901.GA21726@kroah.com>
References: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
 <1422530054-7976-8-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1422530054-7976-8-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46549
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

On Thu, Jan 29, 2015 at 11:14:12AM +0000, James Hogan wrote:
> Add TTY driver and consoles for the MIPS EJTAG Fast Debug Channel (FDC),
> which is found on the per-CPU MIPS Common Device Mapped Memory (CDMM)
> bus.
> 
> The FDC is a per-CPU device which is used to communicate with an EJTAG
> probe. RX and TX FIFOs exist, containing 32-bits of data and 4-bit
> channel numbers. 16 general data streams are implemented on this for TTY
> and console use by encoding up to 4 bytes on each 32-bit FDC word.
> 
> The TTY devices are named e.g. /dev/ttyFDC3c2 for channel 2 of the FDC
> attached to logical CPU 3.
> 
> These can be used for getting the kernel log, a login prompt, or as a
> GDB remote transport, all over EJTAG and without needing a serial port.
> 
> It can have an interrupt to notify of when incoming data is available in
> the RX FIFO or when the TX FIFO is no longer full. The detection of this
> interrupt occurs in architecture / platform code, but it may be shared
> with the timer and/or performance counter interrupt.
> 
> Due to the per-CPU nature of the hardware, all outgoing TTY data is
> written out from a kthread which is pinned to the appropriate CPU.
> 
> The console is not bound to a specific CPU, so output will appear on the
> chosen channel on whichever CPU the code is executing on. Enable with
> e.g. console=fdc1 in kernel arguments. /dev/console is bound to the same
> channel on the boot CPU's FDC if it exists.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-mips@linux-mips.org

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
