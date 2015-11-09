Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2015 15:16:03 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:32854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013108AbbKIOQBPQVbo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Nov 2015 15:16:01 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id 0B36191EAA;
        Mon,  9 Nov 2015 14:15:59 +0000 (UTC)
Received: from tranklukator.brq.redhat.com (dhcp-1-102.brq.redhat.com [10.34.1.102])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tA9EFslj004411;
        Mon, 9 Nov 2015 09:15:55 -0500
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Mon,  9 Nov 2015 16:12:09 +0100 (CET)
Date:   Mon, 9 Nov 2015 16:12:04 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Amanieu d'Antras" <amanieu@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kenton Varda <kenton@sandstorm.io>
Subject: Re: [PATCH v2 00/20] Fix handling of compat_siginfo_t
Message-ID: <20151109151204.GA10760@redhat.com>
References: <1446684640-4112-1-git-send-email-amanieu@gmail.com> <CALCETrWKK_REdX7TJO8X7jC=8k=YdgJH_txXpC4Pdzn-tukg5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWKK_REdX7TJO8X7jC=8k=YdgJH_txXpC4Pdzn-tukg5A@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49874
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

On 11/07, Andy Lutomirski wrote:
>
> On Wed, Nov 4, 2015 at 4:50 PM, Amanieu d'Antras <amanieu@gmail.com> wrote:
> > One issue that isn't resolved in this series is sending signals between a 32-bit
> > process and 64-bit process. Sending a si_int will work correctly, but a si_ptr
> > value will likely get corrupted due to the different layouts of the 32-bit and
> > 64-bit siginfo_t structures.
>
> This is so screwed up it's not even funny.

Agreed,

> A 64-bit big-endian compat calls rt_sigqueueinfo.  It passes in (among
> other things) a sigval_t.  The kernel can choose to interpret it

I always thought that the kernel should not interpret it at all. And indeed,
copy_siginfo_to_user() does

	if (from->si_code < 0)
		return __copy_to_user(to, from, sizeof(siginfo_t))

probably copy_siginfo_to_user32() should do something similar, at least
it should not truncate ->si_code it it is less than zero.

Not sure what signalfd_copyinfo() should do.

But perhaps I was wrong, I failed to find man sigqueueinfo, and man
sigqueue() documents that it passes sigval_t.


> BTW, x86 has its own set of screwups here.  Somehow cr2 and error_code
> ended up as part of ucontext instead of siginfo, which makes
> absolutely no sense to me and bloats task_struct.

Yes, and probably ->ip should have been the part of siginfo too. Say,
if you get SIGBUS you can't trust sc->ip if another signal was dequeued
before SIGBUS, in this case sc->ip will point to the handler of that
another signal. That is why we have SYNCHRONOUS_MASK and it helps, but
still this doesn't look nice.

Oleg.
