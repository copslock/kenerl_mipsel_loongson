Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 23:26:54 +0200 (CEST)
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:23483
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822093AbaE2V0amu0Sq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 23:26:30 +0200
Received: from BLUPRD0711HT003.namprd07.prod.outlook.com (10.255.120.38) by
 BY2PR07MB631.namprd07.prod.outlook.com (10.141.223.22) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Thu, 29 May 2014 21:26:04 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.120.38) with Microsoft SMTP Server (TLS) id 14.16.459.0; Thu, 29 May
 2014 21:26:02 +0000
Message-ID: <5387A5E8.2030104@caviumnetworks.com>
Date:   Thu, 29 May 2014 14:26:00 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg KH <greg@kroah.com>, Florian Fainelli <f.fainelli@gmail.com>,
        "Alex Smith" <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "David Daney" <david.daney@cavium.com>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb host/MIPS: Remove hard-coded OCTEON platform
 information.
References: <Pine.LNX.4.44L0.1405291632360.1285-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1405291632360.1285-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Microsoft-Antispam: BL:0;ACTION:Default;RISK:Low;SCL:0;SPMLVL:NotSpam;PCL:0;RULEID:
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(52314003)(24454002)(479174003)(51704005)(377454003)(199002)(189002)(46102001)(65956001)(23756003)(47776003)(79102001)(80316001)(81342001)(20776003)(21056001)(92566001)(65806001)(76482001)(92726001)(77982001)(80022001)(64126003)(99396002)(2171001)(81542001)(64706001)(54356999)(87936001)(66066001)(76176999)(74502001)(50986999)(87266999)(83322001)(65816999)(85852003)(31966008)(102836001)(83506001)(36756003)(74662001)(33656002)(83072002)(101416001)(53416003)(50466002)(4396001)(59896001);DIR:OUT;SFP:;SCL:1;SRVR:BY2PR07MB631;H:BLUPRD0711HT003.namprd07.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40369
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

On 05/29/2014 01:55 PM, Alan Stern wrote:
> On Thu, 29 May 2014, David Daney wrote:
>
>> Several points of clarification:
>>
>> 1) I wrote the patch in question, not Florian.
>>
>> 2) I agree that OCTEON ehci/ohci support could probably be refactored
>> along the lines of Alan's suggestion.
>>
>> 3) This patch is a relatively minor change to an *existing* driver
>> rather than a completely new thing that hasn't yet been merged.
>>
>> 4) There is a lot of precedent for merging minor enhancements and bug
>> fixes instead of requiring a complete refactoring of *existing* code.
>>
>> All that said, I haven't dug into the ehci-platform and ohci-platform
>> enough to be able to opine on the best course of action in this
>> particular case.  I hope to be able to make a more educated follow-up
>> next week.
>
> Moving these into the respective platform drivers shouldn't be a big
> deal.  Below is a totally untested preliminary pass -- I'm pleased that
> it removes a lot more lines than it adds.
>
> This first attempt leaves a few matters unresolved:
>
> 	The EHCI DMA mask is coerced to 32 bits by ehci-platform.c.
> 	Maybe this should be controllable by a flag in the
> 	usb_ehci_pdata structure.
>
> 	The timing of the calls to octeon_[eo]hci_hw_start() might
> 	be wrong.  The patch does it before the memory resources
> 	are mapped, rather than afterward as it is done now.  I don't
> 	know if this will matter.
>
> 	The clock management is awkward at best.  But it's about the
> 	same as what we do now.
>
> Anyway, it shouldn't be hard to fix this up and get it working, and
> then rebase your patch on top of it.
>
> Alan Stern
>
>
>
>   arch/mips/cavium-octeon/octeon-platform.c |  274 +++++++++++++++++++++++++++++-
>   arch/mips/configs/cavium_octeon_defconfig |    3
>   drivers/usb/host/Kconfig                  |   18 +
>   drivers/usb/host/Makefile                 |    1
>   drivers/usb/host/ehci-hcd.c               |    5
>   drivers/usb/host/ehci-octeon.c            |  188 --------------------
>   drivers/usb/host/octeon2-common.c         |  200 ---------------------
>   drivers/usb/host/ohci-hcd.c               |    5
>   drivers/usb/host/ohci-octeon.c            |  202 ----------------------
>   9 files changed, 285 insertions(+), 611 deletions(-)
>

Thanks Alan,

That goes beyond the call of duty!


I will try to test (and improve if necessary) this patch.

David Daney
