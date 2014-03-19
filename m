Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 19:35:55 +0100 (CET)
Received: from mail-bn1lp0139.outbound.protection.outlook.com ([207.46.163.139]:10565
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6816543AbaCSSe4a2clV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Mar 2014 19:34:56 +0100
Received: from BLUPRD0711HT004.namprd07.prod.outlook.com (10.255.120.39) by
 CO1PR07MB394.namprd07.prod.outlook.com (10.141.74.13) with Microsoft SMTP
 Server (TLS) id 15.0.898.11; Wed, 19 Mar 2014 18:34:46 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.120.39) with Microsoft SMTP Server (TLS) id 14.16.423.0; Wed, 19 Mar
 2014 18:34:44 +0000
Message-ID: <5329E343.60309@caviumnetworks.com>
Date:   Wed, 19 Mar 2014 11:34:43 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
CC:     "Yang,Wei" <Wei.Yang@windriver.com>, <david.daney@cavium.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2] mips/octeon_3xxx: Fix a warning on octeon_3xxx
References: <1395118084-24018-1-git-send-email-Wei.Yang@windriver.com> <532968AD.4010402@windriver.com> <20140319162008.GA4368@alberich>
In-Reply-To: <20140319162008.GA4368@alberich>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 01559F388D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(24454002)(199002)(189002)(51704005)(377454003)(479174003)(36756003)(69226001)(66066001)(64126003)(76796001)(81342001)(77096001)(31966008)(79102001)(59766001)(77982001)(65806001)(20776003)(63696002)(23676002)(65956001)(81542001)(47776003)(80022001)(74502001)(47446002)(49866001)(74706001)(95416001)(83506001)(97336001)(87266001)(93136001)(56816005)(74876001)(90146001)(4396001)(85306002)(95666003)(50466002)(97186001)(575784001)(87936001)(53416003)(92566001)(81686001)(92726001)(85852003)(81816001)(54316002)(56776001)(93516002)(94946001)(76482001)(80976001)(50986001)(74662001)(47736001)(47976001)(46102001)(83072002)(33656001)(53806001)(51856001)(83322001)(74366001)(54356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR07MB394;H:BLUPRD0711HT004.namprd07.prod.outlook.com;FPR:F225D0BE.BD394715.8DD33E7F.4EFAB701.202DE;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39508
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

On 03/19/2014 09:20 AM, Andreas Herrmann wrote:
> On Wed, Mar 19, 2014 at 05:51:41PM +0800, Yang,Wei wrote:
>> ping.
>
> I think, that the proper solution to avoid this warning is
> to fix the DTS information.
>

Just for the record:  The DTS is reflecting the actual routing of the 
signals within the SoC.  So I would argue that we shouldn't change it 
for these two reasons:

1) It accurately reflects reality.

2) There are deployed bootloaders that supply this to the kernel that 
are difficult to change.


> The warning started to trigger since commit
> 3da5278727a895d49a601f67fd49dffa0b80f9a5 (of/irq: Rework of_irq_count())
> was introduced.
>
> This changed of_irq_count() like this:
>
>   -       while (of_irq_to_resource(dev, nr, NULL))
>   +       while (of_irq_parse_one(dev, nr, &irq) == 0)
>
> Since then the code maps IRQs listed in the gpio-controller device
> node to its interrupt-parent, I think.
>
> Before this patch those interrupts weren't mapped at this point.
>
> I think both patches are fine to avoid the warning.  With the new
> version kind of a redundant mapping of GPIO interrupts happens (which
> will be overridden for an GPIO IRQ as soon as it is really used).
> This makes me think that the warning makes sense and the DTS needs to
> be fixed. (We should not use octeon_irq_ciu_xlat/octeon_irq_ciu_map
> for GPIO lines.)
>
> I might be wrong but maybe specifying an interrupt-parent for the
> gpio-controller (and thus listing the GPIO IRQs in the gpio-controller
> device node) was not a good choice.
>

Andreas has a slightly modified version of the V2 patch that we tested, 
and it seems to work.  I think we should go with that instead of the V2 
patch.

David Daney


>
>>
