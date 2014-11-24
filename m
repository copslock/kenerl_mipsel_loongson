Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 10:19:52 +0100 (CET)
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:48457 "EHLO
        e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006986AbaKYJTvbASIy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 10:19:51 +0100
Received: from /spool/local
        by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Nov 2014 09:19:45 -0000
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp17.uk.ibm.com (192.168.101.147) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 24 Nov 2014 20:28:09 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9EB7D17D8042
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 20:28:23 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAOKS8jp66846830
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 20:28:08 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAOKS7pK030413
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:28:08 -0700
Received: from oc1450873852.ibm.com (sig-9-79-90-165.de.ibm.com [9.79.90.165])
        by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAOKS65o030400;
        Mon, 24 Nov 2014 13:28:06 -0700
Message-ID: <547394D5.4020301@de.ibm.com>
Date:   Mon, 24 Nov 2014 21:28:05 +0100
From:   Christian Borntraeger <borntraeger@de.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     paulmck@linux.vnet.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-x86_64@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar
 types
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com> <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com> <15567.1416835858@warthog.procyon.org.uk> <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com> <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com> <547381D7.2070404@de.ibm.com> <CA+55aFy+dunTcdgB4-BXsYiLDk9pf8b_L74ky-dMixpbX3JQQA@mail.gmail.com> <20141124194200.GR5050@linux.vnet.ibm.com>
In-Reply-To: <20141124194200.GR5050@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112420-0029-0000-0000-000001D66404
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44426
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

Am 24.11.2014 um 20:42 schrieb Paul E. McKenney:
> On Mon, Nov 24, 2014 at 11:14:42AM -0800, Linus Torvalds wrote:
>> On Mon, Nov 24, 2014 at 11:07 AM, Christian Borntraeger
>> <borntraeger@de.ibm.com> wrote:
>>>
>>> Looks really nice, but does not work with ACCESS_ONCE is on the left-hand side:
>>
>> Oh, I forgot about that. And that was indeed why I had done that whole
>> helper macro originally, with ACCESS_ONCE() itself just being the
>> dereference of the pointer.
> 
> OK, how about the following?
> 
> It complains if the variable is too large, for example, long long on
> 32-bit systems or large structures.  It is OK loading from and storing
> to small structures as well, which I am having a hard time thinking of
> as a disadvantage.

Well, the motivation for this series was that gcc  4.6 and 4.7 might ignore volatile for
such a case, see the original thread and this data structure

union ipte_control {
        unsigned long val;
        struct {
                unsigned long k  : 1;
                unsigned long kh : 31;
                unsigned long kg : 32;
        };
};

> ------------------------------------------------------------------------
> 
> #define get_scalar_volatile_pointer(x) ({ \
> 	volatile typeof(x) *__vp = &(x); \
> 	BUILD_BUG_ON(sizeof(*__vp) != sizeof(char) && \
> 		     sizeof(*__vp) != sizeof(short) && \
> 		     sizeof(*__vp) != sizeof(int) && \
> 		     sizeof(*__vp) != sizeof(long)); \
> 	__vp; })
> #define ACCESS_ONCE(x) (*get_scalar_volatile_pointer(x))
> 

This gives also several compiler errors when accessing u64 on a 32bit system. This is expected, but more widespread than expected - ouch.

Christian
