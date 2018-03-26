Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2018 21:45:47 +0200 (CEST)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:41263
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992363AbeCZTpka6ii8 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Mar 2018 21:45:40 +0200
Received: by mail-lf0-x242.google.com with SMTP id o102-v6so29882060lfg.8;
        Mon, 26 Mar 2018 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S9O5DCef4JN4Csb5MyH8I2J1Wv04nrFco3PatjlWPkU=;
        b=qB2uC9R3GQamk5ZHa6D74ooUCtnGaafclLwMkabw2jn2e2tbvlYToCvnHbUmCNQKbr
         TQgd8lIExYcq6M8I3OlqSulxNndIAtVnKWSfhTaSPV6Wh0SkO6pGm+0al/ckp6M1Ecv6
         QRYa4VYLX/2jMzzLAUuR6MA0NPXz7SlJQD1aJHKiHNd4UkOf3MRCG+QF5eutJhwBVKp1
         ylaDjJK+YXvLe6OoCRjCXCpsgwNjlmrwHD+S8PXZO1d0ZjjioSI5X5OFLQ+SxEK7bAZT
         iv1nzVsaCza7bXYTdufZuNzi7CeGIZzRH/pIlP72zAq+fU1SJ7aV2qAOXl2LWi9QVww2
         Gjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S9O5DCef4JN4Csb5MyH8I2J1Wv04nrFco3PatjlWPkU=;
        b=U6TFq4sLUb5ovHpc0rBxnK20Y8CVAyhX+Ve7JXlcu+puCM8Nj/46VXAIEWe9zthnoA
         mFTN0gOukiW2zKV4T7+7WRdCHVWi8W18OPCRSYtDdbWcIJIoaS+OveUI/GvjMh2TZSjY
         YSA7dFq4cjSA9GZpq2DIAqoT0l0TcBPhuWeGbtBX6I+zo73CTXF1L/up86J3n8e0aYJF
         8J4K0uwjTWd4LHvl15Ki64k3H3fb7UpY9zN09SuQMIIWy7pw4mRBDQpE0VpmbxhhutQL
         im3kk15BPUcVtXHgmS08CDvnM0N2dA3bOwfIwLyj18oI+rXbsS229CQLNY77Gma/6hId
         d0jQ==
X-Gm-Message-State: AElRT7FOka1rbIwtTlfEw3RWMLCMw3N92EtSKw0vq1r3iz0TVrfEFgR2
        94IZEQ+RXNK9XhOwpiSJmac=
X-Google-Smtp-Source: AG47ELs96IQevJq+QiFR0m8xT2y11IMUHK/lPpYnyCJwjaoyttBV/GAK2+2N9hFUOPvGaj/lHkjmUQ==
X-Received: by 10.46.156.81 with SMTP id t17mr10079546ljj.58.1522093534800;
        Mon, 26 Mar 2018 12:45:34 -0700 (PDT)
Received: from [192.168.1.3] (broadband-188-255-70-164.moscow.rt.ru. [188.255.70.164])
        by smtp.gmail.com with ESMTPSA id i62-v6sm3971155lfa.45.2018.03.26.12.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 12:45:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180326084650.GC5652@dhcp22.suse.cz>
Date:   Mon, 26 Mar 2018 22:45:31 +0300
Cc:     Matthew Wilcox <willy@infradead.org>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
        linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, jejb@parisc-linux.org,
        Helge Deller <deller@gmx.de>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
        Hugh Dickins <hughd@google.com>, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, Andrew Morton <akpm@linux-foundation.org>,
        steve.capper@arm.com, punit.agrawal@arm.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        Kees Cook <keescook@chromium.org>, bhsharma@redhat.com,
        riel@redhat.com, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, ross.zwisler@linux.intel.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blackzert@gmail.com
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


> On 26 Mar 2018, at 11:46, Michal Hocko <mhocko@kernel.org> wrote:
> 
> On Fri 23-03-18 20:55:49, Ilya Smith wrote:
>> 
>>> On 23 Mar 2018, at 15:48, Matthew Wilcox <willy@infradead.org> wrote:
>>> 
>>> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
>>>> Current implementation doesn't randomize address returned by mmap.
>>>> All the entropy ends with choosing mmap_base_addr at the process
>>>> creation. After that mmap build very predictable layout of address
>>>> space. It allows to bypass ASLR in many cases. This patch make
>>>> randomization of address on any mmap call.
>>> 
>>> Why should this be done in the kernel rather than libc?  libc is perfectly
>>> capable of specifying random numbers in the first argument of mmap.
>> Well, there is following reasons:
>> 1. It should be done in any libc implementation, what is not possible IMO;
> 
> Is this really so helpful?

Yes, ASLR is one of very important mitigation techniques which are really used 
to protect applications. If there is no ASLR, it is very easy to exploit 
vulnerable application and compromise the system. We can’t just fix all the 
vulnerabilities right now, thats why we have mitigations - techniques which are 
makes exploitation more hard or impossible in some cases.

Thats why it is helpful.

> 
>> 2. User mode is not that layer which should be responsible for choosing
>> random address or handling entropy;
> 
> Why?

Because of the following reasons:
1. To get random address you should have entropy. These entropy shouldn’t be 
exposed to attacker anyhow, the best case is to get it from kernel. So this is
a syscall.
2. You should have memory map of your process to prevent remapping or big
fragmentation. Kernel already has this map. You will got another one in libc.
And any non-libc user of mmap (via syscall, etc) will make hole in your map.
This one also decrease performance cause you any way call syscall_mmap 
which will try to find some address for you in worst case, but after you already
did some computing on it.
3. The more memory you use in userland for these proposal, the easier for
attacker to leak it or use in exploitation techniques.
4. It is so easy to fix Kernel function and so hard to support memory
management from userspace.

> 
>> 3. Memory fragmentation is unpredictable in this case
>> 
>> Off course user mode could use random ‘hint’ address, but kernel may
>> discard this address if it is occupied for example and allocate just before
>> closest vma. So this solution doesn’t give that much security like 
>> randomization address inside kernel.
> 
> The userspace can use the new MAP_FIXED_NOREPLACE to probe for the
> address range atomically and chose a different range on failure.
> 

This algorithm should track current memory. If he doesn’t he may cause
infinite loop while trying to choose memory. And each iteration increase time
needed on allocation new memory, what is not preferred by any libc library
developer.

Thats why I did this patch.

Thanks,
Ilya
