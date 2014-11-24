Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 21:53:18 +0100 (CET)
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:45157 "EHLO
        e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011494AbaKXUxRJ4vtR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 21:53:17 +0100
Received: from /spool/local
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Mon, 24 Nov 2014 20:53:11 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 24 Nov 2014 20:53:08 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id DB2252190046
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 20:52:40 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAOKr8dP18022796
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 20:53:08 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAOKr7hm012215
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:53:08 -0700
Received: from oc1450873852.ibm.com (sig-9-79-90-165.de.ibm.com [9.79.90.165])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAOKr6fr012192;
        Mon, 24 Nov 2014 13:53:06 -0700
Message-ID: <54739AB2.8030002@de.ibm.com>
Date:   Mon, 24 Nov 2014 21:53:06 +0100
From:   Christian Borntraeger <borntraeger@de.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar
 types
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com> <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com> <15567.1416835858@warthog.procyon.org.uk> <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com> <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com> <547381D7.2070404@de.ibm.com>     <12209.1416859494@warthog.procyon.org.uk> <CA+55aFwHJyyo1y=-u=t798PFTeZN796hnwd9-XzEnL=JaqVmDw@mail.gmail.com>
In-Reply-To: <CA+55aFwHJyyo1y=-u=t798PFTeZN796hnwd9-XzEnL=JaqVmDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112420-0009-0000-0000-0000021E5B54
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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

Am 24.11.2014 um 21:34 schrieb Linus Torvalds:
> On Mon, Nov 24, 2014 at 12:04 PM, David Howells <dhowells@redhat.com> wrote:
>>
>> Reserve ACCESS_ONCE() for reading and add an ASSIGN_ONCE() or something like
>> that for writing?
> 
> I wouldn't mind that. We've had situations where reading and writing
> isn't really similar - like alpha where reading a byte is atomic, but
> writing one isn't.
> 
> Then we could also make it have the "get_user()/put_user()" kind of
> semantics - .and then use the same "sizeopf()" tricks that we use for
> get_user/put_user.
> 
> That would actually work around the gcc bug a completely different way:
> 
>   #define ACCESS_ONCE(p) \
>       ({ typeof(*p) __val; __read_once_size(p, &__val, sizeof(__val)); __val; })
> 
> and then we can do things like this:
> 
>   static __always_inline void __read_once_size(volatile void *p, void
> *res, int size)
>   {
>        switch (size) {
>        case 1: *(u8 *)res = *(volatile u8 *)p; break;
>        case 2: *(u16 *)res = *(volatile u16 *)p; break;
>        case 4: *(u32 *)res = *(volatile u32 *)p; break;
> #ifdef CONFIG_64BIT
>        case 8: *(u64 *)res = *(volatile u64 *)p; break;
> #endif
>        }
>   }
> 
> and same for ASSIGN_ONCE(val, p).
> 
> That also hopefully avoids the whole "oops, gcc has a bug", because
> the actual volatile access is always done using a scalar type, even if
> the type of "__val" may in fact be a structure.
> 
> Christian, how painful would that be? Sorry to try to make you do a
> totally different approach..

That looks like a lot of changes all over ACCESS_ONCE -> ASSIGN_ONCE:
git grep "ACCESS_ONCE.*=.*" 
gives me 200 placea not in Documentation.

Then there is still the 64bit accesses on 32bit via ACCESS_ONCE problem, which we could detect with a default cause in your code. We would need to audit and fix all places :-/


So the last proposal from Alexei, seems easier (for me at least :-) )
