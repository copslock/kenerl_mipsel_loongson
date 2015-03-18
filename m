Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 15:16:06 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:50059 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008926AbbCROQE35lXL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2015 15:16:04 +0100
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.14.3/8.14.3) with ESMTP id t2IEFId1001449
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 18 Mar 2015 14:15:18 GMT
Received: from [10.151.38.33] ([10.151.38.33])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t2IEFEwZ016484;
        Wed, 18 Mar 2015 15:15:14 +0100
Message-ID: <55098872.9010605@nokia.com>
Date:   Wed, 18 Mar 2015 15:15:14 +0100
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
MIME-Version: 1.0
To:     ext Jiri Kosina <jkosina@suse.cz>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney@cavium.com>, ddaney.cavm@gmail.com,
        "ext Daney, David" <David.Daney@caviumnetworks.com>,
        Rob Herring <robh@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rulf, Mathias (Nokia - DE/Ulm)" <mathias.rulf@nokia.com>
Subject: Re: [PATCH] pci: octeon: Remove udelay() causing huge IRQ latency
References: <55097811.8050003@nokia.com> <alpine.LNX.2.00.1503181409110.6781@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1503181409110.6781@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 933
X-purgate-ID: 151667::1426688119-00007F9C-1AC48BB9/0/0
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46443
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

Hi!

On 18/03/15 14:11, ext Jiri Kosina wrote:
>> udelay() in PCI/PCIe read/write callbacks cause 30ms IRQ latency on Octeon
>> > platforms because these operations are called from PCI_OP_READ() and
>> > PCI_OP_WRITE() under raw_spin_lock_irqsave().
>> > 
>> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> I have no idea about the octeon platform, but how do you deal with the 
> fact that is stated by the comment you are removing? I.e.
> 
> 	/* Some PCI cards require delays when accessing config space. */
> 
> Is that not the case any more for some reason? If not, it really needs to 
> be explained in the changelog.

This udelay() should not have made its way upstream, someone overseen it during
code review. This is simply not allowed to have delayed read/write in the current
Linux PCI subsystem. And maybe there is no place for it at all.

-- 
Best regards,
Alexander Sverdlin.
