Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Dec 2015 17:22:28 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:57571 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008993AbbL1QW1FWDtj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Dec 2015 17:22:27 +0100
Received: from static-50-53-43-78.bvtn.or.frontiernet.net ([50.53.43.78] helo=[192.168.1.15])
        by casper.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1aDaZ4-0002iU-DR; Mon, 28 Dec 2015 16:22:30 +0000
Subject: Re: Build regressions/improvements in v4.4-rc7
To:     Tejun Heo <tj@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1451305281-3911-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWnSERAHcxDV47FRY1Sz6XJku72xRPb1cGig7sSF8nf4A@mail.gmail.com>
 <20151228161839.GS5003@mtj.duckdns.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <568161BC.3060208@infradead.org>
Date:   Mon, 28 Dec 2015 08:22:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151228161839.GS5003@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <rdunlap@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@infradead.org
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

On 12/28/15 08:18, Tejun Heo wrote:
> On Mon, Dec 28, 2015 at 01:29:18PM +0100, Geert Uytterhoeven wrote:
>> On Mon, Dec 28, 2015 at 1:21 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> JFYI, when comparing v4.4-rc7[1] to v4.4-rc6[3], the summaries are:
>>>   - build errors: +14/-3
>>
>>   + /home/kisskb/slave/src/include/linux/kqueue.h: error:
>> dereferencing type-punned pointer will break strict-aliasing rules
>> [-Werror=strict-aliasing]:  => 186:2
> 
> kqueue.h?
> 

  + /home/kisskb/slave/src/include/linux/workqueue.h: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]:  => 186:2



-- 
~Randy
