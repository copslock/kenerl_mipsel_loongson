Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2014 10:57:23 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42236 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816855AbaHOI5NOV8We (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2014 10:57:13 +0200
Received: by mail-pa0-f49.google.com with SMTP id hz1so3160668pad.22
        for <multiple recipients>; Fri, 15 Aug 2014 01:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VOeqw/n7UCD7wMmRLxfit5rey0ZmaJSVDygLXIGaB9g=;
        b=k3IYshbANurNxjIxvmqWAvWiikaWtHUqR+X+lmAlJjP/5jTWFLA6JGaODj+yzfwRzH
         BQFxBwglwpSJsVpmIEh5kO0DzTLWDCvZ7V3YMlMBLAHeO+stYkx1efLOLodmM7/W6ImM
         hurylFKXCDDO60sx9S49EFiYYEkbYPVCcalacUTq7NrnfAG2GyaLSP95H+Gw6D6ZGpfU
         jNOFq6CLFoQz51CKrGF10RJLaISITtyXAAOglQlaKuxhA0JGZGpEkEcGTyg9KUR0AnzH
         tlmnQlzXLwoq5U5N3t4cCuIbFZOdLRPbE8GjK8rUb35i9UobGEMan/XD1F2MeMCc54NO
         5dQQ==
X-Received: by 10.66.139.232 with SMTP id rb8mr10473263pab.130.1408093025145;
        Fri, 15 Aug 2014 01:57:05 -0700 (PDT)
Received: from [192.168.2.114] ([124.127.118.42])
        by mx.google.com with ESMTPSA id zh7sm25873054pab.1.2014.08.15.01.56.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2014 01:57:04 -0700 (PDT)
Message-ID: <53EDCC60.5040608@gmail.com>
Date:   Fri, 15 Aug 2014 17:01:20 +0800
From:   Chen Gang <gang.chen.5i5j@gmail.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.de>, linux@arm.linux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com,
        hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com,
        msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com,
        jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org,
        tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org,
        james.hogan@imgtec.com, Michal Simek <monstr@monstr.eu>,
        yasutake.koichi@jp.panasonic.com, jonas@southpole.se,
        jejb@parisc-linux.org, deller@gmx.de,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, mpe@ellerman.id.au,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        heiko.carstens@de.ibm.com, Liqin Chen <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, cmetcalf@tilera.com,
        jdike@addtoit.com, Richard Weinberger <richard@nod.at>,
        gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux390@de.ibm.com, x86@kernel.org, linux-alpha@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-m68k@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux@openrisc.net, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
References: <53ECE9DD.80004@gmail.com> <20140814180418.GA20777@linux-mips.org> <53ED34CE.3040001@gmail.com>
In-Reply-To: <53ED34CE.3040001@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <gang.chen.5i5j@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42118
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



On 8/15/14 6:14, Chen Gang wrote:
> On 08/15/2014 02:04 AM, Ralf Baechle wrote:
>>
> 
> OK, thanks, I assumes when support both endian, the default choice is
> CPU_BIG_ENDIAN, although no default value for choice (originally, I did
> worry about it).
> 
>> So I think you can just drop the MIPS segment from your patch.
>>
> 
> If what I assumes is correct, what you said sounds reasonable to me.
> 
> 

So for me, it is harmless to add CPU_*_ENDIAN explicitly, and can let
other members don't need think of.

By the way, for sh, it is almost the same case, except it contents the
default value, for me, it is clear enough, so I skip sh architecture in
this patch.


Thanks
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
