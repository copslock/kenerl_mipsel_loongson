Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Aug 2013 21:17:08 +0200 (CEST)
Received: from mail-bl2lp0206.outbound.protection.outlook.com ([207.46.163.206]:47661
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6865328Ab3HNTRFiEnlB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Aug 2013 21:17:05 +0200
Received: from BLUPRD0712HT001.namprd07.prod.outlook.com (10.255.218.162) by
 BLUPR07MB145.namprd07.prod.outlook.com (10.242.200.26) with Microsoft SMTP
 Server (TLS) id 15.0.745.25; Wed, 14 Aug 2013 19:16:44 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.218.162) with Microsoft SMTP Server (TLS) id 14.16.347.3; Wed, 14 Aug
 2013 19:16:44 +0000
Message-ID: <520BD79A.50307@caviumnetworks.com>
Date:   Wed, 14 Aug 2013 12:16:42 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/2] OCTEON GPIO support.
References: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 0938781D02
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(54094003)(51704005)(479174003)(377454003)(24454002)(189002)(199002)(81686001)(74366001)(49866001)(47736001)(74706001)(76796001)(76786001)(64126003)(83072001)(69226001)(4396001)(50986001)(81542001)(50466002)(47976001)(81342001)(53416003)(81816001)(79102001)(23756003)(80976001)(63696002)(47776003)(83322001)(19580405001)(56816003)(19580395003)(56776001)(46102001)(54316002)(51856001)(77096001)(54356001)(74876001)(53806001)(65956001)(74502001)(66066001)(31966008)(80022001)(33656001)(74662001)(65806001)(47446002)(76482001)(59766001)(77982001)(16406001)(36756003)(217873001);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB145;H:BLUPRD0712HT001.namprd07.prod.outlook.com;CLIP:64.2.3.195;RD:InfoNoRecords;MX:1;A:1;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

Ping.

Hi Linus,

I wonder if you have had a chance to look at these...

David Daney


On 07/29/2013 02:29 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> The Cavium, OCTEON is a MIPS based SoC.  Here we add support for its
> on-chip GPIO lines.
>
> Changes from v1: Cleaned up variable names, messages and added some
> comments as suggested by Linus Walleij.
>
> The second patch depends on the first, but is in code maintained by
> Ralf.  It may be best to mrege both of these together, perhaps from
> the GPIO tree, with Ralf's Acked-by.
>
> David Daney (2):
>    MIPS: OCTEON: Select ARCH_REQUIRE_GPIOLIB
>    gpio MIPS/OCTEON: Add a driver for OCTEON's on-chip GPIO pins.
>
>   arch/mips/Kconfig                               |   1 +
>   arch/mips/include/asm/mach-cavium-octeon/gpio.h |  21 ++++
>   drivers/gpio/Kconfig                            |   8 ++
>   drivers/gpio/Makefile                           |   1 +
>   drivers/gpio/gpio-octeon.c                      | 157 ++++++++++++++++++++++++
>   5 files changed, 188 insertions(+)
>   create mode 100644 arch/mips/include/asm/mach-cavium-octeon/gpio.h
>   create mode 100644 drivers/gpio/gpio-octeon.c
>
