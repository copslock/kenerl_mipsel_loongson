Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 16:34:26 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.135]:59615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013700AbcCNPeXQw2m1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Mar 2016 16:34:23 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0LyyMm-1Zk6YF25KK-014Ees; Mon, 14 Mar
 2016 16:34:11 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul@pwsan.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Firmware: broadcom sprom: clarifiy SSB dependency
Date:   Mon, 14 Mar 2016 16:34:09 +0100
Message-ID: <4928549.J7iBRWWaDH@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CACna6rwx4Lna-PXNaHFwqn8xWitN=5ReUsAGPsK75YC2SLpDNg@mail.gmail.com>
References: <1457965305-3258441-1-git-send-email-arnd@arndb.de> <CACna6rwx4Lna-PXNaHFwqn8xWitN=5ReUsAGPsK75YC2SLpDNg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K0:UAnVyCMralMkez+upiy+w6xwxf1iSG90SKNSCz5Gz801ZwtGVf0
 qwDTFnSKlsmj5vbEuZ1rYp+J4MrG1h9x3mCPUNevFflDnJqztDnFDMQduLcQp/Nk4EYHLrl
 ypwBi8ljHOXUl+XwEDg6D6NW9TMul/Yw3/Kwffwog5FshHDo/ND5waQXo4Y4Wi0EOqKIdwC
 HLKi6iUxkCTrWDfICpFYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UjW+jJdy3T0=:ryYgpZvRY+JLDRaKKQ0LYc
 f8iiSwDp4IW4K3VF5J5yET3Oy9awGOTdVynsBK7Zfp9ba47bDAME/7CDdl1xJg3PHmc9uX/H4
 7Q0V8iGaNNqFmUGcb9C6O3JfPc86yiGtHdprz0PqAqR08NJoyGnP749FgQhBZH9CkEBAY05Qi
 KGtzljfRI+cltDA9OtTXj394y2Z7MWyaErwsF+2n+vmY0Uu0PVAH6ZEM15TlayArSspTzh6qz
 /vtZEJEuRa++41C6n6xg5J3qs7rgUSI4W8WTBLLk/aHKwcMP+d6ZFQg+mRdjoUqucAp/siDw0
 Pz45OWnunZJCfxFN4KQSoiOdEcfiOtj7RnNZkTQ8DqDc7wDxYwjEWHHEokb9Lgne8GIrtryNY
 4XoIgExQAE71SuS73YblaeBYvOKAIBv2jw3kZM0WjsdKiX2KY4ndqkibJTyP6hdwjH8gpGf91
 /84hJW3xgbyvvevi3HBhV3qJefstIm91x+PBC8o/Zyq44GbEO/Vk5a1/qTXBTGPIf8ftTg86c
 5ScL95sO2C4tX1r/kciryAnWMYcTp9oyJZeWMf5GvWEDd9VUACYIGuwUxwfD9iSthoGu25TYo
 IwS0gzF8wqbBc8tfe2jxCTrc904O2mv1KlmdysReMM+PwbhYA5UdtDTQnTWsU1otDYxSh/S3+
 0IS5wQQ8mmCYJ5KJDCMQZNQsDzPpWxNehR1/O70wCsMt0w/9VmmaTCbjPmjcjTkSJs2wnZVdO
 aKOGnDiHqazwUA1n
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52582
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

On Monday 14 March 2016 15:37:18 Rafał Miłecki wrote:
> On 14 March 2016 at 15:21, Arnd Bergmann <arnd@arndb.de> wrote:
> > The broadcom firmware drvier calls into the ssb SPROM code if that
> > is enabled, but it fails if the SSB code is in a loadable module
> > because the bcm47xx firmware is always built-in:
> >
> > drivers/firmware/built-in.o: In function `bcm47xx_sprom_register_fallbacks':
> > bcm47xx_sprom.c:(.text+0x11c4): undefined reference to `ssb_arch_register_fallback_sprom'
> >
> > This adds a Kconfig dependency to ensure that we cannot turn on the
> > generic sprom support if the ssb sprom is in a module.
> 
> Can you attach your config that triggered this build error? I modified
> condition to the:
> #if IS_BUILTIN(CONFIG_SSB) && IS_ENABLED(CONFIG_SSB_SPROM)
> which I believe should be enough.

From inspection, I think your solution is sufficient to avoid the error.
I found the bug while travelling and I'm only now catching up on the submissions,
so I must have missed the fact that it was fixed. I looked at the code
to see if additional patches had been applied on top, but I did not
realize that you had modified the driver in place.

> I'm afraid your patch won't allow compiling SPROM driver with BCMA=y
> and SSB as a module.

Correct. The downside of your approach is that it silently stops the machine
from accessing the SSB SPROM when the driver is a module, while still
allowing the generic SPROM code to be built, which may be harder to
figure out for a user than a missing driver.

I don't see a good solution that works either way, so the your latest code looks
good enough. Thanks for the quick reply!

	Arnd
