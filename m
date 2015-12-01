Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 02:25:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34038 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006970AbbLABZt22tUl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2015 02:25:49 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tB11Pm78018422;
        Tue, 1 Dec 2015 02:25:48 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tB11PkLa018421;
        Tue, 1 Dec 2015 02:25:46 +0100
Date:   Tue, 1 Dec 2015 02:25:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: no-op delay loops
Message-ID: <20151201012546.GC23993@linux-mips.org>
References: <87si3rbz6p.fsf@rasmusvillemoes.dk>
 <3228673.rOyW85ILiP@wuerfel>
 <874mg3b2h5.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874mg3b2h5.fsf@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50246
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

On Mon, Nov 30, 2015 at 10:29:26PM +0100, Rasmus Villemoes wrote:

> OK, thanks. That's a very very long time ago.
> 
> FWIW, the remaining instances that my trivial coccinelle script found
> are

After your initial report I also wrote a coccinelle which is looking
also for delay loops implemented in while loops.  It found the following
two:

diff -u -p ./drivers/video/uvesafb.c /tmp/nothing/drivers/video/uvesafb.c
--- ./drivers/video/uvesafb.c
+++ /tmp/nothing/drivers/video/uvesafb.c
@@ -1142,7 +1142,6 @@ static int uvesafb_blank(int blank, stru
 		vga_wseq(NULL, 0x00, seq);
 
 		crtc17 |= vga_rcrt(NULL, 0x17) & ~0x80;
-		while (loop--);
 		vga_wcrt(NULL, 0x17, crtc17);
 		vga_wseq(NULL, 0x00, 0x03);
 	} else
diff -u -p ./arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c /tmp/nothing/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c
--- ./arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c
+++ /tmp/nothing/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c
@@ -37,7 +37,6 @@
 
 static void delay(int delay)
 {
-	while (delay--);
 }
 
 static void send_bit(unsigned char bit)

The 2nd file falls into my domain so I'm going to fix it.  Not sure
how the uvesafb one should be treated.

  Ralf
