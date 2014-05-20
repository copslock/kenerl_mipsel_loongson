Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 01:23:16 +0200 (CEST)
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:37763
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855085AbaETXXMSR-qV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 01:23:12 +0200
Received: from BY2PRD0711HT003.namprd07.prod.outlook.com (10.255.88.166) by
 BY2PR07MB921.namprd07.prod.outlook.com (10.242.45.28) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Tue, 20 May 2014 23:23:04 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.88.166) with Microsoft SMTP Server (TLS) id 14.16.459.0; Tue, 20 May
 2014 23:23:04 +0000
Message-ID: <537BE3D7.1070904@caviumnetworks.com>
Date:   Tue, 20 May 2014 16:23:03 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 03/15] MIPS: OCTEON: Move CAVIUM_OCTEON_CVMSEG_SIZE to
 CPU_CAVIUM_OCTEON
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-4-git-send-email-andreas.herrmann@caviumnetworks.com> <3124276.AVUgu1xWyv@radagast>
In-Reply-To: <3124276.AVUgu1xWyv@radagast>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 02176E2458
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(24454002)(377454003)(479174003)(199002)(189002)(51704005)(31966008)(53416003)(74662001)(23756003)(83322001)(101416001)(50466002)(19580395003)(87936001)(19580405001)(64126003)(74502001)(80316001)(92566001)(46102001)(47776003)(20776003)(4396001)(85852003)(50986999)(92726001)(54356999)(83072002)(87266999)(76176999)(36756003)(80022001)(79102001)(59896001)(77982001)(65806001)(66066001)(21056001)(99396002)(65816999)(81542001)(81342001)(76482001)(64706001)(65956001)(102836001)(83506001)(33656002);DIR:OUT;SFP:;SCL:1;SRVR:BY2PR07MB921;H:BY2PRD0711HT003.namprd07.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40198
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

On 05/20/2014 03:52 PM, James Hogan wrote:
> Hi Andreas,
>
> On Tuesday 20 May 2014 16:47:04 Andreas Herrmann wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> CVMSEG is related to the CPU core not the SoC system.  So needs to be
>> configurable there.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
>> ---
>>   arch/mips/cavium-octeon/Kconfig |   30 ++++++++++++++++++++----------
>>   1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/mips/cavium-octeon/Kconfig
>> b/arch/mips/cavium-octeon/Kconfig index 227705d..c5e9975 100644
>> --- a/arch/mips/cavium-octeon/Kconfig
>> +++ b/arch/mips/cavium-octeon/Kconfig
[...]
>> -config CAVIUM_OCTEON_CVMSEG_SIZE
>> -	int "Number of L1 cache lines reserved for CVMSEG memory"
>> -	range 0 54
>> -	default 1
>> +config CAVIUM_OCTEON_HW_FIX_UNALIGNED
>> +	bool "Enable hardware fixups of unaligned loads and stores"
>> +	default "y"
>
> Is adding CAVIUM_OCTEON_HW_FIX_UNALIGNED in this patch intentional? It seems
> unrelated.
>

Good catch.  CAVIUM_OCTEON_HW_FIX_UNALIGNED and its users were removed, 
we shouldn't add it back.  I think this is a case of rebasing gone wrong.

David Daney
