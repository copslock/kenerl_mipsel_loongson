Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 06:50:23 +0200 (CEST)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:52796
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992273AbeC1EuQGiLR- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 06:50:16 +0200
Received: by mail-it0-x241.google.com with SMTP id k135-v6so2032697ite.2
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2018 21:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=enV9j3dbSLXmAE1CBSurMgsE0cKUXCQgdF0KSwOCHnE=;
        b=PvZKSr/5lu8kkzPgJFwDeGIIgehcO0pJMExSOQMvX1d07pqNd7BKWSDlCMlmV8FKqL
         pYuI0stPRaIycQKFf/1mCSl4SmbMnFufKPdGkVgOtBP4ELyxEthTyLyufmxxGDplntUo
         Uc5nHc2odODWMwDtXS2rK/9lvN/KvcXESpybSTerrNWKr1+JdLwtMtyFrUGSUKlCudcz
         zMMODKhjexRgusrmIQo5wLin8V8ssj+IjQ3nnfseZM071AsxJhua+0iH2GmFA6KIUNxZ
         RRh8LiocKOUL/T45FwidmdEV4AsktUfHP+o7qscoicCsEUFq4SljN0uihSUFYfs2KIHT
         78JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=enV9j3dbSLXmAE1CBSurMgsE0cKUXCQgdF0KSwOCHnE=;
        b=hwxYmIJqtFd4RSix4T71JT+B5tHZzEw+nq413GFTiWMwB/3NYJCRCIKhAMLE04e3zx
         Ik3NNIUnkKXZW2EWnA2PO1QtOHqNTbZeX7qa18SliWzh5WcjPGkIEQupTzf9/ZPd8Qzl
         Xrr7sGbNFJfqpWi03HDh94sTQG1/H+cmhbSYQetNp3BIb3/Y68gPcInYl9ndebCRDr69
         j1ntjoZijMCMBUsa9OzyDlLRNajfAIX7cWsWV4eVr3r2fBXbeZ182HTiq4CsbhE68slf
         Vt9iXD/lVuHe44em0NmD8H+Bdwa3N/REx2BoXsCFbVJOeX+YWx3T77OKjhzlIHyqU5wd
         7cfw==
X-Gm-Message-State: AElRT7F+EYCTMJ4DEvPt6uhnGxE/sakC78/xd1taTv3kn/bxAkPXsBUT
        EDy7xDAwEWRDqJQ3nMvHBkoOBQ==
X-Google-Smtp-Source: AIpwx4/pc1kbDb3jsikbAw35hWxe/fTYfVZJKliV1NwBrBfYuQEbCWfXGgw+29+c9lIuZBaZlXRdtg==
X-Received: by 2002:a24:195:: with SMTP id 143-v6mr1970811itk.35.1522212609695;
        Tue, 27 Mar 2018 21:50:09 -0700 (PDT)
Received: from [192.168.43.158] ([172.58.140.121])
        by smtp.googlemail.com with ESMTPSA id z125-v6sm1998486itb.2.2018.03.27.21.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 21:50:09 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
To:     Matthew Wilcox <willy@infradead.org>, Rich Felker <dalias@libc.org>
Cc:     Ilya Smith <blackzert@gmail.com>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
        linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
        jhogan@kernel.org, ralf@linux-mips.org, jejb@parisc-linux.org,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
        deepa.kernel@gmail.com, mhocko@suse.com, hughd@google.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        akpm@linux-foundation.org, steve.capper@arm.com,
        punit.agrawal@arm.com, paul.burton@mips.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
        nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, jack@suse.cz,
        ross.zwisler@linux.intel.com, jglisse@redhat.com,
        aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <20180323180024.GB1436@brightrain.aerifal.cx>
 <20180323190618.GA23763@bombadil.infradead.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <7e41ef7a-0bac-02fe-21fd-a1ed86c22230@landley.net>
Date:   Tue, 27 Mar 2018 23:50:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323190618.GA23763@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 03/23/2018 02:06 PM, Matthew Wilcox wrote:
> On Fri, Mar 23, 2018 at 02:00:24PM -0400, Rich Felker wrote:
>> On Fri, Mar 23, 2018 at 05:48:06AM -0700, Matthew Wilcox wrote:
>>> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
>>>> Current implementation doesn't randomize address returned by mmap.
>>>> All the entropy ends with choosing mmap_base_addr at the process
>>>> creation. After that mmap build very predictable layout of address
>>>> space. It allows to bypass ASLR in many cases. This patch make
>>>> randomization of address on any mmap call.
>>>
>>> Why should this be done in the kernel rather than libc?  libc is perfectly
>>> capable of specifying random numbers in the first argument of mmap.
>>
>> Generally libc does not have a view of the current vm maps, and thus
>> in passing "random numbers", they would have to be uniform across the
>> whole vm space and thus non-uniform once the kernel rounds up to avoid
>> existing mappings.
> 
> I'm aware that you're the musl author, but glibc somehow manages to
> provide etext, edata and end, demonstrating that it does know where at
> least some of the memory map lies.

You can parse /proc/self/maps, but it's really expensive and disgusting.

Rob
