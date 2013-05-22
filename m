Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 18:14:14 +0200 (CEST)
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:48940
        "EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835040Ab3EVQOHKFq15 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 18:14:07 +0200
Received: from mail63-co9-R.bigfish.com (10.236.132.232) by
 CO9EHSOBE037.bigfish.com (10.236.130.100) with Microsoft SMTP Server id
 14.1.225.23; Wed, 22 May 2013 16:13:58 +0000
Received: from mail63-co9 (localhost [127.0.0.1])       by mail63-co9-R.bigfish.com
 (Postfix) with ESMTP id 2D719C804A2;   Wed, 22 May 2013 16:13:58 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.2.69;KIP:(null);UIP:(null);IPV:NLI;H:BN1PRD0712HT002.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -5
X-BigFish: PS-5(zzbb2dI98dI9371I1432I4015Izz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzzz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1155h)
Received: from mail63-co9 (localhost.localdomain [127.0.0.1]) by mail63-co9
 (MessageSwitch) id 1369239236484086_4347; Wed, 22 May 2013 16:13:56 +0000
 (UTC)
Received: from CO9EHSMHS017.bigfish.com (unknown [10.236.132.243])      by
 mail63-co9.bigfish.com (Postfix) with ESMTP id 6F7A69400FD;    Wed, 22 May 2013
 16:13:56 +0000 (UTC)
Received: from BN1PRD0712HT002.namprd07.prod.outlook.com (132.245.2.69) by
 CO9EHSMHS017.bigfish.com (10.236.130.27) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Wed, 22 May 2013 16:13:55 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.196.35) with Microsoft SMTP Server (TLS) id 14.16.311.1; Wed, 22 May
 2013 16:13:53 +0000
Message-ID: <519CEEBE.5020403@caviumnetworks.com>
Date:   Wed, 22 May 2013 09:13:50 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <ddaney.cavm@gmail.com>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        <linux-ide@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>, <netdev@vger.kernel.org>,
        <spi-devel-general@lists.sourceforge.net>,
        <devel@driverdev.osuosl.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] MIPS: OCTEON: Rename Kconfig CAVIUM_OCTEON_REFERENCE_BOARD
 to CAVIUM_OCTEON_SOC
References: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com> <20130521220457.GF31836@blackmetal.musicnaut.iki.fi> <519BF01B.1010600@caviumnetworks.com> <20130522122232.GD10769@linux-mips.org>
In-Reply-To: <20130522122232.GD10769@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36525
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

On 05/22/2013 05:22 AM, Ralf Baechle wrote:
> On Tue, May 21, 2013 at 03:07:23PM -0700, David Daney wrote:
>
>>>>   config USB_OCTEON_OHCI
>>>>   	bool "Octeon on-chip OHCI support"
>>>> -	depends on CPU_CAVIUM_OCTEON
>>>> +	depends on  CAVIUM_OCTEON_SOC
>>>
>>> Just a minor comment, here the extra whitespace after "depends on"
>>> could be eliminated.
>>>
>>
>> Good point.  I will regenerate the patch to correct this.
>
> I took care of that and queued the patch.
>

Can you take v2 instead?  It has the missing watchdog adjustment that is 
not in v1.

Thanks,
David Daney
