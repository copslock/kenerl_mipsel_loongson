Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jul 2013 22:58:22 +0200 (CEST)
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:30722
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6826533Ab3GVU6TNgWDg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Jul 2013 22:58:19 +0200
Received: from BL2PRD0712HT004.namprd07.prod.outlook.com (10.255.236.37) by
 BLUPR07MB146.namprd07.prod.outlook.com (10.242.200.14) with Microsoft SMTP
 Server (TLS) id 15.0.731.16; Mon, 22 Jul 2013 20:58:10 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.37) with Microsoft SMTP Server (TLS) id 14.16.329.3; Mon, 22 Jul
 2013 20:58:07 +0000
Message-ID: <51ED9CDD.2090507@caviumnetworks.com>
Date:   Mon, 22 Jul 2013 13:58:05 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Faidon Liambotis <paravoid@debian.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: cavium-octeon: fix I/O space setup on non-PCI
 systems
References: <1374522901-30290-1-git-send-email-aaro.koskinen@iki.fi> <51ED9153.4080904@gmail.com> <20130722203912.GA31864@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130722203912.GA31864@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 0915875B28
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(51704005)(164054003)(189002)(24454002)(199002)(377454003)(479174003)(19580405001)(56776001)(76786001)(81542001)(74502001)(47976001)(54316002)(54356001)(23756003)(74662001)(50986001)(53806001)(47736001)(69226001)(66066001)(53416003)(31966008)(19580385001)(65956001)(77096001)(80022001)(76796001)(64126003)(51856001)(36756003)(47446002)(15202345003)(19580395003)(15395725003)(50466002)(33656001)(59896001)(79102001)(80316001)(47776003)(74876001)(49866001)(4396001)(59766001)(16406001)(56816003)(77982001)(81342001)(46102001)(74706001)(76482001)(83322001)(65806001)(74366001)(83072001)(63696002)(6606295002);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB146;H:BL2PRD0712HT004.namprd07.prod.outlook.com;CLIP:64.2.3.195;RD:InfoNoRecords;MX:1;A:1;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37346
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

On 07/22/2013 01:39 PM, Aaro Koskinen wrote:
> On Mon, Jul 22, 2013 at 01:08:51PM -0700, David Daney wrote:
>> On 07/22/2013 12:55 PM, Aaro Koskinen wrote:
>>> Fix I/O space setup, so that on non-PCI systems using inb()/outb()
>>> won't crash the system. Some drivers may try to probe I/O space and for
>>> that purpose we can just allocate some normal memory initially. Drivers
>>> trying to reserve a region will fail early as we set the size to 0. If
>>> a real I/O space is present, the PCI/PCIe support code will re-adjust
>>> the values accordingly.
>>>
>>> Tested with EdgeRouter Lite by enabling CONFIG_SERIO_I8042 that caused
>>> the originally reported crash.
>>>
>>> Reported-by: Faidon Liambotis <paravoid@debian.org>
>>> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>> ---
>>>
>>> 	v2: Address the issues found from the first version of the patch
>>> 	    (http://marc.info/?t=137434204000002&r=1&w=2).
>>>
>>>   arch/mips/cavium-octeon/setup.c | 28 ++++++++++++++++++++++++++++
>>>   arch/mips/pci/pci-octeon.c      |  9 +++++----
>>>   2 files changed, 33 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
>>> index 48b08eb..6775bd1 100644
>>> --- a/arch/mips/cavium-octeon/setup.c
>>> +++ b/arch/mips/cavium-octeon/setup.c
>>> @@ -8,6 +8,7 @@
>>>    *   written by Ralf Baechle <ralf@linux-mips.org>
>>>    */
>>>   #include <linux/compiler.h>
>>> +#include <linux/vmalloc.h>
>>>   #include <linux/init.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/console.h>
>>> @@ -1139,3 +1140,30 @@ static int __init edac_devinit(void)
>>>   	return err;
>>>   }
>>>   device_initcall(edac_devinit);
>>> +
>>> +static void __initdata *octeon_dummy_iospace;
>>> +
>>> +static int __init octeon_no_pci_init(void)
>>> +{
>>> +	/*
>>> +	 * Initially assume there is no PCI. The PCI/PCIe platform code will
>>> +	 * later re-initialize these to correct values if they are present.
>>> +	 */
>>> +	octeon_dummy_iospace = vzalloc(IO_SPACE_LIMIT);
>>> +	set_io_port_base((unsigned long)octeon_dummy_iospace);
>>> +	ioport_resource.start = MAX_RESOURCE;
>>> +	ioport_resource.end = 0;
>>> +	return 0;
>>> +}
>>> +arch_initcall(octeon_no_pci_init);
>>> +
>>
>> Do we have any guarantee that this will happen before the
>> arch/mips/pci/* arch_initcalls ?
>
> Yes, it's guaranteed by the linking order ie. in which order the obj-y
> stuff gets listed in mips/Makefile. Currently cavium-octeon/ is processed
> before pci/.
>

Yes, I understand that.  The problem is when we start to use things like 
GCC's LTO, where we effectively compile the entire kernel as a single 
file.  Will this still work then?  I would rather not screw around with it.

Can you test it by making it a core_initcall() instead?  If that works 
you can add Acked-by: me.

Thanks,
David Daney


> Quoting including/linux/init.h:
>
> /* initcalls are now grouped by functionality into separate
>   * subsections. Ordering inside the subsections is determined
>   * by link order.
>
> A.
>
