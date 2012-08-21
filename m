Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 22:38:18 +0200 (CEST)
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:9390
        "EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903498Ab2HUUiN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 22:38:13 +0200
Received: from mail55-am1-R.bigfish.com (10.3.201.225) by
 AM1EHSOBE010.bigfish.com (10.3.204.30) with Microsoft SMTP Server id
 14.1.225.23; Tue, 21 Aug 2012 20:38:06 +0000
Received: from mail55-am1 (localhost [127.0.0.1])       by mail55-am1-R.bigfish.com
 (Postfix) with ESMTP id A340B440061;   Tue, 21 Aug 2012 20:38:06 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.245.5;KIP:(null);UIP:(null);IPV:NLI;H:CH1PRD0710HT001.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -4
X-BigFish: PS-4(zzbb2dI98dI9371I1432Izz1202hzz8275bhz2dh2a8h668h839hd25he5bhf0ah107ah1155h)
Received: from mail55-am1 (localhost.localdomain [127.0.0.1]) by mail55-am1
 (MessageSwitch) id 1345581484791299_13246; Tue, 21 Aug 2012 20:38:04 +0000
 (UTC)
Received: from AM1EHSMHS009.bigfish.com (unknown [10.3.201.243])        by
 mail55-am1.bigfish.com (Postfix) with ESMTP id BDA2F180044;    Tue, 21 Aug 2012
 20:38:04 +0000 (UTC)
Received: from CH1PRD0710HT001.namprd07.prod.outlook.com (157.56.245.5) by
 AM1EHSMHS009.bigfish.com (10.3.207.109) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Tue, 21 Aug 2012 20:38:04 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.152.36) with Microsoft SMTP Server (TLS) id 14.16.190.9; Tue, 21 Aug
 2012 20:38:03 +0000
Message-ID: <5033F1AA.4080308@caviumnetworks.com>
Date:   Tue, 21 Aug 2012 13:38:02 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>
CC:     David Daney <ddaney.cavm@gmail.com>,
        <devicetree-discuss@lists.ozlabs.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        <spi-devel-general@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-doc@vger.kernel.org>, David Daney <david.daney@cavium.com>
Subject: Re: [2/2] spi: Add SPI master controller for OCTEON SOCs.
References: <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com> <20120821194936.GA7145@roeck-us.net>
In-Reply-To: <20120821194936.GA7145@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
X-archive-position: 34330
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 08/21/2012 12:49 PM, Guenter Roeck wrote:
> On Fri, May 11, 2012 at 08:34:46PM -0000, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Add the driver, link it into the kbuild system and provide device tree
>> binding documentation.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
> [ ... ]
>
>> +
>> +static int __devexit octeon_spi_remove(struct platform_device *pdev)
>> +{
>> +	struct octeon_spi *p = platform_get_drvdata(pdev);
>> +	struct spi_master *master = p->my_master;
>> +
>> +	spi_unregister_master(master);
>> +
>
> I know it is a bit late, but ...

In this case, just in time.  I am now finally getting back to fixing the 
issues with this driver, and looking to merging it in the near future.

David Daney

>
> The call to spi_unregister_master() frees the memory associated with master,
> ie 'p', and the spi_master_put() below without matching spi_master_get() is
> unnecessary/wrong. One possible fix would be to use
>
> 	struct spi_master *master = spi_master_get(p->my_master);
>
> above. That protects master and p while it is still being used, and makes use
> of the call to spi_master_put() below. Another option might be to move
> cvmx_write_csr() ahead of the call to spi_unregister_master() and drop the
> call to spi_master_put().
>
> Guenter
>
>> +	/* Clear the CSENA* and put everything in a known state. */
>> +	cvmx_write_csr(p->register_base + OCTEON_SPI_CFG, 0);
>> +	spi_master_put(master);
>> +	return 0;
>> +}
>> +
>
