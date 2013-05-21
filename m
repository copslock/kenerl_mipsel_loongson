Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 00:07:45 +0200 (CEST)
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:24940
        "EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835050Ab3EUWHiG19MH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 00:07:38 +0200
Received: from mail67-va3-R.bigfish.com (10.7.14.250) by
 VA3EHSOBE014.bigfish.com (10.7.40.64) with Microsoft SMTP Server id
 14.1.225.23; Tue, 21 May 2013 22:07:30 +0000
Received: from mail67-va3 (localhost [127.0.0.1])       by mail67-va3-R.bigfish.com
 (Postfix) with ESMTP id E589A42014B;   Tue, 21 May 2013 22:07:29 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.242.245;KIP:(null);UIP:(null);IPV:NLI;H:BL2PRD0712HT001.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -5
X-BigFish: PS-5(zzbb2dI98dI9371I1432I4015Izz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzzz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1155h)
Received: from mail67-va3 (localhost.localdomain [127.0.0.1]) by mail67-va3
 (MessageSwitch) id 1369174047955646_15367; Tue, 21 May 2013 22:07:27 +0000
 (UTC)
Received: from VA3EHSMHS027.bigfish.com (unknown [10.7.14.234]) by
 mail67-va3.bigfish.com (Postfix) with ESMTP id D8AA920487;     Tue, 21 May 2013
 22:07:27 +0000 (UTC)
Received: from BL2PRD0712HT001.namprd07.prod.outlook.com (157.56.242.245) by
 VA3EHSMHS027.bigfish.com (10.7.99.37) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Tue, 21 May 2013 22:07:27 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.34) with Microsoft SMTP Server (TLS) id 14.16.311.1; Tue, 21 May
 2013 22:07:27 +0000
Message-ID: <519BF01B.1010600@caviumnetworks.com>
Date:   Tue, 21 May 2013 15:07:23 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>,
        <linux-ide@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>, <netdev@vger.kernel.org>,
        <spi-devel-general@lists.sourceforge.net>,
        <devel@driverdev.osuosl.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] MIPS: OCTEON: Rename Kconfig CAVIUM_OCTEON_REFERENCE_BOARD
 to CAVIUM_OCTEON_SOC
References: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com> <20130521220457.GF31836@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130521220457.GF31836@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36515
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

On 05/21/2013 03:04 PM, Aaro Koskinen wrote:
> Hi,
>
> What about OCTEON_WDT, should it be changed too:
>
>          tristate "Cavium OCTEON SOC family Watchdog Timer"
>          depends on CPU_CAVIUM_OCTEON
>
> On Mon, May 20, 2013 at 03:19:38PM -0700, David Daney wrote:
>>   config OCTEON_MGMT_ETHERNET
>>   	tristate "Octeon Management port ethernet driver (CN5XXX, CN6XXX)"
>> -	depends on  CPU_CAVIUM_OCTEON
>> +	depends on  CAVIUM_OCTEON_SOC
>
>>   config MDIO_OCTEON
>>   	tristate "Support for MDIO buses on Octeon SOCs"
>> -	depends on  CPU_CAVIUM_OCTEON
>> +	depends on  CAVIUM_OCTEON_SOC
>
>>   config USB_OCTEON_OHCI
>>   	bool "Octeon on-chip OHCI support"
>> -	depends on CPU_CAVIUM_OCTEON
>> +	depends on  CAVIUM_OCTEON_SOC
>
> Just a minor comment, here the extra whitespace after "depends on"
> could be eliminated.
>

Good point.  I will regenerate the patch to correct this.

Thanks,
David Daney
