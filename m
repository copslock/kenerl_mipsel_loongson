Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 16:43:08 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.135]:55603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012843AbcBPPmGIvCPn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 16:42:06 +0100
Received: from wuerfel.lan. ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPA (Nemesis) id 0Lvfyq-1ZvXbL3W6W-017XtC; Tue, 16 Feb
 2016 16:41:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 5/5] gpio: allow setting ARCH_NR_GPIOS from Kconfig
Date:   Tue, 16 Feb 2016 16:40:38 +0100
Message-Id: <1455637261-2920972-5-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455637261-2920972-1-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
X-Provags-ID: V03:K0:e9I4n9sy6PyfgfkQLus4LmFKwzxjGnLahn87Oh+4EEz/dEqZzmI
 LtnORHyhCGaFgmUaH5Ihrjgy7613+uzJecPpIVM2X+Xx8EcpoO9BD5nEgbnXW4tr0ewq7UK
 m5WTq6i2c2QuL9MfeyxJgpViae6H/T7kxu9Yu45wrUbtMwByfdIyIBjULFfEfyEVxlW4VXf
 DiYm2g/2zC+4bpKMDAVMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t6Cj3QeaQKw=:I+oXVxtRdcp0uPYz95qpLK
 G5wlMx5OOjmurCFCNs8JulEdslbXS6tP+F8HYlbpf9c2B8v7vHJvBDyz8rm3TMzEfufqtR63T
 25d+E3pDQYFchwhhdxtgfSZBG7klAZLQawXA9l39z0WUTwpRWtBTOyMyx3zlpZEXKbALutpGP
 Mw22GxLl6ZEXVP6YW0oZGGnGYuMTEYzVjdZBr7UCExWmvtVyJMOZDMO4psfHcRCackMtWz7rZ
 B08HEXwKfH4n83Hnjtft/zjqR3nzekQO96+0UEks/qqznwF8rASWSDI0uLDMEcqcZHLCpgpZD
 kbTkZgnNnGX4wpaK8oq3ZO+tC7uYHOdr7OUrsVdsnebR+WSyrQ9nSZp0S4mhTDMwUebEbvPYr
 2aWELeMj/dTrVCxaPRYFey48jJfJLdW531WHbGfwJIRcvwC8ukL7e7rZTKqTCl2Twtld+/mE6
 eR3y3Rfy41YxwCGxdbJnjekPuJXF92sfRRhsI0CWil4YW+LqoFWuQGoStsrqlPfmMgbAKSRq5
 jF/cwF+46TJABq72sMAoDidh0kk2tJZ2stCCSnwCrEEwysAwUDPBC0ldPQl+Ug01JNMiBhinS
 e6K8gmcLcmv5iQ8Z6ZKVBTwnIKMNuuBtiTKTeI1g8nZQDz2Ea8pkrSKAOPxMikAC5p7QFqeOI
 Mm+/hGhfN9B4ibsir0HPgBCCKP6MqzsBVcpI+SR34bWDoqQC2r3pt1NCqxdx1O1pVn9M=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52088
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

The ARM version of asm/gpio.h basically just contains the same definitions
as the gpiolib version, with the exception of ARCH_NR_GPIOS.

This adds the option for overriding the constant through Kconfig to
the architecture-independent header, so we can remove the ARM specific
file later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/gpio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 40ec1433f05d..8ca627dcea11 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -26,8 +26,12 @@
  */
 
 #ifndef ARCH_NR_GPIOS
+#if defined(CONFIG_ARCH_NR_GPIO) && CONFIG_ARCH_NR_GPIO > 0
+#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
+#else
 #define ARCH_NR_GPIOS		512
 #endif
+#endif
 
 /*
  * "valid" GPIO numbers are nonnegative and may be passed to
-- 
2.7.0
