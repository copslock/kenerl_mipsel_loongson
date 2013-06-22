Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jun 2013 21:14:13 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:48643 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816209Ab3FVTOLLEBK- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 22 Jun 2013 21:14:11 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5MJE2Gw021433
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 22 Jun 2013 15:14:02 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-192.brq.redhat.com [10.34.1.192])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r5MJDtFF018739;
        Sat, 22 Jun 2013 15:13:56 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Sat, 22 Jun 2013 21:09:47 +0200 (CEST)
Date:   Sat, 22 Jun 2013 21:09:40 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Daney <david.daney@cavium.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Dave Jones <davej@redhat.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3] kernel/signal.c: fix BUG_ON with SIG128 (MIPS)
Message-ID: <20130622190940.GA14150@redhat.com>
References: <1371821962-9151-1-git-send-email-james.hogan@imgtec.com> <51C47864.9030200@gmail.com> <20130621202244.GA16610@redhat.com> <51C4BB86.1020004@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51C4BB86.1020004@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
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

On 06/21, David Daney wrote:
>
> On 06/21/2013 01:22 PM, Oleg Nesterov wrote:
>> On 06/21, David Daney wrote:
>>>
>>> On 06/21/2013 06:39 AM, James Hogan wrote:
>>>> Therefore add sig_to_exitcode() and exitcode_to_sig() functions which
>>>> map signal numbers > 126 to exit code 126 and puts the remainder (i.e.
>>>> sig - 126) in higher bits. This allows WIFSIGNALED() to return true for
>>>> both SIG127 and SIG128, and allows WTERMSIG to be later updated to read
>>>> the correct signal number for SIG127 and SIG128.
>>>
>>> I really hate this approach.
>>>
>>> Can we just change the ABI to reduce the number of signals so that all
>>> the standard C library wait related macros don't have to be changed?
>>>
>>> Think about it, any user space program using signal numbers 127 and 128
>>> doesn't work correctly as things exist today, so removing those two will
>>> be no great loss.
>>
>> Oh, I agree.
>>
>> Besides, this changes ABI anyway. And if we change it we can do this in
>> a more clean way, afaics. MIPS should simply use 2 bytes in exit_code for
>> signal number.
>
> Wouldn't that break *all* existing programs that use signals?  Perhaps I
> misunderstand what you are suggesting.

Of course this will break the userspace more than the original patch,
that is why I said "And yes, this means that WIFSIGNALED/etc should
be updated".

> I am proposing that we just reduce the number of usable signals such
> that existing libc status checking macros/functions don't change in any
> way.

And I fully agree! Absolutely, sorry for confusion.


What I tried to say, _if_ we change the ABI instead, lets make this
change sane.

To me this hack is not sane. And btw, the patch doesn't look complete.
Say, wait_task_zombie() should do exitcode_to_sig() for ->si_status.

Oleg.
