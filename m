Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 20:07:15 +0100 (CET)
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:60331 "EHLO
        e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006898AbaKXTHOP8NJb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 20:07:14 +0100
Received: from /spool/local
        by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Mon, 24 Nov 2014 19:07:08 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp16.uk.ibm.com (192.168.101.146) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 24 Nov 2014 19:07:06 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 535C72190046
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 19:06:38 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAOJ75f36750490
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 19:07:05 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAOE49io031377
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 09:04:10 -0500
Received: from oc1450873852.ibm.com (sig-9-79-90-165.de.ibm.com [9.79.90.165])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAOE48gR031360;
        Mon, 24 Nov 2014 09:04:08 -0500
Message-ID: <547381D7.2070404@de.ibm.com>
Date:   Mon, 24 Nov 2014 20:07:03 +0100
From:   Christian Borntraeger <borntraeger@de.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     David Howells <dhowells@redhat.com>,
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
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com> <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com> <15567.1416835858@warthog.procyon.org.uk> <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com> <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
In-Reply-To: <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112419-0025-0000-0000-0000028DF40A
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44391
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

Am 24.11.2014 um 19:35 schrieb Linus Torvalds:
> On Mon, Nov 24, 2014 at 10:02 AM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> If the goal is to catch non-scalar users, the following is shorter:
>> #define ACCESS_ONCE(x) (((typeof(x))0) + *(volatile typeof(x) *)&(x))
> 
> Me likey. It probably works well in practice, although I think
> 
>  - the "(typeof(x))0)" seems unnecessary and wrong. Why not just "0"?
> The typeof is not just longer, but it is incorrect for pointer types
> (you can add 0 to a pointer, but you cannot add two pointers together)
> 
>  - it does mean that the resulting type ends up being upgraded to
> "int", for the usual C type reasons.
> 
> Note that the "upgraded to 'int'" is true with or without the
> "(typeof(x))0". If you add two 'char' values, the addition is still
> done in 'int'.
> 
> Maybe you *meant* that typeof to fix the second problem, like so:
> 
>   (typeof(x)) (0 + *(volatile typeof(x) *)&(x))
> 
> Hmm? That casts the result of the addition, not the zero.

Looks really nice, but does not work with ACCESS_ONCE is on the left-hand side:


include/linux/rculist.h: In function 'hlist_add_before_rcu':
./arch/x86/include/asm/barrier.h:127:18: error: lvalue required as left operand of assignment
  ACCESS_ONCE(*p) = (v);      \

Alexei's variant is also broken:

include/linux/cgroup.h: In function 'task_css':
include/linux/compiler.h:381:40: error: invalid operands to binary + (have 'struct css_set *' and 'struct css_set * volatile')
 #define ACCESS_ONCE(x) (((typeof(x))0) + *(volatile typeof(x) *)&(x))

Anyone with a new propopal? ;-)                                        ^

Christian
