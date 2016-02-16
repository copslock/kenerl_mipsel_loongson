Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 16:46:14 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:50797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012831AbcBPPqMa6S0n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 16:46:12 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0LtX6a-1ZouNC0tjY-010xVw; Tue, 16 Feb
 2016 16:45:30 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/4] gpio: remove broken irq_to_gpio() interface
Date:   Tue, 16 Feb 2016 16:45:28 +0100
Message-ID: <2646870.5L1En4yxph@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CACRpkdaQN9_qoTn4_riZGvi4BKRLEVkRRL4CWzKj8e_di7Q2Xg@mail.gmail.com>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com> <1455551208-2825510-2-git-send-email-arnd@arndb.de> <CACRpkdaQN9_qoTn4_riZGvi4BKRLEVkRRL4CWzKj8e_di7Q2Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:zd4dqKmgvIbAl2MygblI7krGr+bn2HScmcVioVb6fLvW/p/qvcs
 /5igRk3iweiAYtwpoEHzRQovNoHbauR9gq6YrkoX0yQwOuTeaW/Q4BZywXlMgMCH8VjMQmU
 nlIHChoNeqNYHZqZnGgU/saRKWfYeYsx+ev6Mkw3wLWPqcToPMcTOCMkVj4Ae7pIn2Dy/r3
 ahgx/jdNHGauTMgI0VpEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tAzsQdoiwvc=:FV/ogZv5uUo/17qgyBLnMC
 vx/NMdZdXhPqXPUm8F/lp8SP53Wv0HLW34zvlAAqlkuiNajqhLKjX6TUEpVoluiovG08so6DO
 6Kmckv2mlMKUmmSzQrwA9cQPr8U/61dYFCZnuQ5xhRiKmlpe1dxALaH2yprtf7YleDFr9viVq
 lKOMQBgmF6SmntqsznDApHJrclF9rW7RD8TOu+WbMGxGkOuF1THTVbbhMP0MSGtNl6KUUKt9v
 iu60ezVnwGLMr7SOZLHyj97FxPKfIWgdyATQTFDy8j8A6wgo/A9hM10ikZ9WgWcg7mA2aRaFw
 wp30KD4KJWMMzDjhJgWoB6QYy4y4EF8vckQY+9+ZS5eO/fCoYoQcUIO9tOrNbbYuqJNZ51zZK
 s3RV2s2qoq55L7CXqLDPjrzBzezVydOGNo0oEfzpaLcvBLtdFPWfnlqlafYG80DbKAw7oOeuS
 7LNqDEFfGHagv7FJDYZ8aOTGsXg1k2qzvceXdXhPAzGiKSisgXcklKobrzOqvHjb7HeDGwsBW
 FwIaHyyBFH7lFJVAsetFUC7WT6gQv9deRHewqhFh7H28u6fbBl6OxCFdTd3WaSqZIKSly9iwp
 iFRNlu6UXgq4QqWsDCpf7MI2p6hM3+rLJDHkBHVGKBfukrZ+U66yAg7Rsw8ilMjHGQOdPumY1
 MS5DGkXkcYdo9Zdhr8NVq9EVdGLoUvsxvqhWRQjPVfIV8DMl3X4tbfWKo+YCfrqcvlU/bVcEZ
 nx74DUhKS2jygOWk
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52090
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

On Tuesday 16 February 2016 16:42:18 Linus Walleij wrote:
> On Mon, Feb 15, 2016 at 4:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > gpiolib has removed the irq_to_gpio() API several years ago,
> > but the global header still provided a non-working stub.
> >
> > Apparently one new user has shown up in arch/mips, so this patch
> > moves the broken definition to where it is used, ensuring that
> > we get new users but not changing the current behavior on jz4740.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Patch applied.
> 
> I expect the driver maintainer to deal with the resulting
> deprecation fallout.
> 

I've just sent v2 of the series, with a separate patch for MIPS
that now conflicts with this one. Can you pick up the new patch
instead?

	Arnd
