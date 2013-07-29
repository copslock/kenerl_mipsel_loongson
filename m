Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jul 2013 23:32:38 +0200 (CEST)
Received: from mail-by2lp0242.outbound.protection.outlook.com ([207.46.163.242]:27522
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6830610Ab3G2Vcfofgm1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Jul 2013 23:32:35 +0200
Received: from BN1PRD0712HT002.namprd07.prod.outlook.com (10.255.196.35) by
 SN2PR07MB032.namprd07.prod.outlook.com (10.255.174.42) with Microsoft SMTP
 Server (TLS) id 15.0.731.12; Mon, 29 Jul 2013 21:32:25 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.196.35) with Microsoft SMTP Server (TLS) id 14.16.341.1; Mon, 29 Jul
 2013 21:32:24 +0000
Message-ID: <51F6DF65.9050301@caviumnetworks.com>
Date:   Mon, 29 Jul 2013 14:32:21 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     <ralf@linux-mips.org>, Linus Walleij <linus.walleij@linaro.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/2] OCTEON GPIO support.
References: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 09222B39F5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(377454003)(479174003)(51704005)(24454002)(199002)(189002)(74366001)(79102001)(16406001)(74662001)(23756003)(51856001)(74876001)(65806001)(76796001)(76786001)(65956001)(69226001)(80976001)(80022001)(63696002)(66066001)(64126003)(81542001)(47776003)(81342001)(83072001)(53416003)(31966008)(74706001)(74502001)(47446002)(56776001)(76482001)(33656001)(49866001)(80316001)(50986001)(4396001)(59766001)(47736001)(47976001)(77982001)(50466002)(19580405001)(54356001)(36756003)(53806001)(83322001)(56816003)(19580395003)(46102001)(59896001)(54316002)(77096001)(217873001);DIR:OUT;SFP:;SCL:1;SRVR:SN2PR07MB032;H:BN1PRD0712HT002.namprd07.prod.outlook.com;CLIP:64.2.3.195;RD:InfoNoRecords;A:1;MX:1;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37393
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

Really I meant to say that the first patch is in the MIPS tree, and 
should be Acked-by Ralf, if that wasn't clear.

David Daney


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
