Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 15:47:24 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:26596 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20028092AbXLQPrP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Dec 2007 15:47:15 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3777B3EC9; Mon, 17 Dec 2007 07:46:42 -0800 (PST)
Message-ID: <476699FA.5050606@ru.mvista.com>
Date:	Mon, 17 Dec 2007 18:47:06 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: PCI resource unavailable on mips
References: <1197557806.3370.7.camel@microwave.infinitevideocorporation.com>	 <20071214093945.GA25186@linux-mips.org>	 <1197666735.3800.1.camel@microwave.infinitevideocorporation.com>	 <20071216224617.GA18613@linux-mips.org> <1197904591.3351.5.camel@microwave.infinitevideocorporation.com>
In-Reply-To: <1197904591.3351.5.camel@microwave.infinitevideocorporation.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Jon Dufresne wrote:

> I did a bit more work and investigation on this and it turns out I could
> not read the mmio in kernel space because I had not done a
> pci_enable_device_bars() on the device. I had never done this on x86 so
> I didn't realize it was necessary.

>>The virtual address 0xc0300000 looks sensible and the physical address
>>0x24000000 is consistent with what you found in the BAR registers.  So that
>>all looks reasonable but that only means not obviously wrong.  So next I
>>wonder what the value of PCI_MMIO_BASE is ...

> The PCI_MMIO_BASE is a defined as:

>>#define PCI_MMIO_BASE            (0x00040000)

> This is define in the technical documentation as the offset to access
> pci config space from the mmio.

    From what mmio? If it's for accessing a config. space why then you're 
using it as an offset from BAR?

> I am using this because I know what the
> values should be so it provides a nice sanity check.

> Any idea what I might be doing wrong? How can I access this from user
> space?

    Your example doesn't make sense to me so far.

> Thanks,
> Jon

WBR, Sergei
