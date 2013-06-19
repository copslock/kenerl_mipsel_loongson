Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 12:53:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50334 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823118Ab3FSKxLicnGg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jun 2013 12:53:11 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5JAr5Sn014130;
        Wed, 19 Jun 2013 12:53:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5JAr0w1014129;
        Wed, 19 Jun 2013 12:53:00 +0200
Date:   Wed, 19 Jun 2013 12:52:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Message-ID: <20130619105259.GC9448@linux-mips.org>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
 <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
 <2302882.NVjP8DdXWY@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2302882.NVjP8DdXWY@wuerfel>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37008
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

On Wed, Jun 19, 2013 at 12:01:06PM +0200, Arnd Bergmann wrote:

> This breaks building on 32 bit architectures as I found on my daily ARM
> builds: __raw_writeq cannot be defined on architectures that don't have
> native 64 bit data access instructions. It's also wrong to use the
> __raw_* variant, which is not guaranteed to be atomic and is not
> endian-safe.

I've dequeued the series from the mips-next tree until David has a chance
to fix this.

  Ralf
