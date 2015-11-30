Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 22:45:14 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.75]:62548 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007995AbbK3VpMvORFY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 22:45:12 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0Lvk1k-1aM4o41RyG-017YuO; Mon, 30 Nov
 2015 22:45:00 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: no-op delay loops
Date:   Mon, 30 Nov 2015 22:44:56 +0100
Message-ID: <4521348.97HWjoEYIi@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <874mg3b2h5.fsf@rasmusvillemoes.dk>
References: <87si3rbz6p.fsf@rasmusvillemoes.dk> <3228673.rOyW85ILiP@wuerfel> <874mg3b2h5.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:EuU5lMeI8EN6TyrjZTOQfCzdS4K5LhhtlgfeLVuZCoQN9vue2ag
 /KjaqAs1lHANlsHZlPxx28eSc0CYGzm7TTSH7sauAMofrWgWbLRct/1hXA+8ZqUYB4T4oj8
 +ViHoQjC3e589zojvFFKHWhPouB02mZr+7CnA27PKI4IcANWI8XfOWGVYPdff18y4Mz20Bp
 8SOKs1tWH3mtquZ7qdF5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dOMKmQFlMjE=:Fyd2wR1F/XmP7HSbW3wtFl
 +eDJfpt/LLIJJk5IBXJo0DHL4ponePvNCacazjBLV8m4UESCKJKoKmT4iXNV8Hhm74wSaVHqS
 Afnhl4zT+VhsviWcxGqAwJh3Y3d2TkMA/qyD8CA8n90Sg2vyzRX9beBaZsnN2Sp6fKvW4wkVR
 pk4pUc5xuithqU279s2L+LB8Nq3Vkb4wGtV+/M5aKu49pPWrKuCloJNAW+NTNSHFAzQUCaXMi
 rWrCzAxJXqoAWwcQyLdnmQSBGLNbGeQ7lAXnXfFKKjS4z7mOAPk+SKGjWHw4A0XH7bS2q3qKn
 hbF9yg5H8DD30ipziZpJgvtI2kk1wviY0p4FB+lyoSNf9YKwGot8a/rd9Wu28ECvsDgHnjUsp
 gd52hDviG6V49ZKaeL+TPMJ8z3ikEhr7xNWjeHxxhQgoInF1C23m/8x1CuareNZ6hxXv8BNYw
 rj1RS8655wNz7A8MePRErzQ3cg0WD/Mrs/CuM4xvHxtf/btfSEa9WgLyJ7Dz62+CL9afVHMRn
 dz1255g9rdbfSL+5ExZOi2Ro4Vk9lcc3wTyBcwpssrwjSBpaW/rHHTn3TzNEHysgY0I88U5I9
 fWpe+GvIyF5CrVYpfFT4PQdCR4C9NQOi6wHRwsMjXasb5WjF68QXXRM8rC7YQoMLGgUeI0HJE
 FhFXlC0M+wpyFPPuThvxJAHaxUD/+S/iqYq8ll5aP37zry/SY8z92RTK1rptuwKVY0smcXBZY
 Jnz6EuZGXEeAgtiI
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50221
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

On Monday 30 November 2015 22:29:26 Rasmus Villemoes wrote:
> 
> OK, thanks. That's a very very long time ago.
> 
> FWIW, the remaining instances that my trivial coccinelle script found
> are
> 
> ./arch/alpha/boot/main.c:187:1-4: no-op delay loop
> ./arch/m68k/68000/m68VZ328.c:86:10-13: no-op delay loop
> ./arch/m68k/bvme6000/config.c:338:2-5: no-op delay loop
> ./arch/m68k/coldfire/m53xx.c:533:1-4: no-op delay loop
> ./drivers/cpufreq/cris-artpec3-cpufreq.c:85:3-6: no-op delay loop
> ./drivers/cpufreq/cris-etraxfs-cpufreq.c:85:3-6: no-op delay loop
> ./drivers/tty/hvc/hvc_opal.c:313:3-6: no-op delay loop
> ./drivers/tty/hvc/hvc_vio.c:289:3-6: no-op delay loop
> 
> (cc += a few people). The tty ones use volatile, so they probably work,
> though one might still want to use the *delay API.
> 
> 

I suspect the tty users do it like this to get console output
before calibrate_delay_loop() is called.

	Ard
