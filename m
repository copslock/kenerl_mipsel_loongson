Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 21:12:24 +0200 (CEST)
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:18442
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835027Ab3FSTMVABpmJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jun 2013 21:12:21 +0200
Received: from BL2PRD0712HT001.namprd07.prod.outlook.com (10.255.236.34) by
 SN2PR07MB016.namprd07.prod.outlook.com (10.255.174.38) with Microsoft SMTP
 Server (TLS) id 15.0.702.21; Wed, 19 Jun 2013 19:12:12 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.34) with Microsoft SMTP Server (TLS) id 14.16.324.0; Wed, 19 Jun
 2013 19:12:11 +0000
Message-ID: <51C20289.1060303@caviumnetworks.com>
Date:   Wed, 19 Jun 2013 12:12:09 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com> <2302882.NVjP8DdXWY@wuerfel> <51C1E028.2040700@caviumnetworks.com> <201306192052.09575.arnd@arndb.de>
In-Reply-To: <201306192052.09575.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-Antispam-Report: SFV:SKI;SFS:;DIR:OUT;SFP:;SCL:0;SRVR:SN2PR07MB016;H:BL2PRD0712HT001.namprd07.prod.outlook.com;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37019
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

On 06/19/2013 11:52 AM, Arnd Bergmann wrote:
> On Wednesday 19 June 2013, David Daney wrote:
>> On 06/19/2013 03:01 AM, Arnd Bergmann wrote:
>
>>> It's also wrong to use the
>>> __raw_* variant, which is not guaranteed to be atomic and is not
>>> endian-safe.
>>
>> We do runtime probing and only use this function on platforms where it
>> is appropriate, so atomicity is not an issue.  As for endianess, I used
>> the __raw_ variant precisely because it is correct for both big and
>> little endian kernels.
>
> You don't know what the compiler turns a __raw_writeq into, it could
> always to eight byte wise stores, that's why typically writeq is
> an inline assembly while __raw_writeq is just a pointer dereference.

Well, I do know that for the cases of interest, it will be a single load 
or store, but it is moot, as I rewrote that part.

>
> __raw_* never do endian swaps,

Yes, I know that.

> so it will be wrong on either big-endian
> CPUs or on little-endian CPUs, depending on what the MMIO register
> needs.

Please see the instruction set reference manual 
(MD00087-2B-MIPS64BIS-AFP-03.51 or similar) available at:

http://www.mips.com/products/architectures/mips64/#specifications

... for why you are mistaken.  Pay particular attention to the low order 
address bit scrambling on narrow loads and stores and how this results 
in uniform (not affected by processor endian mode) load and store 
results for aligned 64-bit accesses.  In effect, it is magic, and 
__raw_writeq yields correct results in both big and little endian modes 
of operation.

David Daney.
