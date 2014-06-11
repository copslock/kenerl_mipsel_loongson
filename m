Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2014 00:27:23 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:44301 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834695AbaFKW1R6BYz8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jun 2014 00:27:17 +0200
Received: from anacreon.sc.intel.com (jfdmzpr04-ext.jf.intel.com [134.134.137.73])
        (authenticated bits=0)
        by mail.zytor.com (8.14.7/8.14.5) with ESMTP id s5BMR958019539
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Wed, 11 Jun 2014 15:27:09 -0700
Message-ID: <5398D7B4.5000303@zytor.com>
Date:   Wed, 11 Jun 2014 15:27:00 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
References: <cover.1402517933.git.luto@amacapital.net> <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net> <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com> <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com> <5398D59A.3030900@zytor.com> <CALCETrVMxkHcPXsEGtEc0Pr=Z80CzC0zWaQ9OdVdxi1CGuB4kQ@mail.gmail.com>
In-Reply-To: <CALCETrVMxkHcPXsEGtEc0Pr=Z80CzC0zWaQ9OdVdxi1CGuB4kQ@mail.gmail.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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

On 06/11/2014 03:22 PM, Andy Lutomirski wrote:
> On Wed, Jun 11, 2014 at 3:18 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 06/11/2014 02:56 PM, Andy Lutomirski wrote:
>>>
>>> 13ns is with the simplest nonempty filter.  I hope that empty filters
>>> don't work.
>>>
>>
>> Why wouldn't they?
> 
> Is it permissible to fall off the end of a BPF program?  I'm getting
> EINVAL trying to install an actual empty filter.  The filter I tested
> with was:
> 

What I meant was that there has to be a well-defined behavior for the
program falling off the end anyway, and that that should be preserved.

I guess it is possible to require that all code paths must provably
reach a termination point.

	-hpa
