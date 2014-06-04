Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2014 19:12:52 +0200 (CEST)
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:47075
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6816071AbaFDRMtzG8rJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jun 2014 19:12:49 +0200
Received: from BY2PRD0711HT002.namprd07.prod.outlook.com (10.255.88.165) by
 DM2PR07MB685.namprd07.prod.outlook.com (10.141.179.141) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 4 Jun 2014 17:12:41 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.88.165) with Microsoft SMTP Server (TLS) id 14.16.459.0; Wed, 4 Jun
 2014 17:12:40 +0000
Message-ID: <538F5387.8000200@caviumnetworks.com>
Date:   Wed, 4 Jun 2014 10:12:39 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Alex Smith <alex.smith@imgtec.com>
CC:     Aaro Koskinen <aaro.koskinen@nsn.com>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [1/3] MIPS: octeon: Add interface mode detection for Octeon II
References: <1401358203-60225-2-git-send-email-alex.smith@imgtec.com> <20140604144739.GB24816@ak-desktop.emea.nsn-net.net> <538F420A.60007@imgtec.com>
In-Reply-To: <538F420A.60007@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Microsoft-Antispam: BL:0;ACTION:Default;RISK:Low;SCL:0;SPMLVL:NotSpam;PCL:0;RULEID:
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(377454003)(479174003)(199002)(189002)(24454002)(51704005)(65816999)(87936001)(4396001)(21056001)(101416001)(33656002)(80022001)(79102001)(74502001)(87266999)(31966008)(99396002)(23756003)(54356999)(76482001)(65956001)(46102001)(74662001)(66066001)(77982001)(47776003)(76176999)(59896001)(65806001)(64706001)(20776003)(102836001)(81342001)(36756003)(50986999)(19580395003)(92726001)(50466002)(83506001)(53416003)(81542001)(19580405001)(83072002)(85852003)(80316001)(92566001)(83322001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB685;H:BY2PRD0711HT002.namprd07.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40433
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

On 06/04/2014 08:58 AM, Alex Smith wrote:
> On 04/06/14 15:47, Aaro Koskinen wrote:
>> On Thu, May 29, 2014 at 11:10:01AM +0100, Alex Smith wrote:
>>> Add interface mode detection for Octeon II. This is necessary to detect
>>> the interface modes correctly on the UBNT E200 board. Code is taken
>>> from the UBNT GPL source release, with some alterations: SRIO, ILK and
>>> RXAUI interface modes are removed and instead return disabled as these
>>> modes are not currently supported.
>>>
>>> Tested-by: David Daney <david.daney@cavium.com>
>>> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
>>
>> I tried booting ebb6800 board with these patches.

There seem to be problems (I think in the interrupt controller code) for 
cn68xx based systems in the kernel.org kernel.  So I couldn't get it to 
boot on my ebb6800 even to the point it tries to initialize the 
networking hardware.

Therefore ...

>>
>> It hangs somewhere in __cvmx_helper_xaui_enable() with XAUI port. Looking
>> at the UBNT GPL package, xaui init is quite different with 68XX specific
>> code paths.  Maybe those bits should be added too, or then disable XAUI
>> support as well?
>
> Probably the best thing to do for now would be to disable it. Does it
> boot successfully for you if you switch CVMX_HELPER_INTERFACE_MODE_XAUI
> to disabled?

... I don't think it matters.  The patch Alex et al. came up with is an 
improvement over what is already there.  The fact that there are still 
some configurations that don't work can be addressed with follow-on patches.

If I misunderstand the situation, please let me know, and we can work 
towards something better.

David Daney


>
> Alex
