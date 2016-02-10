Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 07:28:23 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:50098 "EHLO
        mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008799AbcBJG2Vsmn2p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 07:28:21 +0100
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:56435 helo=mail.bmw-carit.de)
        by mail.bmw-carit.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Daniel.Wagner@bmw-carit.de>)
        id 1aTOG9-0005rv-2b; Wed, 10 Feb 2016 07:28:17 +0100
Received: from handman.bmw-carit.intra (192.168.101.8) by
 Exchange2010.bmw-carit.intra (192.168.100.28) with Microsoft SMTP Server
 (TLS) id 14.3.123.3; Wed, 10 Feb 2016 07:28:17 +0100
X-CTCH-RefID: str=0001.0A0C0202.56BAD881.01F4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Subject: Re: [PATCH v3 3/3] mips: Differentiate between 32 and 64 bit ELF
 header
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <201602090033.mukhdG4N%fengguang.wu@intel.com>
 <56B99D55.2020301@bmw-carit.de>
 <alpine.DEB.2.00.1602091148570.15885@tp.orcam.me.uk>
 <56B9DDCA.3000700@bmw-carit.de>
 <alpine.DEB.2.00.1602091941400.15885@tp.orcam.me.uk>
CC:     kbuild test robot <lkp@intel.com>, <kbuild-all@01.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
Message-ID: <56BAD881.9000208@bmw-carit.de>
Date:   Wed, 10 Feb 2016 07:28:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1602091941400.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.wagner@bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51960
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

On 02/09/2016 08:44 PM, Maciej W. Rozycki wrote:
> On Tue, 9 Feb 2016, Daniel Wagner wrote:
> 
>>>  FWIW I think all the MIPS ABI flags stuff also needs to go outside the 
>>> conditional, because it's ABI agnostic.  I'll make the right change myself 
>>> on top of your fixes.  It'll remove a little bit of code duplication, 
>>> which is always welcome.
>>
>> Great, thanks for taking care of it.
> 
>  My ABI flags change has passed testing and I'm ready to post it, will you 
> be respinning your patch soon?

I was waiting for your cleanups and base my patches on top of it. Looks
like a small misunderstanding on my side :) I'll start on v4 right now.

cheers,
daniel
