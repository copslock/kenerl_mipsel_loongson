Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2014 00:23:04 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39392 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855122AbaHNWW7owvKB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2014 00:22:59 +0200
Received: by mail-pd0-f180.google.com with SMTP id v10so2315380pde.39
        for <multiple recipients>; Thu, 14 Aug 2014 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3nzQZTqA3gZs/buEqy2I49eTrxCes76fxE0EE0gouqQ=;
        b=Nidk833Lh8/nl7p3QYwcytHHrbMDJWOTtQbEMUMc8F41EiXums5/AiXulOq5nCFATw
         pGngNZFql4NenkVbkLndpej7YSlwmx/xmnxKYnVQPRiq+mseOTDFVv2L6sB47Ri8xloU
         mxBfvU0ZjGfAz3Nb++aLwY7jAVtHqX2IPqFFrNdzZ0lVdiyZQLz0taIYS7Ju9a/3rhpi
         lc5tuoD1L3k2aLYEHI8xbEZ6RRhbb3Z1JuaxSyTNSzo0rxXFTaA+V1P7Z3khh7CfRfLT
         60naZP6z5REzRQVCduBHAiVRiTgkVrCb5J4WHHn688cMfJoWRCg35eE/6yswBQHHWaWT
         5Dbg==
X-Received: by 10.70.60.169 with SMTP id i9mr4605530pdr.166.1408054972975;
        Thu, 14 Aug 2014 15:22:52 -0700 (PDT)
Received: from [192.168.1.102] ([223.72.65.32])
        by mx.google.com with ESMTPSA id rn7sm21342672pab.39.2014.08.14.15.22.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 14 Aug 2014 15:22:52 -0700 (PDT)
Message-ID: <53ED36AB.8020703@gmail.com>
Date:   Fri, 15 Aug 2014 06:22:35 +0800
From:   Chen Gang <gang.chen.5i5j@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Lennox Wu <lennox.wu@gmail.com>
CC:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rth@twiddle.net" <rth@twiddle.net>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.de>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "a-jacquiot@ti.com" <a-jacquiot@ti.com>,
        "starvik@axis.com" <starvik@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "rkuo@codeaurora.org" <rkuo@codeaurora.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "takata@linux-m32r.org" <takata@linux-m32r.org>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "deller@gmx.de" <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        Liqin Chen <liqin.linux@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "cmetcalf@tilera.com" <cmetcalf@tilera.com>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "gxt@mprc.pku.edu.cn" <gxt@mprc.pku.edu.cn>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "linux390@de.ibm.com" <linux390@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>,
        "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
        "linux@lists.openrisc.net" <linux@lists.openrisc.net>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "user-mode-linux-devel@lists.sourceforge.net" 
        <user-mode-linux-devel@lists.sourceforge.net>,
        "user-mode-linux-user@lists.sourceforge.net" 
        <user-mode-linux-user@lists.sourceforge.net>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
References: <53ECE9DD.80004@gmail.com> <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com> <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
In-Reply-To: <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <gang.chen.5i5j@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gang.chen.5i5j@gmail.com
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

On 08/15/2014 02:27 AM, Lennox Wu wrote:
> I don't think it's necessary, what's the benfit?
> 
> 2014-08-15 2:21 GMT+08:00 Vineet Gupta <Vineet.Gupta1@synopsys.com>:
> 
>> On Thursday 14 August 2014 09:55 AM, Chen Gang wrote:
[...]
>>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>>> index 9596b0a..e939abd 100644
>>> --- a/arch/arc/Kconfig
>>> +++ b/arch/arc/Kconfig
>>> @@ -35,6 +35,7 @@ config ARC
>>>       select OF_EARLY_FLATTREE
>>>       select PERF_USE_VMALLOC
>>>       select HAVE_DEBUG_STACKOVERFLOW
>>> +     select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
>>
>> It is not clear what exactly are you trying to fix. What doesn't work w/o
>> this
>> patch !
>>

For many individual modules may need check CPU_LITTLE_ENDIAN or
CPU_BIG_ENDIAN, which is an architecture's attribute.

Or they have to list many architectures which they support, which they
don't support. And still, it is not precise.

For architecture API, endian is a main architecture's attribute which
may be used by outside, so every architecture need let outside know
about it, explicitly.


Thanks.
-- 
Chen Gang

Open share and attitude like air water and life which God blessed
