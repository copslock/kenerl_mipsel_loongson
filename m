Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 15:47:16 +0200 (CEST)
Received: from out02.mta.xmission.com ([166.70.13.232]:50536 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009557AbbGJNrNmkVU1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 15:47:13 +0200
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZDYdt-00071x-Cq; Fri, 10 Jul 2015 07:47:05 -0600
Received: from 67-3-205-90.omah.qwest.net ([67.3.205.90] helo=x220.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZDYds-0007iB-It; Fri, 10 Jul 2015 07:47:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>, linux-mips@linux-mips.org,
        Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Daniel Walker <dwalker@fifo99.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20150710113331.4368.10495.stgit@softrs>
        <20150710113331.4368.63745.stgit@softrs>
Date:   Fri, 10 Jul 2015 08:41:28 -0500
In-Reply-To: <20150710113331.4368.63745.stgit@softrs> (Hidehiro Kawai's
        message of "Fri, 10 Jul 2015 20:33:31 +0900")
Message-ID: <87wpy82kqf.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-AID: U2FsdGVkX18ypCK++FMGkczAFmIJ8av3PM38uk8K084=
X-SA-Exim-Connect-IP: 67.3.205.90
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is not available
X-SA-Exim-Version: 4.2.1 (built Wed, 24 Sep 2014 11:00:52 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48174
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

> You can call panic notifiers and kmsg dumpers before kdump by
> specifying "crash_kexec_post_notifiers" as a boot parameter.
> However, it doesn't make sense if kdump is not available.  In that
> case, disable "crash_kexec_post_notifiers" boot parameter so that
> you can't change the value of the parameter.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

You are confusing kexec on panic and CONFIG_CRASH_DUMP
which is about the tools for reading the state of the previous kernel.

Eric

> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> ---
>  kernel/panic.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 04e91ff..5252331 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -502,12 +502,14 @@ __visible void __stack_chk_fail(void)
>  core_param(pause_on_oops, pause_on_oops, int, 0644);
>  core_param(panic_on_warn, panic_on_warn, int, 0644);
>  
> +#ifdef CONFIG_CRASH_DUMP
>  static int __init setup_crash_kexec_post_notifiers(char *s)
>  {
>  	crash_kexec_post_notifiers = true;
>  	return 0;
>  }
>  early_param("crash_kexec_post_notifiers", setup_crash_kexec_post_notifiers);
> +#endif
>  
>  static int __init oops_setup(char *s)
>  {
