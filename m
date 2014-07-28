Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2014 19:41:11 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:35083 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861119AbaG1RjWU2OrJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jul 2014 19:39:22 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6SHd67a006943
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jul 2014 13:39:07 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s6SHd2Aw022718;
        Mon, 28 Jul 2014 13:39:02 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Mon, 28 Jul 2014 19:37:28 +0200 (CEST)
Date:   Mon, 28 Jul 2014 19:37:23 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com
Subject: Re: [PATCH v3 6/8] x86: Split syscall_trace_enter into two phases
Message-ID: <20140728173723.GA20993@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41711
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

Hi Andy,

I am really sorry for delay.

This is on top of the recent change from Kees, right? Could me remind me
where can I found the tree this series based on? So that I could actually
apply these changes...

On 07/21, Andy Lutomirski wrote:
>
> +long syscall_trace_enter_phase2(struct pt_regs *regs, u32 arch,
> +				unsigned long phase1_result)
>  {
>  	long ret = 0;
> +	u32 work = ACCESS_ONCE(current_thread_info()->flags) &
> +		_TIF_WORK_SYSCALL_ENTRY;
> +
> +	BUG_ON(regs != task_pt_regs(current));
>  
>  	user_exit();
>  
> @@ -1458,17 +1562,20 @@ long syscall_trace_enter(struct pt_regs *regs)
>  	 * do_debug() and we need to set it again to restore the user
>  	 * state.  If we entered on the slow path, TF was already set.
>  	 */
> -	if (test_thread_flag(TIF_SINGLESTEP))
> +	if (work & _TIF_SINGLESTEP)
>  		regs->flags |= X86_EFLAGS_TF;

This looks suspicious, but perhaps I misread this change.

If I understand correctly, syscall_trace_enter() can avoid _phase2() above.
But we should always call user_exit() unconditionally?

And we should always set X86_EFLAGS_TF if TIF_SINGLESTEP? IIRC, TF can be
actually cleared on a 32bit kernel if we step over sysenter insn?

Oleg.
