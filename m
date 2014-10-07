Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 01:59:18 +0200 (CEST)
Received: from mail-bn1bon0078.outbound.protection.outlook.com ([157.56.111.78]:52640
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010789AbaJGX7QlkaEQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Oct 2014 01:59:16 +0200
Received: from dl.caveonetworks.com (64.2.3.195) by
 BY2PR07MB583.namprd07.prod.outlook.com (10.141.221.155) with Microsoft SMTP
 Server (TLS) id 15.0.1044.10; Tue, 7 Oct 2014 23:59:08 +0000
Message-ID: <54347E47.1080809@caviumnetworks.com>
Date:   Tue, 7 Oct 2014 16:59:03 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Rich Felker <dalias@libc.org>, David Daney <ddaney.cavm@gmail.com>,
        <libc-alpha@sourceware.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com> <20141006205459.GZ23797@brightrain.aerifal.cx> <5433071B.4050606@caviumnetworks.com> <20141007232019.GA30470@linux-mips.org>
In-Reply-To: <20141007232019.GA30470@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-ClientProxiedBy: BN1PR07CA0057.namprd07.prod.outlook.com (10.255.193.32) To
 BY2PR07MB583.namprd07.prod.outlook.com (10.141.221.155)
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB583;
X-Forefront-PRVS: 035748864E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(189002)(24454002)(51704005)(479174003)(377454003)(199003)(107046002)(83506001)(92726001)(80316001)(64126003)(92566001)(42186005)(59896002)(53416004)(85306004)(50466002)(97736003)(46102003)(40100002)(80022003)(23756003)(77096002)(102836001)(69596002)(4396001)(93886004)(101416001)(31966008)(120916001)(66066001)(99396003)(64706001)(65956001)(110136001)(76176999)(65806001)(87976001)(21056001)(87266999)(50986999)(65816999)(54356999)(95666004)(81156004)(99136001)(106356001)(33656002)(122386002)(36756003)(105586002)(47776003)(85852003)(76482002)(20776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB583;H:dl.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43099
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

On 10/07/2014 04:20 PM, Ralf Baechle wrote:
> On Mon, Oct 06, 2014 at 02:18:19PM -0700, David Daney wrote:
>
>>> As an alternative, if the space of possible instruction with a delay
>>> slot is sufficiently small, all such instructions could be mapped as
>>> immutable code in a shared mapping, each at a fixed offset in the
>>> mapping. I suspect this would be borderline-impractical (multiple
>>> megabytes?), but it is the cleanest solution otherwise.
>>>
>>
>> Yes, there are 2^32 possible instructions.  Each one is 4 bytes, plus you
>> need a way to exit after the instruction has executed, which would require
>> another instruction.  So you would need 32GB of memory to hold all those
>> instructions, larger than the 32-bit virtual address space.
>
> Plus errata support for some older CPUs requires no other instructions
> that might cause an exception to be present in the same cache line inflating
> the size to 32 bytes per instruction.
>
> I've contemplated a full emulation - but that would require an emulator that
> is capable of most of the instruction set.  With all the random ASEs around
> that would be hard to implement while the FPU emulator trampoline as currently
> used has the advantage of automatically supporting ASEs, known and unknown.
> So it's a huge bonus for maintenance.
>

Unfortunatly it breaks when our friends at Imgtec introduce their PC 
relative instructions in mipsr6, so an emulator may be unavoidable.

David Daney
