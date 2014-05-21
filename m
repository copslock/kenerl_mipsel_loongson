Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 18:10:52 +0200 (CEST)
Received: from mail-by2lp0236.outbound.protection.outlook.com ([207.46.163.236]:23005
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6843069AbaEUQKtdVWiB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 18:10:49 +0200
Received: from BY2PRD0711HT003.namprd07.prod.outlook.com (10.255.88.166) by
 CO1PR07MB192.namprd07.prod.outlook.com (10.242.167.144) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Wed, 21 May 2014 16:10:41 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.88.166) with Microsoft SMTP Server (TLS) id 14.16.459.0; Wed, 21 May
 2014 16:10:40 +0000
Message-ID: <537CCFFF.2080707@caviumnetworks.com>
Date:   Wed, 21 May 2014 09:10:39 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 06/15] MIPS: Add minimal support for OCTEON3 to c-r4k.c
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-7-git-send-email-andreas.herrmann@caviumnetworks.com> <537C7A12.7020606@imgtec.com>
In-Reply-To: <537C7A12.7020606@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(24454002)(51704005)(377454003)(479174003)(189002)(199002)(74662001)(21056001)(99396002)(87936001)(31966008)(23756003)(36756003)(74502001)(81542001)(81342001)(66066001)(83072002)(64706001)(65956001)(80022001)(85852003)(4396001)(19580395003)(19580405001)(92726001)(79102001)(83506001)(47776003)(59896001)(76482001)(53416003)(46102001)(92566001)(50466002)(50986999)(77982001)(64126003)(102836001)(80316001)(76176999)(20776003)(54356999)(65816999)(101416001)(87266999)(33656002);DIR:OUT;SFP:;SCL:1;SRVR:CO1PR07MB192;H:BY2PRD0711HT003.namprd07.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40222
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

On 05/21/2014 03:04 AM, James Hogan wrote:
> On 20/05/14 15:47, Andreas Herrmann wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> These are needed to boot a generic mips64r2 kernel on OCTEONIII.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
>> ---
>>   arch/mips/include/asm/r4kcache.h |    2 ++
>>   arch/mips/mm/c-r4k.c             |   32 ++++++++++++++++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>
>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>> index 1c74a6a..789ede9 100644
>> --- a/arch/mips/mm/c-r4k.c
>> +++ b/arch/mips/mm/c-r4k.c
>
>> @@ -1094,6 +1110,21 @@ static void probe_pcache(void)
>>   		c->dcache.waybit = 0;
>>   		break;
>>
>> +	case CPU_CAVIUM_OCTEON3:
>> +		/* For now lie about the number of ways. */
>
> Is this to work around the finite length of way_string[]?
>
> Can we fix that to be more dynamic instead? (admittedly special casing
> "direct mapped" looks like a bit of a pain).

The OCTEON ICache is a weird size that is not (and I think cannot be) 
represented by the CP0_Config* bits.  However, it doesn't matter, as any 
operation that attempts to invalidate any part of it, operates on the 
entire cache, so everything works out in the end.

The DCache is fully coherent, so any invalidate/flush operations are 
redundant.

So for both of these, we just need to supply values that are both 
plausible, and don't result in panics and/or OOPS messages being printed.


>
> Cheers
> James
>
>> +		c->icache.linesz = 128;
>> +		c->icache.sets = 16;
>> +		c->icache.ways = 8;
>> +		c->icache.flags |= MIPS_CACHE_VTAG;
>> +		icache_size = c->icache.sets * c->icache.ways * c->icache.linesz;
>> +
>> +		c->dcache.linesz = 128;
>> +		c->dcache.ways = 8;
>> +		c->dcache.sets = 8;
>> +		dcache_size = c->dcache.sets * c->dcache.ways * c->dcache.linesz;
>> +		c->options |= MIPS_CPU_PREFETCH;
>> +		break;
>> +
