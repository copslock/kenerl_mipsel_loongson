Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2016 11:49:18 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.75]:55702 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010488AbcBQKtRlfaZv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Feb 2016 11:49:17 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0MZUcf-1aFiOT2XWP-00LGl4; Wed, 17 Feb
 2016 11:48:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 0/7] fix IS_ERR_VALUE usage
Date:   Wed, 17 Feb 2016 11:48:38 +0100
Message-ID: <7443859.JK6ybmGO1A@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:Snagi/NV2Ll1OA+Wl8QqUKLObfdm6VzkBf9Hf4QBiwD6FPntLi+
 qR63ieI5B5kpz0HIhiPS8smb5kJ+9qOF4FSrn0+x9WIYzbXIrCxJj5D8b2Rh8GbM7UtMyGO
 LaDKsKc1omrYOtNEDzEckBt5s449VGMwwHTKtoeukktAqbULpuRlBNWrDjehj/rlfdGwRwV
 9RAMGKROTLzfCm1Vqom8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wx7G5CPTxoQ=:VCVt5rZtw0/Yms6p2NRNqV
 yeEspevZ7J21SMDQAsAqwwwl3bjMIu3ldZcgxwRJCKGiAkr+vTLlK6euLxXyg6IK5Fe3QpvMS
 Nq1Wp+mG3nHWeRT9Ofs4CZR7ugUYMJBlymiaWAEr8omnbJkuoiT3MlYZXW5CeSkWTEB83RyPH
 I85pbEibntNaTpg+0WNCGDTE9ZvCQ1aUY7YwP2XHGM8xOfm2k30wX/c56CsephLnSkBZCQWpk
 jaYZjTS2LgRK+Tn6CptP/58/dwTIX2anPJ2e9MqmKMFdZakrtPKF09HekOd1hCtLjFh4bZI6S
 Jf8HQ3oYicqZI34FfqgFw7HqC+YRVr3e3cpSdXav8XVqNzismZw7w8y/TwYw+mi/5N3KGz1PW
 qXjX5dKcJVyQHNJ3iYSSJKfJQhJzCGe1rNvvvWUDZEB5t1Aa7VVau1WwHFgQA4nBBBaM/95Ka
 8ftQ/UnBzvFYiCFYi3lNdUm0MAxIacWoc4yIw3Qico8TAFuCsiXhqAohUu6RgCc1DKF/GZ19Q
 A7FVqQRppme2j9JqcX0+5TBmSjFBYg+IRufi7d5o7vwUh8JoIXSvxneIEP2Q50gr+XGYwFqRe
 +mVZFsu+SeBQ7or8gwKljnrTzjxpx6KHKbemK79WD5rBZ/hZdffq8ejivltYtllhLoirvE/eB
 1LyNV5OWLbtVUZHuyXoX8L+CHvKfApxgEU/1MmO3eP9foYCVGTbdvLNPzLt4xhN5qKQ9WmJK0
 xdcKqnLvmdP9tcEV
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52101
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

On Monday 15 February 2016 15:35:18 Andrzej Hajda wrote:
> 
> Andrzej Hajda (7):
>   netfilter: fix IS_ERR_VALUE usage
>   MIPS: module: fix incorrect IS_ERR_VALUE macro usages
>   drivers: char: mem: fix IS_ERROR_VALUE usage
>   atmel-isi: fix IS_ERR_VALUE usage
>   serial: clps711x: fix IS_ERR_VALUE usage
>   fbdev: exynos: fix IS_ERR_VALUE usage
>   usb: gadget: fsl_qe_udc: fix IS_ERR_VALUE usage
> 

Can you Cc me the next time on all of the patches? I only got
three of them this time.

	Arnd
