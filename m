Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 00:54:07 +0200 (CEST)
Received: from mail-ua0-x242.google.com ([IPv6:2607:f8b0:400c:c08::242]:37134
        "EHLO mail-ua0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeC0WyAblejj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Mar 2018 00:54:00 +0200
Received: by mail-ua0-x242.google.com with SMTP id q12so360890uae.4
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2018 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=loyG69wHNKT9MD8vZID5AEtRxaGQKi0SO0iiz6eKOM8=;
        b=tVNFiWDGPzaBpGtLqtV67gyo2BOUAkOZTT3EDcPKPeTNVIQUi497/yBANLWkUNp0fn
         U9swGI96r/D3v3WDraDrrEHiAY30KXnI3qBml5JnRimZwIeRgYrSGmxqJeuRxAaf9Y8r
         oR2POJS1zgVRgMpQY4VPyDODefQaSL3PySfUxRXcfEVPdGX+Fv2yqtGbNHz42irNt1g7
         /256RR9tJlhuAoMfyrU3a7PHexQNCSrI8Kraos6PMIBaU0nj7nTA55O4HqcNSvhpetJX
         /81RECXXR22W/EoWZnm5knUo6vDl4rw2CdUU9mKwi2Nk2hJ8fbrdhZ8xp0MlVS0gBSIr
         w7Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=loyG69wHNKT9MD8vZID5AEtRxaGQKi0SO0iiz6eKOM8=;
        b=XXmu9+lJ0RL1minH7B9fQIiiBszZ35//aonmzw4oBnSqfyQyWAzLfb5kefa/oGYyhd
         m0ebDlqD3Dar5NpQ2N56ExxAxA8lTomzZheJYtAU4qwBk7IbVcYqfy5jNzjp2P+CjJAm
         k1SZGTJjR/F5FuYhR9u9obcI/1/2qfSbYAjIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=loyG69wHNKT9MD8vZID5AEtRxaGQKi0SO0iiz6eKOM8=;
        b=BQpEqCLhwtsQHROFk6R7OlgqGPiAlciAjyWsv/oQ2ebrWc2mfIHAryRVmiIs4zGcZH
         hgh2uL0C4HORR2Bhc89ihYkVKPNJ5ExOIacPwJs18D2d4ST7wnwfzRLPgyrcUAEXWjx8
         BhGYyRDci11hTo4Lw3PBAVkFYPDy+rZosPnZJBJHkctC0iafzesuKH/eA0GW7Sl3yvU1
         HczJpxEK1P5TvESKfYS/jbxA0Qwrf/pX856SxPuLz0k/io37NBNxlMB2C4+bROA03Xnc
         HB+RvFBlKx4GGrre6C7wxC6sqoealxNrUu2stAIxhfLX1KObpTkUqA9MW8Hi8I8I3DcN
         qQNA==
X-Gm-Message-State: AElRT7GAzPiFs8iOE/JdcFCCL8bZsxNvLeZJ2RJ4qF14xoMj6Xc5ix/c
        9RUpwqhIVxQ10mekhmWEK1/mqzcPOHqupPnwl/RVLg==
X-Google-Smtp-Source: AIpwx48PouASi+w3BYcLP4/4o2LBBa/BfdVGLPQILdIObxTm8V8k4beuyDA0Li8ZjcITo8QX4kLWHI62B5oMBhWckAg=
X-Received: by 10.176.78.167 with SMTP id l39mr993711uah.193.1522191234013;
 Tue, 27 Mar 2018 15:53:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.129.9 with HTTP; Tue, 27 Mar 2018 15:53:53 -0700 (PDT)
In-Reply-To: <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org> <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz> <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz> <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Mar 2018 15:53:53 -0700
X-Google-Sender-Auth: KTa7gMG05ILwOGyzGGVHG1c1Zfk
Message-ID: <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
To:     Ilya Smith <blackzert@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Richard Henderson <rth@twiddle.net>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        nyc@holomorphy.com, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <steve.capper@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Rik van Riel <riel@redhat.com>, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Tue, Mar 27, 2018 at 6:51 AM, Ilya Smith <blackzert@gmail.com> wrote:
>
>> On 27 Mar 2018, at 10:24, Michal Hocko <mhocko@kernel.org> wrote:
>>
>> On Mon 26-03-18 22:45:31, Ilya Smith wrote:
>>>
>>>> On 26 Mar 2018, at 11:46, Michal Hocko <mhocko@kernel.org> wrote:
>>>>
>>>> On Fri 23-03-18 20:55:49, Ilya Smith wrote:
>>>>>
>>>>>> On 23 Mar 2018, at 15:48, Matthew Wilcox <willy@infradead.org> wrote:
>>>>>>
>>>>>> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
>>>>>>> Current implementation doesn't randomize address returned by mmap.
>>>>>>> All the entropy ends with choosing mmap_base_addr at the process
>>>>>>> creation. After that mmap build very predictable layout of address
>>>>>>> space. It allows to bypass ASLR in many cases. This patch make
>>>>>>> randomization of address on any mmap call.
>>>>>>
>>>>>> Why should this be done in the kernel rather than libc?  libc is perfectly
>>>>>> capable of specifying random numbers in the first argument of mmap.
>>>>> Well, there is following reasons:
>>>>> 1. It should be done in any libc implementation, what is not possible IMO;
>>>>
>>>> Is this really so helpful?
>>>
>>> Yes, ASLR is one of very important mitigation techniques which are really used
>>> to protect applications. If there is no ASLR, it is very easy to exploit
>>> vulnerable application and compromise the system. We can’t just fix all the
>>> vulnerabilities right now, thats why we have mitigations - techniques which are
>>> makes exploitation more hard or impossible in some cases.
>>>
>>> Thats why it is helpful.
>>
>> I am not questioning ASLR in general. I am asking whether we really need
>> per mmap ASLR in general. I can imagine that some environments want to
>> pay the additional price and other side effects, but considering this
>> can be achieved by libc, why to add more code to the kernel?
>
> I believe this is the only one right place for it. Adding these 200+ lines of
> code we give this feature for any user - on desktop, on server, on IoT device,
> on SCADA, etc. But if only glibc will implement ‘user-mode-aslr’ IoT and SCADA
> devices will never get it.

I agree: pushing this off to libc leaves a lot of things unprotected.
I think this should live in the kernel. The question I have is about
making it maintainable/readable/etc.

The state-of-the-art for ASLR is moving to finer granularity (over
just base-address offset), so I'd really like to see this supported in
the kernel. We'll be getting there for other things in the future, and
I'd like to have a working production example for researchers to
study, etc.

-Kees

-- 
Kees Cook
Pixel Security
