Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Mar 2015 15:56:56 +0100 (CET)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:54841 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007513AbbCSO4zGEHTU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Mar 2015 15:56:55 +0100
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.14.3/8.14.3) with ESMTP id t2JEtx2x024752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 19 Mar 2015 14:56:00 GMT
Received: from [10.151.38.33] ([10.151.38.33])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t2JEtw6M006250;
        Thu, 19 Mar 2015 15:55:58 +0100
Message-ID: <550AE37E.1020908@nokia.com>
Date:   Thu, 19 Mar 2015 15:55:58 +0100
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     ext Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     ext David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney@cavium.com>, ddaney.cavm@gmail.com,
        "ext Daney, David" <David.Daney@caviumnetworks.com>,
        Rob Herring <robh@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rulf, Mathias (Nokia - DE/Ulm)" <mathias.rulf@nokia.com>
Subject: Re: [PATCH] pci: octeon: Remove udelay() causing huge IRQ latency
References: <55097811.8050003@nokia.com> <5509A39C.6010707@caviumnetworks.com> <5509A500.7020109@nokia.com> <20150318180638.GA10043@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150318180638.GA10043@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 319
X-purgate-ID: 151667::1426776960-00005972-E3892009/0/0
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46459
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

On 18/03/15 19:06, ext Aaro Koskinen wrote:
> You could at least say on which OCTEON platforms (e.g. OCTEON II
> or older) you tested the patch on, and tell about tested PCI bus
> topology and devices.

Octeon II CN68xx with Marvell XGE switch connected to PCIe.

-- 
Best regards,
Alexander Sverdlin.
