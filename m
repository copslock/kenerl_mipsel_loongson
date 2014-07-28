Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2014 21:00:06 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:34927 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860064AbaG1TAAEBKqM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jul 2014 21:00:00 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6SIxjqR008754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jul 2014 14:59:46 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s6SIxfIn019986;
        Mon, 28 Jul 2014 14:59:42 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Mon, 28 Jul 2014 20:58:07 +0200 (CEST)
Date:   Mon, 28 Jul 2014 20:58:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com
Subject: TIF_NOHZ can escape nonhz mask? (Was: [PATCH v3 6/8] x86: Split
        syscall_trace_enter into two phases)
Message-ID: <20140728185803.GA24663@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net> <20140728173723.GA20993@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140728173723.GA20993@redhat.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41718
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

Off-topic, but...

On 07/28, Oleg Nesterov wrote:
>
> But we should always call user_exit() unconditionally?

Frederic, don't we need the patch below? In fact clear_() can be moved
under "if ()" too. and probably copy_process() should clear this flag...

Or. __context_tracking_task_switch() can simply do

	 if (context_tracking_cpu_is_enabled())
	 	set_tsk_thread_flag(next, TIF_NOHZ);
	 else
	 	clear_tsk_thread_flag(next, TIF_NOHZ);

and then we can forget about copy_process(). Or I am totally confused?


I am also wondering if we can extend user_return_notifier to handle
enter/exit and kill TIF_NOHZ.

Oleg.

--- x/kernel/context_tracking.c
+++ x/kernel/context_tracking.c
@@ -202,7 +202,8 @@ void __context_tracking_task_switch(stru
 				    struct task_struct *next)
 {
 	clear_tsk_thread_flag(prev, TIF_NOHZ);
-	set_tsk_thread_flag(next, TIF_NOHZ);
+	if (context_tracking_cpu_is_enabled())
+		set_tsk_thread_flag(next, TIF_NOHZ);
 }
 
 #ifdef CONFIG_CONTEXT_TRACKING_FORCE
