Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 13:46:05 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:32170 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029294AbcELLqEI5wUn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2016 13:46:04 +0200
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP; 12 May 2016 04:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,609,1455004800"; 
   d="scan'208";a="701019484"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.36])
  by FMSMGA003.fm.intel.com with ESMTP; 12 May 2016 04:45:50 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, John Youn <johnyoun@synopsys.com>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.seppala@gmail.com,
        linuxppc-dev@lists.ozlabs.org,
        Douglas Anderson <dianders@chromium.org>,
        Gregory Herrero <gregory.herrero@intel.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] usb: dwc2: fix regression on big-endian PowerPC/ARM systems
In-Reply-To: <2809110.sWekaCNVxS@wuerfel>
References: <1463050104-2788693-1-git-send-email-arnd@arndb.de> <8760ujecw2.fsf@linux.intel.com> <2809110.sWekaCNVxS@wuerfel>
User-Agent: Notmuch/0.22+11~g124a67e (http://notmuchmail.org) Emacs/25.0.93.2 (x86_64-pc-linux-gnu)
Date:   Thu, 12 May 2016 14:43:43 +0300
Message-ID: <87y47fcxhs.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <felipe.balbi@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: felipe.balbi@linux.intel.com
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


Hi,

(Arnd, you didn't Cc dwc2's maintainer. I'm also not part of TI anymore)

Arnd Bergmann <arnd@arndb.de> writes:
> On Thursday 12 May 2016 14:25:49 Felipe Balbi wrote:
>> >  {
>> >       u32 value = __raw_readl(addr);
>> >  
>> > -     /* In order to preserve endianness __raw_* operation is used. Therefore
>> > -      * a barrier is needed to ensure IO access is not re-ordered across
>> > +     /* in order to preserve endianness __raw_* operation is used. therefore
>> > +      * a barrier is needed to ensure io access is not re-ordered across
>> >        * reads or writes
>> >        */
>> >       mb();
>> > @@ -81,15 +93,32 @@ static inline void dwc2_writel(u32 value, void __iomem *addr)
>> >       __raw_writel(value, addr);
>> >  
>> >       /*
>> > -      * In order to preserve endianness __raw_* operation is used. Therefore
>> > -      * a barrier is needed to ensure IO access is not re-ordered across
>> > +      * in order to preserve endianness __raw_* operation is used. therefore
>> > +      * a barrier is needed to ensure io access is not re-ordered across
>> >        * reads or writes
>> >        */
>> >       mb();
>> > -#ifdef DWC2_LOG_WRITES
>> > -     pr_info("INFO:: wrote %08x to %p\n", value, addr);
>> > +#ifdef dwc2_log_writes
>> > +     pr_info("info:: wrote %08x to %p\n", value, addr);
>> >  #endif
>> >  }
>> > +#else
>
> Oops, the accidental lowercase conversion is still in here, I'll fix it
> up once we agree on the approach.
>
>> I still think this is something that should be handled at MIPS side, no ?
>
> As I explained, there isn't really anything we can do in MIPS code
> because of the way they have to handle PCI.
>
>> How many more drivers will we have to 'fix' like this ?
>
> Endianess problems will keep coming up, and we have hundreds or thousands
> of drivers that are written with a particular design in mind that could
> be wrong as soon as someone chooses to build an SoC that does things
> differently. Once that happens, we'll fix them.
>
> Also, Christian has already posted a better version of the patch
> that fixes this driver in an architecture independent way, but we still
> need a workaround for the stable backports.

hmmm, at least dwc3 (also from SNPS) has a couple bits where we can
choose endianess for registers and DMA descriptors. John, do we have the
same for dwc2 ? Wouldn't that be a better way to solve the problem ?

-- 
balbi
