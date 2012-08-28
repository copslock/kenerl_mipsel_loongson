Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2012 12:34:10 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:60794 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903736Ab2H1KeH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Aug 2012 12:34:07 +0200
Message-ID: <503C9E3D.9050406@openwrt.org>
Date:   Tue, 28 Aug 2012 12:32:29 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3 0/3] MIPS: ath79: allow to use USB on AR934x
References: <1344096237-25221-1-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1344096237-25221-1-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/08/12 18:03, Gabor Juhos wrote:
> This patch-set adds AR934x specific glue into the USB
> platform device registration code. Additionally, it
> registers the USB host controller device on the
> DB120 board.
>
> This depends on the following patch set:
> v3 of 'MIPS: ath79: various fixes'
>
> v3:
>  - rebase aginas v3.6-rc1
>  - fix AR934X_EHCI_SIZE
>
> Gabor Juhos (3):
>   MIPS: ath79: use a helper function for USB resource initialization
>   MIPS: ath79: add USB platform setup code for AR934X
>   MIPS: ath79: register USB host controller on the DB120 board
>
>  arch/mips/ath79/dev-usb.c                      |   92 ++++++++++++++----------
>  arch/mips/ath79/mach-db120.c                   |    2 +
>  arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    7 ++
>  3 files changed, 65 insertions(+), 36 deletions(-)
>
> --
> 1.7.10

Linus pulled the pre-req series into his tree so I queued this one for 3.7

    John
