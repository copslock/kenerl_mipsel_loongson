Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 20:48:37 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:35377
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeC1SsaVvU6z convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Mar 2018 20:48:30 +0200
Received: by mail-lf0-x244.google.com with SMTP id t132-v6so4954879lfe.2;
        Wed, 28 Mar 2018 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f+re0HW/85NsVu/LcchDagF2oAbLnTK285vXqWgR0wo=;
        b=CD1wumWZSUY5qmKZuBBdEik1FbB1ON9wPMkNWAGm+C+H0J4OsDvYI3Xa15REqf8gXq
         0D4UvADPl6+TJ7K9OhzbxbY5jKPHXyzK9HBSCvwE2a5x3rsO2+1txf/+Eg1vvgalG++r
         3kHiFLki6AevUnXf34z3UHgayXT4D/iV8PLy/Iqk/OpCu+sQaV7ZYj7RquWO4Yrd677i
         nJbq9TzpDi8f+foLTeoZPBJkXyJ3UIb32SyLiuDNuT4HjxMJ2almwXn2YGXcNrJ60xke
         F5Yu4qj162FQhuKICDEsgcbRqknXIvTAE9S+Boq9jnTFE8o+o3XKRQzLBktJF3d3LRa+
         KoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f+re0HW/85NsVu/LcchDagF2oAbLnTK285vXqWgR0wo=;
        b=RTq+kI6Yq00bXdaQ4FmrDRhxk6oQkH4zrjl3v5GZOIz73xRGKgDfKMLE5IgUHGkns9
         UqSooD3Y7hQGOyr8VgPvn0nLmHgwUe4LJuK6XsZJhvly0fMDkP3LlZCLrq3EnvjLDw8s
         wmWMqAXLpiR/h2DlgkKxXL4S3x3TQLi5eLc+jIlqTxT3rGoFAWom3njT+/ee62I8/oog
         6MjrGZk6luCav9VrIlneblY9yUmtjSAIJwlIEY/5mMkDzUY3XDbCoHr2dNu4vzw6XDGA
         0uiVsEtaHtvL/y7k950YwI52oldw0Ikb56kqjjDyxWeeFJpmQZxOyZV/O2Rc9IBu9Vh5
         7t0w==
X-Gm-Message-State: AElRT7GuSoNx62NNv44SxG2pAZ1jLd+e2mA5uGIriedAEZHDRFucsGjw
        2UbKdho+Q+XlwL5xynAe4cM=
X-Google-Smtp-Source: AIpwx4+dwqVh1nEI930koA5Dbyw10gOxThstZ0P3Ms8fC+CWW2blWEE7IBEbV7AOxZv1966jnFaIUg==
X-Received: by 10.46.129.7 with SMTP id d7mr3425773ljg.148.1522262904968;
        Wed, 28 Mar 2018 11:48:24 -0700 (PDT)
Received: from [192.168.1.3] (broadband-188-255-70-164.moscow.rt.ru. [188.255.70.164])
        by smtp.gmail.com with ESMTPSA id q28-v6sm804487lfq.63.2018.03.28.11.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 11:48:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180327221635.GA3790@thunk.org>
Date:   Wed, 28 Mar 2018 21:48:22 +0300
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, rth@twiddle.net,
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
Message-Id: <B217D90A-6200-4257-804A-50D6C0308470@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <20180327221635.GA3790@thunk.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63300
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

> On 28 Mar 2018, at 01:16, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> On Tue, Mar 27, 2018 at 04:51:08PM +0300, Ilya Smith wrote:
>>> /dev/[u]random is not sufficient?
>> 
>> Using /dev/[u]random makes 3 syscalls - open, read, close. This is a performance
>> issue.
> 
> You may want to take a look at the getrandom(2) system call, which is
> the recommended way getting secure random numbers from the kernel.
> 
>>> Well, I am pretty sure userspace can implement proper free ranges
>>> tracking…
>> 
>> I think we need to know what libc developers will say on implementing ASLR in 
>> user-mode. I am pretty sure they will say ‘nether’ or ‘some-day’. And problem 
>> of ASLR will stay forever.
> 
> Why can't you send patches to the libc developers?
> 
> Regards,
> 
> 						- Ted

I still believe the issue is on kernel side, not in library.

Best regards,
Ilya
