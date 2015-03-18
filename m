Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 17:17:57 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:33490 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008926AbbCRQRzpC3I7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2015 17:17:55 +0100
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.14.3/8.14.3) with ESMTP id t2IGH8Lo005585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 18 Mar 2015 16:17:08 GMT
Received: from [10.151.38.33] ([10.151.38.33])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t2IGH4t2028753;
        Wed, 18 Mar 2015 17:17:04 +0100
Message-ID: <5509A500.7020109@nokia.com>
Date:   Wed, 18 Mar 2015 17:17:04 +0100
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
MIME-Version: 1.0
To:     ext David Daney <ddaney@caviumnetworks.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney@cavium.com>, ddaney.cavm@gmail.com,
        "ext Daney, David" <David.Daney@caviumnetworks.com>,
        Rob Herring <robh@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rulf, Mathias (Nokia - DE/Ulm)" <mathias.rulf@nokia.com>
Subject: Re: [PATCH] pci: octeon: Remove udelay() causing huge IRQ latency
References: <55097811.8050003@nokia.com> <5509A39C.6010707@caviumnetworks.com>
In-Reply-To: <5509A39C.6010707@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 787
X-purgate-ID: 151667::1426695429-00007F9C-13F018AA/0/0
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

Hello David,

On 18/03/15 17:11, ext David Daney wrote:
>> udelay() in PCI/PCIe read/write callbacks cause 30ms IRQ latency on Octeon
>> platforms because these operations are called from PCI_OP_READ() and
>> PCI_OP_WRITE() under raw_spin_lock_irqsave().
>>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Can you say how it was tested.  In principle I have no objections, but it would be nice to know how it was validated.

What do you want to know, how we've debugged IRQ latency and found the root cause or how we figured out
that delay is not necessary? I'm pretty sure that there is HW which requires it. Maybe it's even Octeon itself...
But putting udelay() in this callbacks is wrong wrong wrong. 

-- 
Best regards,
Alexander Sverdlin.
