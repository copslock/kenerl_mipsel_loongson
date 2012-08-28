Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2012 12:40:47 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:49498 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903724Ab2H1Kki (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Aug 2012 12:40:38 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id AFD8D23C0083;
        Tue, 28 Aug 2012 12:40:33 +0200 (CEST)
Message-ID: <503CA022.9000501@openwrt.org>
Date:   Tue, 28 Aug 2012 12:40:34 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3 0/3] MIPS: ath79: allow to use USB on AR934x
References: <1344096237-25221-1-git-send-email-juhosg@openwrt.org> <503C9E3D.9050406@openwrt.org>
In-Reply-To: <503C9E3D.9050406@openwrt.org>
X-Enigmail-Version: 1.4.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 34371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2012.08.28. 12:32 keltezéssel, John Crispin írta:
> On 04/08/12 18:03, Gabor Juhos wrote:
>> This patch-set adds AR934x specific glue into the USB
>> platform device registration code. Additionally, it
>> registers the USB host controller device on the
>> DB120 board.
>>
>> This depends on the following patch set:
>> v3 of 'MIPS: ath79: various fixes'
>>
>> v3:
>>  - rebase aginas v3.6-rc1
>>  - fix AR934X_EHCI_SIZE
>>
>> Gabor Juhos (3):
>>   MIPS: ath79: use a helper function for USB resource initialization
>>   MIPS: ath79: add USB platform setup code for AR934X
>>   MIPS: ath79: register USB host controller on the DB120 board
>>
>>  arch/mips/ath79/dev-usb.c                      |   92 ++++++++++++++----------
>>  arch/mips/ath79/mach-db120.c                   |    2 +
>>  arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    7 ++
>>  3 files changed, 65 insertions(+), 36 deletions(-)
>>
>> --
>> 1.7.10
> 
> Linus pulled the pre-req series into his tree so I queued this one for 3.7

Thanks!

-Gabor
