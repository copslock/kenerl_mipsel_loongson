Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 20:47:31 +0200 (CEST)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:38962
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbeC1SrYwnVsz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Mar 2018 20:47:24 +0200
Received: by mail-lf0-x242.google.com with SMTP id p142-v6so4929973lfd.6;
        Wed, 28 Mar 2018 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=egK4Hy+FSMVRapLItJLtWI4tYDufyZsulm/WqkNWwpk=;
        b=rho/w/GdqJxAuE5Zb9qX5hYgtEFMkl+4bKPLAesLv2h23Ls1RLt2o7h9vigxREBmwW
         oJc7zB8l7tTWE6vnFnZ8UOaCDrPTjbNu0wNyvPwnIr/izGzSQFKnQ/ckivvAckB3neM/
         wIaE4MNMjW8NN7Nn78+B6nial1Me7lo+tjQ/cRNntsYuZCe96d14RdObNEQYOkNV9ico
         cLJNsqGKNH/fgq6/ECk8h6q5oxnM3KJKWpIpLI27yQ978Q6hcrQdC1pnmBQprMfZfIWL
         Tsq/fhuvpSPik66hB7ybw8drTgKHhl3sfCUmh3OESwX8ZD15e6cKCwWXZL0q1JsfS9/k
         Kp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=egK4Hy+FSMVRapLItJLtWI4tYDufyZsulm/WqkNWwpk=;
        b=DnlH2yDnF9+M8QdSNlwq3vcifm345gKOfSvtZ7aAPG3OyrtBbMSSVfdvriSlCfO5m7
         JNZGyZ3gl3LW6VHVZUWvhjON4bQCEaRnJnxxqZbSOpu/l0xQ80BvfqX2Rr/jcN+1F8S6
         UmVa8Rv/PysEvl+MY7W8zLIqu2N2vNmp8Xz/9PXwm5GOtPhhYJTqcyAY3GWRSzQ4auxJ
         jQZQzpd9MAnEzy8CFlAQ2iTk9peJVAFHtgraeZLEpoXyaOiIODKpk7xeicSivNhmgjbi
         o/iKbauZFSBBsYk3TFaj/6ynvqv8lKu984zR9/d0uOf79EnAWhT1YQOveL1/XvrbfEkW
         /ijg==
X-Gm-Message-State: AElRT7F0n+aEYajj9sFlwGZlMRoyLMu1iiY0LGaWjiOCAFob3SxqQVx0
        pktsA79X1sml6nMH1s2lWi0=
X-Google-Smtp-Source: AIpwx4+lsHvtjhLjCcXjBXBn1z49okua4IaPsbe3rtqidSroBGFiCxGLbyqUhhZnyXsQU/PgVs+kPg==
X-Received: by 10.46.151.213 with SMTP id m21mr3169611ljj.31.1522262839209;
        Wed, 28 Mar 2018 11:47:19 -0700 (PDT)
Received: from [192.168.1.3] (broadband-188-255-70-164.moscow.rt.ru. [188.255.70.164])
        by smtp.gmail.com with ESMTPSA id x22sm715106ljj.74.2018.03.28.11.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 11:47:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180327143820.GH5652@dhcp22.suse.cz>
Date:   Wed, 28 Mar 2018 21:47:15 +0300
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
Message-Id: <F9D157F8-F70F-45BC-B9E4-B5CB7CC419F4@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <20180327143820.GH5652@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63299
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


> On 27 Mar 2018, at 17:38, Michal Hocko <mhocko@kernel.org> wrote:
> 
> On Tue 27-03-18 16:51:08, Ilya Smith wrote:
>> 
>>> On 27 Mar 2018, at 10:24, Michal Hocko <mhocko@kernel.org> wrote:
>>> 
>>> On Mon 26-03-18 22:45:31, Ilya Smith wrote:
>>>> 
>>>>> On 26 Mar 2018, at 11:46, Michal Hocko <mhocko@kernel.org> wrote:
>>>>> 
>>>>> On Fri 23-03-18 20:55:49, Ilya Smith wrote:
>>>>>> 
>>>>>>> On 23 Mar 2018, at 15:48, Matthew Wilcox <willy@infradead.org> wrote:
>>>>>>> 
>>>>>>> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
>>>>>>>> Current implementation doesn't randomize address returned by mmap.
>>>>>>>> All the entropy ends with choosing mmap_base_addr at the process
>>>>>>>> creation. After that mmap build very predictable layout of address
>>>>>>>> space. It allows to bypass ASLR in many cases. This patch make
>>>>>>>> randomization of address on any mmap call.
>>>>>>> 
>>>>>>> Why should this be done in the kernel rather than libc?  libc is perfectly
>>>>>>> capable of specifying random numbers in the first argument of mmap.
>>>>>> Well, there is following reasons:
>>>>>> 1. It should be done in any libc implementation, what is not possible IMO;
>>>>> 
>>>>> Is this really so helpful?
>>>> 
>>>> Yes, ASLR is one of very important mitigation techniques which are really used 
>>>> to protect applications. If there is no ASLR, it is very easy to exploit 
>>>> vulnerable application and compromise the system. We can’t just fix all the 
>>>> vulnerabilities right now, thats why we have mitigations - techniques which are 
>>>> makes exploitation more hard or impossible in some cases.
>>>> 
>>>> Thats why it is helpful.
>>> 
>>> I am not questioning ASLR in general. I am asking whether we really need
>>> per mmap ASLR in general. I can imagine that some environments want to
>>> pay the additional price and other side effects, but considering this
>>> can be achieved by libc, why to add more code to the kernel?
>> 
>> I believe this is the only one right place for it. Adding these 200+ lines of 
>> code we give this feature for any user - on desktop, on server, on IoT device, 
>> on SCADA, etc. But if only glibc will implement ‘user-mode-aslr’ IoT and SCADA 
>> devices will never get it.
> 
> I guess it would really help if you could be more specific about the
> class of security issues this would help to mitigate. My first
> understanding was that we we need some randomization between program
> executable segments to reduce the attack space when a single address
> leaks and you know the segments layout (ordering). But why do we need
> _all_ mmaps to be randomized. Because that complicates the
> implementation consirably for different reasons you have mentioned
> earlier.
> 

There are following reasons:
1) To protect layout if one region was leaked (as you said). 
2) To protect against exploitation of Out-of-bounds vulnerabilities in some 
cases (CWE-125 , CWE-787)
3) To protect against exploitation of Buffer Overflows in some cases (CWE-120)
4) To protect application in cases when attacker need to guess the address 
(paper ASLR-NG by  Hector Marco-Gisbert and  Ismael Ripoll-Ripoll)
And may be more cases.

> Do you have any specific CVE that would be mitigated by this
> randomization approach?
> I am sorry, I am not a security expert to see all the cosequences but a
> vague - the more randomization the better - sounds rather weak to me.

It is hard to name concrete CVE number, sorry. Mitigations are made to prevent 
exploitation but not to fix vulnerabilities. It means good mitigation will make 
vulnerable application crash but not been compromised in most cases. This means 
the better randomization, the less successful exploitation rate.


Thanks,
Ilya
