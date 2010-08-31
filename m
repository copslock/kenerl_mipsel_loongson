Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Aug 2010 17:59:55 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15460 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491173Ab0HaP7r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Aug 2010 17:59:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c7d27110000>; Tue, 31 Aug 2010 09:00:17 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 31 Aug 2010 08:59:44 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 31 Aug 2010 08:59:44 -0700
Message-ID: <4C7D26EF.3040509@caviumnetworks.com>
Date:   Tue, 31 Aug 2010 08:59:43 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     loody <miloody@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: some question about wmb in mips
References: <AANLkTikXife5CaPBQ4k_FUUM6-VD2C7SOOEbyugRhIqG@mail.gmail.com> <alpine.LFD.2.00.1006271745480.14683@eddie.linux-mips.org> <20100627205206.GB4554@linux-mips.org> <AANLkTim53N4t7PXiRPNqtP0G9cEjMdQY77m73MVkApH5@mail.gmail.com> <AANLkTinAP93+W8AYsc_PmjiE0doCERaYiQg4=ztZm_wA@mail.gmail.com> <20100831143304.GA16268@linux-mips.org>
In-Reply-To: <20100831143304.GA16268@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2010 15:59:44.0260 (UTC) FILETIME=[874A4440:01CB4925]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 08/31/2010 07:33 AM, Ralf Baechle wrote:
> On Mon, Aug 30, 2010 at 09:58:27PM +0800, loody wrote:
>
>> after reading the DMA api document and check the source code.
>> I found mips seems not implement "dma map ops", but x86 has implemented it.
>> What are they used for and why mips don't implement it?
>
> This is useful for multiple sets of methods on more complicated systems.
> Right now we just don't need that.
>

That said, I am preparing a set of patches that converts MIPS to use 
struct dma_map_ops.  They turn out to be useful in systems where PCI 
devices need different treatment than on-chip devices, and when bounce 
buffers are needed form some devices, but not others.

David Daney
