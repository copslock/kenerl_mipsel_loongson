Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 13:14:42 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:54844 "EHLO
        mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011791AbcBKMOkhK2Mv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 13:14:40 +0100
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:24340 helo=mail.bmw-carit.de)
        by mail.bmw-carit.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Daniel.Wagner@bmw-carit.de>)
        id 1aTq8p-0000ZN-3B; Thu, 11 Feb 2016 13:14:36 +0100
Received: from handman.bmw-carit.intra (192.168.101.8) by
 Exchange2010.bmw-carit.intra (192.168.100.28) with Microsoft SMTP Server
 (TLS) id 14.3.123.3; Thu, 11 Feb 2016 13:14:35 +0100
X-CTCH-RefID: str=0001.0A0C0202.56BC7B2C.0028,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Subject: Re: [PATCH v4 2/2] mips: Differentiate between 32 and 64 bit ELF
 header
To:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <56BAD881.9000208@bmw-carit.de>
 <1455096081-7176-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1455096081-7176-3-git-send-email-daniel.wagner@bmw-carit.de>
 <20160211104903.GD11091@linux-mips.org>
 <alpine.DEB.2.00.1602111153320.15885@tp.orcam.me.uk>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
Message-ID: <56BC7B2B.9010605@bmw-carit.de>
Date:   Thu, 11 Feb 2016 13:14:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1602111153320.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.wagner@bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

On 02/11/2016 01:04 PM, Maciej W. Rozycki wrote:
> On Thu, 11 Feb 2016, Ralf Baechle wrote:
>> Thanks, applied.
>>
>> I'm getting a less spectacular warning from gcc 5.2:
>>
>>   CC      fs/proc/vmcore.o
>> fs/proc/vmcore.c: In function ¡parse_crash_elf64_headers¢:
>> fs/proc/vmcore.c:939:47: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> 
>  Yes, the temporaries still need to have their pointed types changed, to 
> `Elf32_Ehdr' and `Elf64_Ehdr' respectively, as in the original change.
> 
>  I had it mentioned in a WIP version of my review (stating that it would 
> verify that the correct type is used by the caller), but then deleted that 
> part inadvertently, sigh.

Yeah, that part fall through the cracks.

>  Daniel, sorry for the extra iteration.

No problem. Just a sec.

cheers,
daniel
