Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 03:28:10 +0100 (CET)
Received: from mail-qc0-f173.google.com ([209.85.216.173]:50995 "EHLO
        mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006937AbaKYC2JHv320 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 03:28:09 +0100
Received: by mail-qc0-f173.google.com with SMTP id i17so7882737qcy.18
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 18:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=WTNdLJSmkeir6COUvF3xrqnVQyzUy40kDX+f0ZmLQjg=;
        b=WKX8ph1Ef+dB4b5rG8wHCUrQokjrzCAwPVU4UCeCFWCItf7usrpG3uDS7fpW23NNQa
         tEpSMwhgetfqJ4ML5EUCE6p1gKUj837BF2HSZdMUzKk7thUbgftUCe013DPyb9N8WuEQ
         GetZ4P+nUBVthL91718ncXsGj95D1hAGEoi4oY1VaCMsukEj4JbpsDDCd2m/1rw6vAXJ
         U2lATVkps+yXh/BfKHDOTVa48dsk/Cpr5xQezOnZSS4zNdipiXH4ufKOXsnpm7maXOLX
         F/w9gesJ/0D2LeG/lL13e9xndBFWmaKm4SKG7UiURYZKDT3Io8Dt+ewO/Qqt7Y/zksuB
         PlGA==
MIME-Version: 1.0
X-Received: by 10.229.212.66 with SMTP id gr2mr33236724qcb.8.1416882483495;
 Mon, 24 Nov 2014 18:28:03 -0800 (PST)
Received: by 10.96.89.33 with HTTP; Mon, 24 Nov 2014 18:28:03 -0800 (PST)
Date:   Mon, 24 Nov 2014 18:28:03 -0800
Message-ID: <CAADnVQJc-RO9EdBY2-Q0mONSLYxsryD3cP8+LPXTaKbjbqtvtg@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-x86_64@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <alexei.starovoitov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexei.starovoitov@gmail.com
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

On Mon, Nov 24, 2014 at 4:00 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Nov 24, 2014 at 2:58 PM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> I've changed gcc pr58145-1.c reproducer to use
>> __read_once_size() approach above
>
> I don't think you did.
>
>> modified reproducer:
>> struct S { unsigned int data; };
>> void bar(int val)
>> {
>>   struct S _s = { .data = val };
>>   *(volatile struct S *) 0x880000UL = ACCESS_ONCE(&_s);
>> }
>
> My approach never had "volatile struct S *". The only volatile
> pointers were the actual byte/word/etc pointers, and those generated

you're right. In my invalid snippet above the ACCESS_ONCE
to struct on stack gets optimized away and only 'volatile struct *'
in left hand side is triggering the bug.

Have tried the following which blends your proposal
with original code from Christian:
/* bad
#define ACCESS_ONCE(x) *((volatile typeof(x) *)&(x))
*/

/* good */
#define ACCESS_ONCE(p) \
      ({ typeof(*p) __val; __read_once_size(p, &__val, sizeof(__val)); __val; })

static __always_inline void __read_once_size(volatile void *p, void
*res, int size)
{
     switch (size) {
     case 1: *(u8 *)res = *(volatile u8 *)p; break;
     case 2: *(u16 *)res = *(volatile u16 *)p; break;
     case 4: *(u32 *)res = *(volatile u32 *)p; break;
     case 8: *(u64 *)res = *(volatile u64 *)p; break;
     }
}

union ipte_control {
        unsigned long val;
        struct {
                unsigned long k  : 1;
                unsigned long kh : 31;
                unsigned long kg : 32;
        };
};

struct kvm_vcpu {
        union ipte_control ic;
};

void ipte_unlock_siif(struct kvm_vcpu *vcpu)
{
        union ipte_control old, new, *ic;

        ic = &vcpu->ic;
        do {
                new = old = ACCESS_ONCE(ic);
                new.kh--;
                if (!new.kh)
                        new.k = 0;
        } while (cmpxchg(&ic->val, old.val, new.val) != old.val);
}

generated code looks correct with and without strict-aliasing
and volatile marking is preserved properly.
(to check for volatile marks add -fdump-tree-optimized
 and look for {v} in *.optimized)

> Pretty? No. But then, the standard C aliasing rules are so broken that
> "pretty" doesn't really come into play..

Agree. I don't see any warnings or code generation issues with and
without strict-aliasing with your original __read_once_size(), so no need
to play union tricks. Initially I was worried that extra always_inline
function will make generated code worse in critical paths where
ACCESS_ONCE is used, but after looking close enough, it seems
all should be fine.

Note, with unmodified ACCESS_ONCE all architectures (even x64)
are missing volatile markings with gcc 4.6.3, 4.7.2 for Christian's
use case.
