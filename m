Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Aug 2014 10:35:16 +0200 (CEST)
Received: from mail-pa0-x22f.google.com ([IPv6:2607:f8b0:400e:c03::22f]:64144
        "EHLO mail-pa0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006728AbaHXIe2Aue0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Aug 2014 10:34:28 +0200
Received: by mail-pa0-f47.google.com with SMTP id kx10so18704462pab.34
        for <multiple recipients>; Sun, 24 Aug 2014 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=T3T9xMS3YqF593Wd/rHQcQ++R98RQfRYlTFjQ8gQ42Q=;
        b=kgfTltaLRYV79LO112bq/RX//s+HEWhBHR8weNKhBI7gNkvHjNLXrbOn4FVCbnMAzI
         fkDz58bJPkPr1sr+UTOzHi7LrXztajMOdRjnNfsIdZMa0YoaTrJmfUaH33bpfk/SCH4g
         R25lKFcw5KSJSutKefgmQh1NLzuawWJkTiSZHQtjsDaHnsCaGalG5dxzal7DSOqN66G8
         GmxQnex5dNak/e+uRvQQP+iNiTKHVw6cUsDwU6eyWTo35E5qLgGiSINlJ6zd8T4TxP+7
         MZ0yMHc5yz8CfXIez+T4F0pIU7Z2/4gKaQq9y7EfWwWXH/IPmf4aK7Mng3koUk/mLLj8
         z8KA==
X-Received: by 10.70.132.162 with SMTP id ov2mr9066188pdb.118.1408869261613;
        Sun, 24 Aug 2014 01:34:21 -0700 (PDT)
Received: from [192.168.2.114] ([124.127.118.42])
        by mx.google.com with ESMTPSA id d13sm33843458pbu.72.2014.08.24.01.33.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Aug 2014 01:34:20 -0700 (PDT)
Message-ID: <53F9A48F.3020803@gmail.com>
Date:   Sun, 24 Aug 2014 16:38:39 +0800
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
        linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
References: <53ECE9DD.80004@gmail.com> <20140814180418.GA20777@linux-mips.org> <53ED34CE.3040001@gmail.com> <53EDCC60.5040608@gmail.com>
In-Reply-To: <53EDCC60.5040608@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <gang.chen.5i5j@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42195
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

Hello Maintainers:

Is this patch OK? If it pass basic checking, please let me know, and I
shall try to make another related patch for KBuild (I can do nothing
related with Kbuild, before get confirmation for this patch).

Thanks.

On 8/15/14 17:01, Chen Gang wrote:
> 
> 
> On 8/15/14 6:14, Chen Gang wrote:
>> On 08/15/2014 02:04 AM, Ralf Baechle wrote:
>>>
>>
>> OK, thanks, I assumes when support both endian, the default choice is
>> CPU_BIG_ENDIAN, although no default value for choice (originally, I did
>> worry about it).
>>
>>> So I think you can just drop the MIPS segment from your patch.
>>>
>>
>> If what I assumes is correct, what you said sounds reasonable to me.
>>
>>
> 
> So for me, it is harmless to add CPU_*_ENDIAN explicitly, and can let
> other members don't need think of.
> 
> By the way, for sh, it is almost the same case, except it contents the
> default value, for me, it is clear enough, so I skip sh architecture in
> this patch.
> 
> 
> Thanks
> 

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
