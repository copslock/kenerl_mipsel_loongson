Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 02:57:56 +0100 (CET)
Received: from szxga03-in.huawei.com ([119.145.14.66]:16728 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014062AbaKTB5yn2RVR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2014 02:57:54 +0100
Received: from 172.24.2.119 (EHLO szxeml461-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id AXJ48693;
        Thu, 20 Nov 2014 09:56:24 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml461-hub.china.huawei.com
 (10.82.67.204) with Microsoft SMTP Server id 14.3.158.1; Thu, 20 Nov 2014
 09:49:08 +0800
Message-ID: <546D4891.80503@huawei.com>
Date:   Thu, 20 Nov 2014 09:49:05 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Liviu Dudau <liviu@dudau.co.uk>,
        "Tony Luck" <tony.luck@intel.com>,
        Russell King <linux@arm.linux.org.uk>,
        <linux-mips@linux-mips.org>, <linux-sh@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <x86@kernel.org>, <sparclinux@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-alpha@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] PCI: Rip out pci_bus_add_devices() from pci_scan_root_bus()
References: <1416382369-13587-1-git-send-email-wangyijing@huawei.com> <1416382369-13587-6-git-send-email-wangyijing@huawei.com> <1645037.uypArjN50l@wuerfel>
In-Reply-To: <1645037.uypArjN50l@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A010203.546D4A4B.00AA,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: ec113a9ea3b5cdd499692b1b2764ac76
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing@huawei.com
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

>> diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
>> index 076c35c..97f9730 100644
>> --- a/arch/alpha/kernel/pci.c
>> +++ b/arch/alpha/kernel/pci.c
>> @@ -334,6 +334,8 @@ common_init_pci(void)
>>  
>>  		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
>>  					hose, &resources);
>> +		if (bus)
>> +			pci_bus_add_devices(bus);
>>  		hose->bus = bus;
>>  		hose->need_domain_info = need_domain_info;
>>  		next_busno = bus->busn_res.end + 1;
> 
> How about making pci_bus_add_devices() handle a NULL argument to save
> the if() here and elsewhere?

This make sense, will update it, thanks!

>> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
>> index 1bf60b1..f083688 100644
>> --- a/arch/mips/pci/pci.c
>> +++ b/arch/mips/pci/pci.c
>> @@ -113,6 +113,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
>>  		if (!pci_has_flag(PCI_PROBE_ONLY)) {
>>  			pci_bus_size_bridges(bus);
>>  			pci_bus_assign_resources(bus);
>> +			pci_bus_add_devices(bus);
>>  		}
>>  	}
>>  }
> 
> This one looks wrong, I think you still want to call pci_bus_add_devices()
> even with PCI_PROBE_ONLY set.

Yes, this is my mistake, :(

> 
>> diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
>> index 1f80a88..007466e 100644
>> --- a/arch/tile/kernel/pci.c
>> +++ b/arch/tile/kernel/pci.c
>> @@ -308,6 +308,8 @@ int __init pcibios_init(void)
>>  			pci_add_resource(&resources, &iomem_resource);
>>  			bus = pci_scan_root_bus(NULL, 0, controller->ops,
>>  						controller, &resources);
>> +			if (bus)
>> +				pci_bus_add_devices(bus);
>>  			controller->root_bus = bus;
>>  			controller->last_busno = bus->busn_res.end;
>>  		}
> 
> Should the pci_bus_add_devices come after setting the bus numbers here?

I think it's doesn't matter, but move it backward is ok to me.

> 
> 	Arnd
> 
> .
> 


-- 
Thanks!
Yijing
