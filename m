Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 17:33:07 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:58158 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012483AbbBDQdGEhGtM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 17:33:06 +0100
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0MZbzh-1Y4woL3vUz-00LDUY; Wed, 04 Feb
 2015 17:32:53 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, mturquette@linaro.org,
        sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz,
        tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de,
        paul.burton@imgtec.com
Subject: Re: [PATCH_V2 27/34] MIPS: jz4740: use jz47xx-uart & DT for UART output
Date:   Wed, 04 Feb 2015 17:32:51 +0100
Message-ID: <3911455.CfbmuRjhZB@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1423063323-19419-28-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1423063323-19419-28-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:1XNQxpiNmzSNJE5FN7hf2PLxH/8ws5aAZglpImnK6uzHkDZEL+3
 eJnuwwJCTdi7PaO6aZz9l7uAoc9iE2ciWp3IlCZmYKsZ1dgtHa3li4EJvTgdxbA+uMZYWFn
 LgSADI0SAopM04H41N24vM/G6fBDGUs+A3VEaAB2pkgZpq2jK89nn9cVzRJmpA2YmmbDizz
 NSLbiLD0W0uswZoLM+i3Q==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45692
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

On Wednesday 04 February 2015 15:21:56 Zubair Lutfullah Kakakhel wrote:
> +#ifndef __JZ4740_SERIAL_H__
> +#define __JZ4740_SERIAL_H__
> +
> +#define BASE_BAUD (12000000 / 16)
> +
> +#endif /* __JZ4740_SERIAL_H__ */
> 

This looks wrong: You should not need to hardcode this number when
you can get it from DT.

	Arnd
