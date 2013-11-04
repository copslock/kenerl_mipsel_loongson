Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2013 18:13:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44483 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6826046Ab3KDRNrdIZYr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Nov 2013 18:13:47 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id rA4HDXNq024570;
        Mon, 4 Nov 2013 18:13:34 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id rA4HDST5024563;
        Mon, 4 Nov 2013 18:13:28 +0100
Date:   Mon, 4 Nov 2013 18:13:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] video/logo: Remove MIPS-specific include section
Message-ID: <20131104171327.GS1615@linux-mips.org>
References: <1383554550-20901-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1383554550-20901-1-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38448
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

On Mon, Nov 04, 2013 at 09:42:30AM +0100, Geert Uytterhoeven wrote:

> Since commit 41702d9a4fffa9e25b2ad9d4af09b3013fa155e1 ("logo.c: get rid of
> mips_machgroup") there's no longer a need to include <asm/bootinfo.h> on
> MIPS.

Yes,

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Generally CONFIG_<ARCH> should probably be considered a bug even if only
it's used to hide crap like this.

  Ralf
