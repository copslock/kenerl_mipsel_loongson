Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 18:45:12 +0200 (CEST)
Received: from mail-bn1blp0190.outbound.protection.outlook.com ([207.46.163.190]:52723
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6816900AbaFCQpJmPMfa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jun 2014 18:45:09 +0200
Received: from CO1PR07MB127.namprd07.prod.outlook.com (10.242.167.26) by
 CO1PR07MB395.namprd07.prod.outlook.com (10.141.74.22) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Tue, 3 Jun 2014 16:45:01 +0000
Received: from CO1PR07MB127.namprd07.prod.outlook.com ([169.254.3.148]) by
 CO1PR07MB127.namprd07.prod.outlook.com ([169.254.3.148]) with mapi id
 15.00.0954.000; Tue, 3 Jun 2014 16:45:01 +0000
From:   "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
To:     "Daney, David" <David.Daney@caviumnetworks.com>
CC:     "Herrmann, Andreas" <Andreas.Herrmann@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 09/13] MIPS: Add functions for hypervisor call
Thread-Topic: [PATCH v2 09/13] MIPS: Add functions for hypervisor call
Thread-Index: AQHPf0p6gDdohutE1E+d1JaWoWdLs5tfl72X
Date:   Tue, 3 Jun 2014 16:45:00 +0000
Message-ID: <BE1AC288-3E8F-4329-AFE8-50B64E069AB7@caviumnetworks.com>
References: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1401313936-11867-10-git-send-email-andreas.herrmann@caviumnetworks.com>
 <20140603083031.GP17197@linux-mips.org>
 <20140603150337.GA28045@alberich>,<538DFA61.4080100@caviumnetworks.com>
In-Reply-To: <538DFA61.4080100@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [76.253.2.104]
x-microsoft-antispam: BL:0;ACTION:Default;RISK:Low;SCL:0;SPMLVL:NotSpam;PCL:0;RULEID:
x-forefront-prvs: 02318D10FB
x-forefront-antispam-report: SFV:NSPM;SFS:(6009001)(428001)(24454002)(164054003)(51704005)(479174003)(377454003)(189002)(199002)(66066001)(64706001)(77982001)(46102001)(101416001)(21056001)(82746002)(83322001)(36756003)(92726001)(79102001)(76482001)(20776003)(81542001)(15202345003)(86362001)(83072002)(81342001)(85852003)(92566001)(15975445006)(80022001)(83716003)(2656002)(87936001)(50986999)(54356999)(76176999)(99286001)(99396002)(33656002)(19580395003)(19580405001)(74502001)(4396001)(31966008)(74662001)(104396001);DIR:OUT;SFP:;SCL:1;SRVR:CO1PR07MB395;H:CO1PR07MB127.namprd07.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (: caviumnetworks.com does not designate permitted sender
 hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrew.Pinski@caviumnetworks.com; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andrew.Pinski@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrew.Pinski@caviumnetworks.com
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



> On Jun 3, 2014, at 9:40 AM, "Daney, David" <David.Daney@caviumnetworks.com> wrote:
> 
> In cases like this, I always wonder WWPD (What Would Pinski Do)...
> 
> Let's get him to opine.
> 
> Andrew, the patch in question is:
> 
> http://www.linux-mips.org/archives/linux-mips/2014-05/msg00309.html


Yes having two variables with the same register is safe as long as the only time the live ranges of them overlap is the inline-asm where they are used. 

Thanks,
Andrew

> 
> Thanks,
> David Daney
> 
>> On 06/03/2014 08:03 AM, Andreas Herrmann wrote:
>>> On Tue, Jun 03, 2014 at 10:30:31AM +0200, Ralf Baechle wrote:
>>>> On Wed, May 28, 2014 at 11:52:12PM +0200, Andreas Herrmann wrote:
>>>> 
>>>> +/*
>>>> + * Hypercalls for KVM.
>>>> + *
>>>> + * Hypercall number is passed in v0.
>>>> + * Return value will be placed in v0.
>>>> + * Up to 3 arguments are passed in a0, a1, and a2.
>>>> + */
>>>> +static inline unsigned long kvm_hypercall0(unsigned long num)
>>>> +{
>>>> +    register unsigned long n asm("v0");
>>>> +    register unsigned long r asm("v0");
>>> 
>>> Btw, is it safe to put two variables in the same register?
>> 
>> I think it's safe.
>> 
>> If we would have a matching constraint letter (say "v" for register v0) the
>> asm should translate to
>> 
>>         __asm__ __volatile__(
>>           KVM_HYPERCALL
>>                 : "=v" (n) : "v" (r) : "memory"
>>                 );
>> 
>> which isn't unusual on other archs. (Or maybe I am just biased from
>> x86 ... or missed something else.)
>> 
>>> The syscall wrappers that used to be in <asm/unistd.h> were occasionally
>>> hitting problems which eventually forced me to stop forcing variables
>>> into particular registers instead using a MOVE instruction to shove
>>> each variable into the right place.
>>> 
>>> Of course they were being used from non-PIC and PIC code, kernel and userland
>>> so GCC had a much better chance to do evil than in the hypercall wrapper
>>> case - but it made me paranoid ...
>> 
>> 
>> 
>> Andreas
>> 
