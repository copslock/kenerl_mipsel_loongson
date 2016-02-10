Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 09:51:34 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:34143 "EHLO
        mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010846AbcBJIvbAB8K6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 09:51:31 +0100
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:40607 helo=mail.bmw-carit.de)
        by mail.bmw-carit.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Daniel.Wagner@bmw-carit.de>)
        id 1aTQUi-0001vQ-38; Wed, 10 Feb 2016 09:51:29 +0100
Received: from handman.bmw-carit.intra (192.168.101.8) by
 Exchange2010.bmw-carit.intra (192.168.100.28) with Microsoft SMTP Server
 (TLS) id 14.3.123.3; Wed, 10 Feb 2016 09:51:28 +0100
X-CTCH-RefID: str=0001.0A0C0202.56BAFA11.000C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Subject: Re: [PATCH v3 1/3] mips: Use arch specific auxvec.h instead of
 generic-asm version
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk>
 <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1454946278-13859-2-git-send-email-daniel.wagner@bmw-carit.de>
 <alpine.DEB.2.00.1602081705470.15885@tp.orcam.me.uk>
 <56B98EAE.9080505@bmw-carit.de>
 <alpine.DEB.2.00.1602091129020.15885@tp.orcam.me.uk>
 <56B9DD98.7090809@bmw-carit.de>
 <alpine.DEB.2.00.1602091435340.15885@tp.orcam.me.uk>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
Message-ID: <56BAFA10.3090808@bmw-carit.de>
Date:   Wed, 10 Feb 2016 09:51:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1602091435340.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.wagner@bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51962
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

On 02/09/2016 03:51 PM, Maciej W. Rozycki wrote:
> On Tue, 9 Feb 2016, Daniel Wagner wrote:
> 
>>>  Can you try `make mrproper' (stash away your .config) and see if the 
>>> problem goes away?
>>
>> Indeed, 'make mrproper' did the trick. I am sorry for the noise. Until
>> now I never had to use mrproper before and therefore didn't think of it.
> 
>  People have been being hit by stale generated files recently and I reckon 
> effort has been taken to address the issue by removing them automagically 
> somehow on rebuilds.  Until that has been complete you're advised to clean 
> your build tree after an update, or maybe rebuild speculatively and then 
> clean only if something actually breaks.

FWIW, I just found out that running mrproper before building
fuloong2e_defconfig is fixing the problem reported kbuild robot too.
