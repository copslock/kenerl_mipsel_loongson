Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 15:05:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51980 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992314AbdKNOFfgfhn0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 15:05:35 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vAEE5Ybo014730;
        Tue, 14 Nov 2017 15:05:34 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vAEE5YAa014729;
        Tue, 14 Nov 2017 15:05:34 +0100
Date:   Tue, 14 Nov 2017 15:05:34 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: ath25: Avoid undefined early_serial_setup()
 without SERIAL_8250_CONSOLE
Message-ID: <20171114140534.GA14698@linux-mips.org>
References: <1510666157-27252-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510666157-27252-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Nov 14, 2017 at 01:29:17PM +0000, Matt Redfearn wrote:

> Currently MIPS allnoconfig with CONFIG_ATH25=y fails to link due to
> missing support for early_serial_setup():
> 
>   LD      vmlinux
> arch/mips/ath25/devices.o: In function ath25_serial_setup':
> devices.c:(.init.text+0x68): undefined reference to 'early_serial_setup'
> 
> Rather than adding dependencies to the platform to force inclusion of
> SERIAL_8250_CONSOLE together with it's dependencies like TTY, HAS_IOMEM,
> etc, just make ath25_serial_setup() a no-op when the dependency is not
> selected in the kernel config.

Looks like arch/mips/rb532/serial.c might be suffering from the same
issue?

  Ralf
