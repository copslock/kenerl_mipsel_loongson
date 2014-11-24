Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 21:45:41 +0100 (CET)
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:55104 "EHLO
        e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006927AbaKXUpjxzfHT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 21:45:39 +0100
Received: from /spool/local
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Mon, 24 Nov 2014 20:45:34 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 24 Nov 2014 20:45:32 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3A1442190045
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 20:45:04 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAOKjVET8257930
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 20:45:31 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAOKjTNC006761
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:45:31 -0700
Received: from oc1450873852.ibm.com (sig-9-79-90-165.de.ibm.com [9.79.90.165])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAOKjSep006757;
        Mon, 24 Nov 2014 13:45:28 -0700
Message-ID: <547398E8.9070905@de.ibm.com>
Date:   Mon, 24 Nov 2014 21:45:28 +0100
From:   Christian Borntraeger <borntraeger@de.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
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
References: <CAADnVQJ6eXGiasoQwyAzuejLncEHdy6MOf+m3AHnpjgn0h3+OQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ6eXGiasoQwyAzuejLncEHdy6MOf+m3AHnpjgn0h3+OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112420-0005-0000-0000-00000234D8E8
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44403
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

Am 24.11.2014 um 21:29 schrieb Alexei Starovoitov:
> On Mon, Nov 24, 2014 at 11:07 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>>
>> Anyone with a new propopal? ;-)                                        ^
> 
> one more proposal :)
> #define __ACCESS_ONCE(x) ({ typeof(x) __var = 0; (volatile typeof(x) *)&(x); })
> #define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))

This seems to work. I only had to add an __always_unused to __var.


> 
> works as lvalue...
> the basic idea is the same:
> constant zero can be used to initialize any scalar
> (including pointers), but unions and structs will fail to compile as:
> "error: invalid initializer"
> 
> If I'm reading pr58145 gcc bug report correctly, it
> miscompiles only structs, so we can let ACCESS_ONCE
> to work on unions. Then the following will rejects structs only:
> #define __ACCESS_ONCE(x) ({ (typeof(x))0; (volatile typeof(x) *)&(x); })
> #define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
