Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 13:37:52 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:59392 "EHLO
        mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011118AbcBIMhuq4PPb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 13:37:50 +0100
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:46517 helo=mail.bmw-carit.de)
        by mail.bmw-carit.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Daniel.Wagner@bmw-carit.de>)
        id 1aT7Y9-0000rk-17; Tue, 09 Feb 2016 13:37:45 +0100
Received: from handman.bmw-carit.intra (192.168.101.8) by
 Exchange2010.bmw-carit.intra (192.168.100.28) with Microsoft SMTP Server
 (TLS) id 14.3.123.3; Tue, 9 Feb 2016 13:37:44 +0100
X-CTCH-RefID: str=0001.0A0C0205.56B9DD99.016B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Subject: Re: [PATCH v3 1/3] mips: Use arch specific auxvec.h instead of
 generic-asm version
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk>
 <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1454946278-13859-2-git-send-email-daniel.wagner@bmw-carit.de>
 <alpine.DEB.2.00.1602081705470.15885@tp.orcam.me.uk>
 <56B98EAE.9080505@bmw-carit.de>
 <alpine.DEB.2.00.1602091129020.15885@tp.orcam.me.uk>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
Message-ID: <56B9DD98.7090809@bmw-carit.de>
Date:   Tue, 9 Feb 2016 13:37:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1602091129020.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.wagner@bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51902
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

On 02/09/2016 12:46 PM, Maciej W. Rozycki wrote:
> On Tue, 9 Feb 2016, Daniel Wagner wrote:
> 
>> Also I looked at the cpp output and saw that there was no uapi/asm/auxvec.h
>> included instead it pulls arch/mips/include/generated/uapi/asm/auxvec.h
> 
>  Hmm, did you update your source in an old build tree and reuse it for a 
> new build?  The rule to make arch/mips/include/generated/uapi/asm/auxvec.h 
> was removed with commit ebb5e78cc634 ("MIPS: Initial implementation of a 
> VDSO") as arch/mips/include/uapi/asm/auxvec.h was added, in the 4.4-rc1 
> timeframe.  So the generated version is not supposed to be there anymore.
> 
>  Can you try `make mrproper' (stash away your .config) and see if the 
> problem goes away?

Indeed, 'make mrproper' did the trick. I am sorry for the noise. Until
now I never had to use mrproper before and therefore didn't think of it.

Thanks a lot!
Daniel
