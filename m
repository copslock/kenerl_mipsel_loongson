Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 23:12:57 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:57435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008292AbcCAWMzmSFe- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 23:12:55 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0LzWb8-1Zo9VH3cQc-014mr6; Tue, 01 Mar
 2016 23:12:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: db1xxx: use correct irq_to_gpio helper
Date:   Tue, 01 Mar 2016 23:12:20 +0100
Message-ID: <1547427.xN2rd1Mon4@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:E9T8YCckIeAa0QfBdLlhdSY42DsBBXnnTWUlOyhKoP8Lbur+dWB
 2HBtY1ZTGen627qJk55/SzIacrXqtuQnrHa9cUX0jf2I/h9kyBFjWchppn5uf/MW8cDLzLr
 n9gLhKH96dXpUNFZvUVgEhjUNiUU18AD4CnKxAlOLtaGSTlH8VEJHRmRVKUPUT2S32JpcP2
 AEcUs9hHTAeUZplJ4enpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QXqx5hWdlRM=:zcYBtbtgNTXHObuWx+V9Bz
 pw0phVAHXJl1T01+VJmmMMU+9j8qEViyfVRLIFMYGEnRFx8eN3Oy4XYYZd3WEV7gifLb0vWxT
 r3sulsLyyxxFLLpyWROedXIzH4l7J9BL1+BHfy8NkMs/vX9GICtp0hNI9nbdgqwsD2d75yZtM
 7bGTdCHEW4SzDIyz+2rd+In4e/QufV6HJ5oebCDpy0WUxQKS7Q5BEthcQ2PyGhY4vkiIQcL5u
 xNZwbRoWJAJEK0p81mLN9s+LtMMyE4vd50At9CzlT6DJdkkktYwSN+eLs1762v/pYpTKeMZdL
 uRZwMMc+YdW9E2WpQzfNDjUu43LmjOArWHAtAKGs63CqNUtd5DL7t4CGOvyoUzVzZx0F5Yuw0
 UvecWNbzOLgEO3P8KZZB/AhR2tzDH/9r9bDHxm++EZV5PafREgY+cseA2dNTXac7lmMrhkxjy
 giVVNCTb7/0UxoKgeuwjY8kP0tqzU8N4TG8SWq2hiEtHoUnjBrOK25TnVsX17qoO7h8T5B3Fx
 2BfQum+FQolo43As0gKXYufZ/ySbQJASidGE0rndSGtQh+z3EkQzte3HfJLte4AFdpKsCKJ31
 Nm4qiOSySPA50rhe5bjSk2H/3n5fNbFowf210j2+wZYg72PvHjPjLMaQ4HM0NioZ3kHCo/b6b
 GsTST1qd0M5LKeQynGYrfxbmvvJVXd2VdSsXJYwz5vyMZEK4zzNlHY+omenFwWxqh2doAhHqI
 L/47Lz+C0P6vBOpj
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52388
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

After the removal of asm/gpio.h and asm/mach-au1x00/gpio.h, the db1xxx_ss
pcmcia driver picked up the wrong irq_to_gpio function from the generic
headers.

This restores the old __au_irq_to_gpio() implementation, but keeps
it local to the only file that uses it.

It would be nicer to just pass the gpio number from platform code,
but restoring the previous implementation seems safer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org # v4.3
Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
---
I think this is now the last holdout of the irq_to_gpio function,
and it's been broken for a while. Maybe Ralf can queue it up through
the MIPS tree along with the other fix for irq_to_gpio?

Linus, maybe you can queue up the include/linux/gpio.h change to
remove the function as well for 4.6. We have two users of this function
on MIPS that are already broken, and adding the patch turns the
runtime bug into a compile-time bug, which seems like a good thing
to me. The other patch is already queued in the mips tree.

diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 4c2fa05b4589..41f28879bfef 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -35,6 +35,19 @@
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-au1x00/gpio-au1000.h>
+#include <asm/mach-au1x00/gpio-au1300.h>
+
+static inline int __au_irq_to_gpio(unsigned int irq)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000...ALCHEMY_CPU_AU1200:
+		return alchemy_irq_to_gpio(irq);
+	case ALCHEMY_CPU_AU1300:
+		return au1300_irq_to_gpio(irq);
+	}
+	return -EINVAL;
+}
 
 #define MEM_MAP_SIZE	0x400000
 #define IO_MAP_SIZE	0x1000
@@ -83,7 +96,7 @@ static int db1200_card_inserted(struct db1x_pcmcia_sock *sock)
 /* carddetect gpio: low-active */
 static int db1000_card_inserted(struct db1x_pcmcia_sock *sock)
 {
-	return !gpio_get_value(irq_to_gpio(sock->insert_irq));
+	return !gpio_get_value(__au_irq_to_gpio(sock->insert_irq));
 }
 
 static int db1x_card_inserted(struct db1x_pcmcia_sock *sock)
