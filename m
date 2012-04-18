Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2012 18:25:05 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4220 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903631Ab2DRQY7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2012 18:24:59 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f8eeb460000>; Wed, 18 Apr 2012 09:26:46 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 18 Apr 2012 09:24:57 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 18 Apr 2012 09:24:57 -0700
Message-ID: <4F8EEAD8.8050205@cavium.com>
Date:   Wed, 18 Apr 2012 09:24:56 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     ddaney.cavm@gmail.com, grant.likely@secretlab.ca,
        rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, afleming@gmail.com,
        galak@kernel.crashing.org
Subject: Re: [PATCH v4 3/3] netdev/of/phy: Add MDIO bus multiplexer driven
 by GPIO lines.
References: <1334683966-12112-1-git-send-email-ddaney.cavm@gmail.com>   <1334683966-12112-4-git-send-email-ddaney.cavm@gmail.com> <20120417.225308.1588669089502246200.davem@davemloft.net>
In-Reply-To: <20120417.225308.1588669089502246200.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2012 16:24:57.0179 (UTC) FILETIME=[CB4262B0:01CD1D7F]
X-archive-position: 32963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/17/2012 07:53 PM, David Miller wrote:
> From: David Daney<ddaney.cavm@gmail.com>
> Date: Tue, 17 Apr 2012 10:32:46 -0700
>
>> From: David Daney<david.daney@cavium.com>
>>
>> The GPIO pins select which sub bus is connected to the master.
>>
>> Initially tested with an sn74cbtlv3253 switch device wired into the
>> MDIO bus.
>>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>
> Are you sure the Kconfig dependencies are sufficient?  This code seems
> to depend upon OF, and in particular the OF_MDIO stuff.
>

You are correct.  Should I:

A) Create a patch to fix the dependencies it on top of the previous set?

B) Regenerate the entire set with said patch rolled in?

Thanks,
David Daney
