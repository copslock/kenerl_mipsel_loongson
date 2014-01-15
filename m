Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 20:12:29 +0100 (CET)
Received: from mail-bl2lp0210.outbound.protection.outlook.com ([207.46.163.210]:44033
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827341AbaAOTMYTB3Jx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 20:12:24 +0100
Received: from BL2PRD0712HT003.namprd07.prod.outlook.com (10.255.236.36) by
 DM2PR07MB304.namprd07.prod.outlook.com (10.141.105.153) with Microsoft SMTP
 Server (TLS) id 15.0.851.11; Wed, 15 Jan 2014 19:11:51 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.36) with Microsoft SMTP Server (TLS) id 14.16.395.1; Wed, 15 Jan
 2014 19:11:50 +0000
Message-ID: <52D6DD74.60308@caviumnetworks.com>
Date:   Wed, 15 Jan 2014 11:11:48 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <blogic@openwrt.org>, <david.daney@cavium.com>
Subject: Re: [PATCH mips-for-linux-next] MIPS: check for -mfix-cn63xxp1 compiler
 option
References: <1389812784-30085-1-git-send-email-florian@openwrt.org>
In-Reply-To: <1389812784-30085-1-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 00922518D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(779001)(679001)(689001)(51704005)(377454003)(479174003)(199002)(189002)(24454002)(19580395003)(64126003)(77096001)(50466002)(46102001)(49866001)(19580405001)(74706001)(87936001)(83506001)(74366001)(85306002)(51856001)(56816005)(36756003)(90146001)(80976001)(50986001)(4396001)(87266001)(53416003)(93516002)(54316002)(47736001)(47976001)(77982001)(56776001)(59766001)(83322001)(76482001)(65956001)(65806001)(80022001)(66066001)(81542001)(92566001)(93136001)(47776003)(63696002)(33656001)(92726001)(79102001)(54356001)(81342001)(83072002)(53806001)(85852003)(69226001)(23756003)(76796001)(74876001)(74502001)(47446002)(81816001)(31966008)(74662001)(81686001)(76786001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR07MB304;H:BL2PRD0712HT003.namprd07.prod.outlook.com;CLIP:64.2.3.195;FPR:;RD:InfoNoRecords;A:1;MX:1;LANG:en;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39014
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

On 01/15/2014 11:06 AM, Florian Fainelli wrote:
> Attempting to build for Cavium Octeon with an unpatched or old
> toolchain will fail due to the -mfix-cn63xxp1 option being unrecognized.
> Call cc-option on this option to make sure we can safely use it.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

NACK.

If the chip you are building for needs -Wa,-mfix-cn63xxp1, then building 
without this option yields a system the generates random errors.  So I 
would argue that if -Wa,-mfix-cn63xxp1 is not supported by your 
assembler, breaking the build is the proper thing to do.

David Daney

> ---
>   arch/mips/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 873a0ca..f372b84 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -155,7 +155,7 @@ cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += $(call cc-option,-march=octeon) -Wa,--trap
>   ifeq (,$(findstring march=octeon, $(cflags-$(CONFIG_CPU_CAVIUM_OCTEON))))
>   cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -Wa,-march=octeon
>   endif
> -cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
> +cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,$(call cc-option,-mfix-cn63xxp1)
>   cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
>
>   cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
>
