Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:24:06 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:57358 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993904AbdAQPVOEnBWd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:21:14 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MK9VV-1cSgCt3ltF-001Tuy; Tue, 17 Jan 2017 16:20:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] MIPS: alchemy: remove duplicate initializer
Date:   Tue, 17 Jan 2017 16:18:39 +0100
Message-Id: <20170117151911.4109452-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:thL/99O5as/oSEL5+hSWTzzDQPkMITDgVPLX0E2ewYXXicsm4Wn
 Y3DKczXzrMcZSncRNGa/bAUr6FMs/GXSut9RJ+HmmCI0hoHf68iR0YaxyiZ1TErGVtYJY0Y
 2kubQM8h9uJsvA7YlAUAHNZUa3z2bzYgfmO1qiYPMr4QtviPfmeF/p4UXNCEymzHeww33th
 m3RG5boMhyap0S/Fe2JCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k2CpQwgLsG0=:g0Xc2ugONSUTa5OasoAARE
 FMEQUTuTuxDOc7Vlt2khWQtUgYmsoSy42BgC0FCd84YpG5V20EycwZl0aY3mV4+N16ZJoivYb
 CshTQpAb4y6f268oJWzBWqrKhhrWtO6kBK3ibXcyefTd5cVlSo/pdBbV8T1QDcMmMh2G0Zzzs
 Wvw38VtHxyvGuze1ZUjbmhTNJq+/pNLL0OugUifhV058LTWP/dokvX/SGikPXNFfzXGYCLdQ5
 HAjwnyJn/efij27UoLWN+QwK99tCUNIY5ArGSrIJSEPkGdbCAsZAdcjObv7BEnPsOLvyEEIQy
 5iGGD2q81I+K6872NCgJ7ZuiRNmhqgA6+T9G9Etynh9jhdby7q2O6nn86v1tv70aAdieoS/nS
 +88yrEKTXsFplY298q9Kn/JSqYQ1K2QULxROZ6S6wS7VP4pIfqAOQFB7qydtOC1xqokwgCUqo
 tzHD4KXbgeubf7EPbdCR2u5T1cwsNRkzVf3m0SNaqJGx+fhA2NkttlWbnHTAT+njYrfXNX/PK
 ugGLN1eW9DIU4cJEyPmdqxt3y4P0iqjVtk/+XV6kQrxqbMTzfBPtPUtQP9XeiVRmOGWrYaELl
 iHCPEJtphCGniRoOyDVm9kkh+XasH+xdG8JG2fcmvBJlMdneFdxoldenyXxkUHYPEPeEnr6/6
 pMASFB0mQ+D1i6QAoECju5ogmzewXvaVpN3JPEoIqaeWhGEzUYBHoqItoan4VYcmzGdg=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56352
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

We get a harmless warning about a duplicate initalizer for the
i2c board info structure:

arch/mips/alchemy/board-gpr.c:239:11: error: initialized field overwritten [-Werror=override-init]

As both initializers have the identical value, we can simply drop
the second one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/alchemy/board-gpr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index 79efe4c6e636..6fb6b3faa158 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -236,7 +236,6 @@ static struct platform_device gpr_i2c_device = {
 static struct i2c_board_info gpr_i2c_info[] __initdata = {
 	{
 		I2C_BOARD_INFO("lm83", 0x18),
-		.type = "lm83"
 	}
 };
 
-- 
2.9.0
