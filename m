Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 18:39:59 +0200 (CEST)
Received: from out02.mta.xmission.com ([166.70.13.232]:49611 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012123AbbHCQj6IAUz0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Aug 2015 18:39:58 +0200
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZMImD-0000D4-Hh; Mon, 03 Aug 2015 10:39:49 -0600
Received: from 97-119-22-40.omah.qwest.net ([97.119.22.40] helo=x220.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZMImC-000515-3t; Mon, 03 Aug 2015 10:39:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Ingo Molnar <mingo@kernel.org>
References: <20150724011615.6834.79628.stgit@softrs>
        <55BF4B1F.9000602@hitachi.com>
Date:   Mon, 03 Aug 2015 11:33:08 -0500
In-Reply-To: <55BF4B1F.9000602@hitachi.com> (Hidehiro Kawai's message of "Mon,
        03 Aug 2015 20:06:07 +0900")
Message-ID: <877fpcfi2j.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-AID: U2FsdGVkX1/0CTAbIx9SOF8ZHRkIhx6yC9XwH9DSbi8=
X-SA-Exim-Connect-IP: 97.119.22.40
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC V2 PATCH 0/1] kexec: crash_kexec_post_notifiers boot option related fixes
X-SA-Exim-Version: 4.2.1 (built Wed, 24 Sep 2014 11:00:52 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
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

Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:

> Hello Eric and Vivek,
>
> Do you have any comments?

crash_kexec_post_notifiers is a debugging hack to allow people to test
if the kmsg_dump works better than kexec.  crash_kexec_post_notifiers is
not, nor has it ever been a solution for general operation (which is
what I perceive this work trying to push).

I will not support any work that expands crash_kexec_post_notifiers to
be more than it currently is, because people want ``panic hooks'' to
run before kexec.  That appropach was extensively tested before kexec on
panic was implemented in the kernel and every implementation failed.
The practical symptom was that everything would work ok in testing but
on failures in the real world there would be enough going on in the
dying kernel that no crash dump would be taken.  kexec on panic on the
other hand works a reasonable fraction of the time.

I deeply and fundamentally can not support a general purpose hook being
called before kexec.  In 15 years of practice I have never heard of a
case where using a general purpose hook does anything but make kexec on
panic undebuggable in practice.

A specific hook for a very specific purpose when there is no other way
we can consider.

If you don't have something that generalises well into a general purpose
operation that it makes sense for everyone to call you can always use
the world's largest aka you can run code before the new kernel starts
that is loaded with kexec_load.

If you absolutely must run code in the dying code because you need lots
of the kernel infrastructure to work, and it is too hard to code a small
little bit of stand-alone assembly, I am sorry for you.  Experience shows
that will never work when the kernel fails in interesting ways.

So no.  I don't think there is any point to putting any more effort into
the crash_kexec_post_notifiers path because experience has shown over
the years that in practice it won't work for anyone, and if the code
doesn't work in practice there is no point in developing or implementing
it.

Eric
