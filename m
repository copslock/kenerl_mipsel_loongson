Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 18:40:15 +0200 (CEST)
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:38424
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6816900AbaFCQkMZnH4a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jun 2014 18:40:12 +0200
Received: from BY2PRD0711HT003.namprd07.prod.outlook.com (10.255.88.166) by
 CO2PR0701MB1030.namprd07.prod.outlook.com (25.160.10.18) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Tue, 3 Jun 2014 16:40:03 +0000
Received: from localhost.caveonetworks.com (64.2.3.195) by
 pod51018.outlook.com (10.255.88.166) with Microsoft SMTP Server (TLS) id
 14.16.459.0; Tue, 3 Jun 2014 16:40:02 +0000
Message-ID: <538DFA61.4080100@caviumnetworks.com>
Date:   Tue, 3 Jun 2014 09:40:01 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        "James Hogan" <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 09/13] MIPS: Add functions for hypervisor call
References: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1401313936-11867-10-git-send-email-andreas.herrmann@caviumnetworks.com> <20140603083031.GP17197@linux-mips.org> <20140603150337.GA28045@alberich>
In-Reply-To: <20140603150337.GA28045@alberich>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Microsoft-Antispam: BL:0;ACTION:Default;RISK:Low;SCL:0;SPMLVL:NotSpam;PCL:0;RULEID:
X-Forefront-PRVS: 02318D10FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(979002)(6009001)(428001)(479174003)(51704005)(199002)(189002)(24454002)(377454003)(164054003)(66066001)(36756003)(81342001)(80316001)(74662001)(79102001)(83072002)(54356999)(20776003)(101416001)(102836001)(85852003)(31966008)(47776003)(83322001)(92726001)(74502001)(19580395003)(50466002)(21056001)(92566001)(46102001)(76176999)(76506004)(33656002)(87936001)(87266999)(83506001)(77982001)(4396001)(23676002)(80022001)(15975445006)(65806001)(59896001)(81542001)(76482001)(64706001)(53416003)(65816999)(50986999)(15202345003)(65956001)(99396002)(64126003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:;SCL:1;SRVR:CO2PR0701MB1030;H:BY2PRD0711HT003.namprd07.prod.outlook.com;FPR:;MLV:ovrnspm;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40422
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

In cases like this, I always wonder WWPD (What Would Pinski Do)...

Let's get him to opine.

Andrew, the patch in question is:

http://www.linux-mips.org/archives/linux-mips/2014-05/msg00309.html

Thanks,
David Daney

On 06/03/2014 08:03 AM, Andreas Herrmann wrote:
> On Tue, Jun 03, 2014 at 10:30:31AM +0200, Ralf Baechle wrote:
>> On Wed, May 28, 2014 at 11:52:12PM +0200, Andreas Herrmann wrote:
>>
>>> +/*
>>> + * Hypercalls for KVM.
>>> + *
>>> + * Hypercall number is passed in v0.
>>> + * Return value will be placed in v0.
>>> + * Up to 3 arguments are passed in a0, a1, and a2.
>>> + */
>>> +static inline unsigned long kvm_hypercall0(unsigned long num)
>>> +{
>>> +	register unsigned long n asm("v0");
>>> +	register unsigned long r asm("v0");
>>
>> Btw, is it safe to put two variables in the same register?
>
> I think it's safe.
>
> If we would have a matching constraint letter (say "v" for register v0) the
> asm should translate to
>
>          __asm__ __volatile__(
> 	       KVM_HYPERCALL
>                  : "=v" (n) : "v" (r) : "memory"
>                  );
>
> which isn't unusual on other archs. (Or maybe I am just biased from
> x86 ... or missed something else.)
>
>> The syscall wrappers that used to be in <asm/unistd.h> were occasionally
>> hitting problems which eventually forced me to stop forcing variables
>> into particular registers instead using a MOVE instruction to shove
>> each variable into the right place.
>>
>> Of course they were being used from non-PIC and PIC code, kernel and userland
>> so GCC had a much better chance to do evil than in the hypercall wrapper
>> case - but it made me paranoid ...
>
>
>
> Andreas
>
