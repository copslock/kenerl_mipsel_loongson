Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:22:04 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.134]:59142 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993894AbdAQPVHf57Cd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:21:07 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Mc5lW-1cAK0e1opi-00JI3H; Tue, 17 Jan 2017 16:20:14 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] MIPS: ralink: remove unused timer functions
Date:   Tue, 17 Jan 2017 16:18:41 +0100
Message-Id: <20170117151911.4109452-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:EyEqk4/10aDy8fcKsBtQoZdlbCrXPDckImT2fHLJz1ah6gANbX/
 homnDr6b6M81ZTGDSnGXS9GF2f3IeF9lo81jID1DJylHRMs3z7vMX8OWUFMkOBP34l0nqbv
 g/efNiXSdIH9JgoxAKIMxjBF2QmAsj/3tgz5LODGxQhjIy08L+h/D7V6uJIvZ69towipd6l
 ervwCSdvCxcwKUp2TAbIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MXVUpOCyxl0=:Dofu9A+C0XrKemYZsH9uo2
 fCq++CmpZnL3ZWPfSI68qT13A/bc48uOIlfabCm/GJwME6nn1Uhb2BzWLMrjTQTcSvDTGaSR8
 Vz5A+4tlA/SxngAL3Fr+4UzZFjdxSv2g3zHkHGo46rBe8UH3tT73AYRNZuFuzo/Drb+TWQLHA
 PhHzOYfPDWhchylkfzucpCz+7OZzvLUQl8CeEnGkzYf0Ybp49W4Orycrg/4J0K3Hm41xn9q+V
 5sgFilv4SSuNMV7wZCr02rjvf/hJL8VlMKdlZalVpPF47WM6fVYOj6gek9pOJQ8iOzOd2xy41
 Um5a6GVDTDRafae1Nlgtw2vC5Vam4bXf4Sd/Jcf1079pZy8Dnvf91hxLxHpvFCrtTaTCGHGRW
 INh4hkVR+yXrOf39xyfTqFb5DnFewI7oaKVC/GOIIior0xtg1dWRU+j67X6LQwRXDbcMobEBj
 JEeojys4fJf+2aM4qx0X/rD59CtPCI3dF/giqLyPRD+Jb8qmLmTKrl/cPqvdUciTHTabKPG2d
 bzZOhLv9Xp8VUtG1+KvF7alnLCDowQL4zSJ5nsGPEmumJayVISf0U6S5wV999OpuZl56rJAsR
 Ljn7Uupfjj5UtPXPA0mXF79DxVHFJfzdmuBARvUgDYS+E6nIpZEJ6SjYKbqdFZ04V13/LN+g1
 WKTsGIgxNH+G+5ywUCnaDuX0pUxQjZDsXLzdaGn0y3llGq8Uhoqb0kxima/RWDJNYLIA=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56347
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

The functions were originally used for the module unload path,
but are not referenced any more and just cause warnings:

arch/mips/ralink/timer.c:104:13: error: 'rt_timer_disable' defined but not used [-Werror=unused-function]
arch/mips/ralink/timer.c:74:13: error: 'rt_timer_free' defined but not used [-Werror=unused-function]

Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Fixes: 62ee73d284e7 ("MIPS: ralink: Make timer explicitly non-modular")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/ralink/timer.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index 8077ff39bdea..d4469b20d176 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -71,11 +71,6 @@ static int rt_timer_request(struct rt_timer *rt)
 	return err;
 }
 
-static void rt_timer_free(struct rt_timer *rt)
-{
-	free_irq(rt->irq, rt);
-}
-
 static int rt_timer_config(struct rt_timer *rt, unsigned long divisor)
 {
 	if (rt->timer_freq < divisor)
@@ -101,15 +96,6 @@ static int rt_timer_enable(struct rt_timer *rt)
 	return 0;
 }
 
-static void rt_timer_disable(struct rt_timer *rt)
-{
-	u32 t;
-
-	t = rt_timer_r32(rt, TIMER_REG_TMR0CTL);
-	t &= ~TMR0CTL_ENABLE;
-	rt_timer_w32(rt, TIMER_REG_TMR0CTL, t);
-}
-
 static int rt_timer_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.9.0
