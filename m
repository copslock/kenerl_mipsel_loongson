Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Dec 2010 21:40:57 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58731 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492014Ab0LJUky (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Dec 2010 21:40:54 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oBAKersN001498;
        Fri, 10 Dec 2010 20:40:53 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oBAKerxD001497;
        Fri, 10 Dec 2010 20:40:53 GMT
Date:   Fri, 10 Dec 2010 20:40:52 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2] MIPS: Alchemy: fix build with SERIAL_8250=n
Message-ID: <20101210204052.GA1274@linux-mips.org>
References: <1288025051-17145-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288025051-17145-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 25, 2010 at 06:44:11PM +0200, Manuel Lauss wrote:

> In commit 7d172bfe ("Alchemy: Add UART PM methods") I introduced
> platform PM methods which call a function of the 8250 driver;
> this patch works around link failures when the kernel is built
> without 8250 support.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> V2: added commit name to patch description as per Sergei's suggestion.

Applied, thanks.

Though anything like a CONFIG_SERIAL_8250 in board code always strikes me
as wrong.  What if the driver is built as a module?  What if the kernel is
built without the driver, then later on the module is built separately and
then inserted?

  Ralf
