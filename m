Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 21:23:17 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:48048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860001AbaG2TW4dRRyf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jul 2014 21:22:56 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6TJMdva002104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jul 2014 15:22:39 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s6TJMZwc018561;
        Tue, 29 Jul 2014 15:22:36 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Tue, 29 Jul 2014 21:21:00 +0200 (CEST)
Date:   Tue, 29 Jul 2014 21:20:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp
        fastpath
Message-ID: <20140729192056.GA6308@redhat.com>
References: <cover.1406604806.git.luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1406604806.git.luto@amacapital.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41798
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

Andy, to avoid the confusion: I am not trying to review this changes.
As you probably know my understanding of asm code in entry.S is very
limited.

Just a couple of questions to ensure I understand this correctly.

On 07/28, Andy Lutomirski wrote:
>
> This is both a cleanup and a speedup.  It reduces overhead due to
> installing a trivial seccomp filter by 87%.  The speedup comes from
> avoiding the full syscall tracing mechanism for filters that don't
> return SECCOMP_RET_TRACE.

And only after I look at 5/5 I _seem_ to actually understand where
this speedup comes from.

So. Currently tracesys: path always lead to "iret" after syscall, with
this change we can avoid it if phase_1() returns zero, correct?

And, this also removes the special TIF_SYSCALL_AUDIT-only case in entry.S,
cool.

I am wondering if we can do something similar with do_notify_resume() ?


Stupid question. To simplify, lets forget that syscall_trace_enter()
already returns the value. Can't we simplify the asm code if we do
not export 2 functions, but make syscall_trace_enter() return
"bool slow_path_is_needed". So that "tracesys:" could do

	// pseudo code

tracesys:
	SAVE_REST
	FIXUP_TOP_OF_STACK

	call syscall_trace_enter

	if (!slow_path_is_needed) {
		addq REST_SKIP, %rsp
		jmp system_call_fastpath
	}
	
	...

?

Once again, I am just curious, it is not that I actually suggest to consider
this option.

Oleg.
