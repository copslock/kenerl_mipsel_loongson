Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2014 22:45:59 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:49910 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007105AbaIAUp55kQjI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2014 22:45:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 51CAF28BB92
        for <linux-mips@linux-mips.org>; Mon,  1 Sep 2014 22:45:38 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qa0-f47.google.com (mail-qa0-f47.google.com [209.85.216.47])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 7247328BB94
        for <linux-mips@linux-mips.org>; Mon,  1 Sep 2014 22:45:27 +0200 (CEST)
Received: by mail-qa0-f47.google.com with SMTP id x12so5364626qac.6
        for <linux-mips@linux-mips.org>; Mon, 01 Sep 2014 13:45:45 -0700 (PDT)
X-Received: by 10.140.101.145 with SMTP id u17mr46637229qge.10.1409604345162;
 Mon, 01 Sep 2014 13:45:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.84.244 with HTTP; Mon, 1 Sep 2014 13:45:25 -0700 (PDT)
In-Reply-To: <4072992.6HB7sP7z87@wuerfel>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
 <CACna6rwmNtS1JSi=VHXWHu6mOM72Y8sBrr5EqCRbpYUHFrMnCg@mail.gmail.com>
 <CACna6rwMovK133ZoFYsLcsnH39umU7=UAoyG6jmgM8ZVq0AYRA@mail.gmail.com> <4072992.6HB7sP7z87@wuerfel>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 1 Sep 2014 22:45:25 +0200
Message-ID: <CAOiHx==sRquiqrQW6T0S+UsOz5H8V1Wt7x1RD=SVo6=gu7M1Vg@mail.gmail.com>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Mon, Sep 1, 2014 at 4:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 01 September 2014 09:48:48 Rafał Miłecki wrote:
>> On 31 August 2014 11:20, Rafał Miłecki <zajec5@gmail.com> wrote:
>> So I think we'll need to change our vision of flash access in
>> bcm74xx_nvram driver. I guess we will have to:
>> 1) Register NAND core early
>> 2) Initialize NAND driver
>> 3) Use mtd/nand API in bcm47xx_nvram
>
> This would mean it's available really late. Is that a problem?

That's probably mostly fine (for MIPS), except for two places:
a) the kernel command line is stored in nvram, and used for finding
out the correct console tty.
b) on one specific chip, the configured system clock rate needs to be
read out from nvram.

Both can be also done through DT, but b) is somewhat important to do
right, as it will cause the time running fast/slow if the value is
wrong.

> A possible solution for this would be to use the boot wrapper
> I mentioned earlier, to put all the data from nvram into DT
> properties before the kernel gets started.

That sounds like quite a bit of effort, and a bit over-engineered for
just 2.5 platforms.


Jonas
