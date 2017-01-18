Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 17:51:31 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.133]:63091 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991965AbdARQvWcTa9d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 17:51:22 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LtjF3-1cbHOB2Ji1-011Ehp; Wed, 18 Jan 2017 17:50:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alban Bedel <albeu@free.fr>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] MIPS: zboot: fix 'make clean' failure
Date:   Wed, 18 Jan 2017 17:50:02 +0100
Message-Id: <20170118165025.3844642-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:algUjKVOu42Y8/s6KLEbiVRJvZDlz0LnqoSR2BtRoJNDPY8ckTY
 Kj/Se61/fueJYUbQkAql7ZNivcrlxAamTp7pmkMhRDqsJTkiCgQKRTbNb+C7M/airfJgWxI
 AIQDNzJCDTTZbZzHkkF9lA4Bd35P5o51wLg0qGGfYy0oVq4/kseNa5YKflsolkDYZZb4veB
 SqNlskqRPp5NhE4RgijcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6h+KhveWM18=:CuY3dhyzC1NMtv1hT9a9rl
 Uec+SNzQZGPv1MEYzIB8tJu9MTF9FUALy3MZ75DKThmoHC9Sts+PalZJf4nukkFuprmkv6PBa
 dNdPPRg0N+r4+vb66pIkAEtUCrkqaUB2CBD5khC+JDbXow3dEi5+1/hPDPNZUl3DHOjjb0kP1
 WUr2NanCG3768DZAiNMuJ6By9wayQcsl524q8rXcJjfD003ZI2UrxmIK7GMjWuooVYq5yQNW/
 9PO4JHw5ZPZeaXkyjP7ccZqYp5V//Sv3+1Oc8LNSuqAg1TyWVeY7d8K6p4CyXjSCuQDI3+kn5
 csraZGKjNP67gVFfDWgsm6OsGEHIDXj7EgrJ+DcrBkzE7I1EXfIWbR0qnOowZNpe5eEeFs229
 VBk8Pb9uepiPRikF9wSlBv4qewSg7wLNPW6UbSGa/4T8jJuD8xFzKRA/bu7yyXxWrJM4na1c5
 HMvyxfFBsckKjAgRO5PdWYCWxS7P9D2harmAg0VYbf+lXHTocu4YdGcEl/rZdUzxF9844Ul2P
 IlsVySjH0f6qVVVA8U2cR0xG9hbIoY5QVIc3aN1GgyisLE7WlMd055il8X4ZikAUhHWXhyOo8
 s0yq+Gfudf8U5zWgQ3fkG98lMJcBfFinotEIvjrjCKmBeT8zW4b9iB/5QpnhBWP6ZwkcNwZBQ
 8DTh/O/E1JbRflGLHRVWcfRFxUkH/WwFGQjucRwBamIl1bS+zK73XAtFMs7STqx/MryU=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56395
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

The filter-out macro needs two arguments, passing only one is
clearly the result of a typo that leads to 'make clean' failing
on MIPS:

arch/mips/boot/compressed/Makefile:21: *** insufficient number of arguments (1) to function 'filter-out'.  Stop.

Fixes: afca036d463c ("MIPS: zboot: Consolidate compiler flag filtering.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: remove stale unrelated change
---
 arch/mips/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 608389a4a418..c675eece389a 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -18,7 +18,7 @@ include $(srctree)/arch/mips/Kbuild.platforms
 BOOT_HEAP_SIZE := 0x400000
 
 # Disable Function Tracer
-KBUILD_CFLAGS := $(filter-out -pg $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
 
 KBUILD_CFLAGS := $(filter-out -fstack-protector, $(KBUILD_CFLAGS))
 
-- 
2.9.0
