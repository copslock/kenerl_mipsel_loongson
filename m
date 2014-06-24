Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 14:02:01 +0200 (CEST)
Received: from mail-we0-f176.google.com ([74.125.82.176]:60610 "EHLO
        mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860449AbaFXKXOvcMjj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 12:23:14 +0200
Received: by mail-we0-f176.google.com with SMTP id u56so103465wes.7
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=lrmVCndZwEAoiaaYdjk9BUICAJdy2+5jTWOF8l5iKJQ=;
        b=lUDPCAQ0baZlv2lMoW7TA+3AMX3HJcm/tUcXg2+Q1wAU83nNA84Qhbacfp1U9xTCVK
         cIEdTFPeZqOZijLx4gW2mqFkNkny4drY8Iyx9/G3YiD+AFv4/Ve38kFq/iflyi3Ep7E3
         PhNUxQyMqhWtIi9uP71fGXl6qL4EZ9ftdwgnhaIcumuB+mSMhLSwjuHdqbVr1o9dxOsY
         nchxs7tre77JKZOpGQljTtJREQyByFp3N1lMxULFAlBf0oeWsXym2W7bgWEr1cR11vJV
         C2SGzOyZjgOab1wfSr1dntm/26/h08kjn/g4F/+NUP3oJqMBzJi0nQp5pEzrbRYMUxl4
         sv6g==
X-Received: by 10.194.119.228 with SMTP id kx4mr18973wjb.108.1403605387763;
        Tue, 24 Jun 2014 03:23:07 -0700 (PDT)
Received: from [192.168.235.137] (mail.jambit.com. [95.157.63.22])
        by mx.google.com with ESMTPSA id f6sm41892763wiy.19.2014.06.24.03.23.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 03:23:07 -0700 (PDT)
Message-ID: <53A95187.4010805@gmail.com>
Date:   Tue, 24 Jun 2014 12:23:03 +0200
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Kees Cook <keescook@chromium.org>
CC:     mtk.manpages@gmail.com, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 1/1] man-pages: seccomp.2: document syscall
References: <20140623220150.GM5412@outflux.net>
In-Reply-To: <20140623220150.GM5412@outflux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <mtk.manpages@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mtk.manpages@gmail.com
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

On 06/24/2014 12:01 AM, Kees Cook wrote:
> Combines documentation from prctl, and in-kernel seccomp_filter.txt,
> along with new details specific to the new syscall.

Great work on the man page, Kees! (BTW, just looking at the complexity detailed
there further supports the decision to grant this functionality as a separate
syscall, rather than multiplexed into prctl(2).

Would there be some suitable, not too long program that we
could put in the man page as an example for using filters?

Cheers,

Michael


> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  man2/seccomp.2 |  333 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 333 insertions(+)
>  create mode 100644 man2/seccomp.2
> 
> diff --git a/man2/seccomp.2 b/man2/seccomp.2
> new file mode 100644
> index 0000000..de7fbf7
> --- /dev/null
> +++ b/man2/seccomp.2
> @@ -0,0 +1,333 @@
> +.\" Copyright (C) 2014 Kees Cook <keescook@chromium.org>
> +.\" and Copyright (C) 2012 Will Drewry <wad@chromium.org>
> +.\" and Copyright (C) 2008 Michael Kerrisk <mtk.manpages@gmail.com>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.TH SECCOMP 2 2014-06-23 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +seccomp \-
> +operate on Secure Computing state of the process
> +.SH SYNOPSIS
> +.nf
> +.B #include <linux/seccomp.h>
> +.B #include <linux/filter.h>
> +.B #include <linux/audit.h>
> +.B #include <linux/signal.h>
> +.B #include <sys/ptrace.h>
> +
> +.BI "int seccomp(unsigned int " operation ", unsigned int " flags ,
> +.BI "            unsigned char *" args );
> +.fi
> +.SH DESCRIPTION
> +The
> +.BR seccomp ()
> +system call operates on the Secure Computing (seccomp) state of the
> +current process.
> +
> +Currently, Linux supports the following
> +.IR operation
> +values:
> +.TP
> +.BR SECCOMP_SET_MODE_STRICT
> +Only system calls that the thread is permitted to make are
> +.BR read (2),
> +.BR write (2),
> +.BR _exit (2),
> +and
> +.BR sigreturn (2).
> +Other system calls result in the delivery of a
> +.BR SIGKILL
> +signal. Strict secure computing mode is useful for number-crunching
> +applications that may need to execute untrusted byte code, perhaps
> +obtained by reading from a pipe or socket.
> +
> +This operation is available only if the kernel is configured with
> +.BR CONFIG_SECCOMP
> +enabled.
> +
> +The value of
> +.IR flags
> +must be 0, and
> +.IR args
> +must be NULL.
> +
> +This operation is functionally identical to calling
> +.IR "prctl(PR_SET_SECCOMP,\ SECCOMP_MODE_STRICT)" .
> +.TP
> +.BR SECCOMP_SET_MODE_FILTER
> +The system calls allowed are defined by a pointer to a Berkeley Packet
> +Filter (BPF) passed via
> +.IR args .
> +This argument is a pointer to
> +.IR "struct\ sock_fprog" ;
> +it can be designed to filter arbitrary system calls and system call
> +arguments. If the filter is invalid, the call will fail, returning
> +.BR EACCESS
> +in
> +.IR errno .
> +
> +If
> +.BR fork (2),
> +.BR clone (2),
> +or
> +.BR execve (2)
> +are allowed by the filter, any child processes will be constrained to
> +the same filters and system calls as the parent.
> +
> +Prior to using this operation, the process must call
> +.IR "prctl(PR_SET_NO_NEW_PRIVS,\ 1)"
> +or run with
> +.BR CAP_SYS_ADMIN
> +privileges in its namespace. If these are not true, the call will fail
> +and return
> +.BR EACCES
> +in
> +.IR errno .
> +This requirement ensures that filter programs cannot be applied to child
> +processes with greater privileges than the process that installed them.
> +
> +Additionally, if
> +.BR prctl (2)
> +or
> +.BR seccomp (2)
> +is allowed by the attached filter, additional filters may be layered on
> +which will increase evaluation time, but allow for further reduction of
> +the attack surface during execution of a process.
> +
> +This operation is available only if the kernel is configured with
> +.BR CONFIG_SECCOMP_FILTER
> +enabled.
> +
> +When
> +.IR flags
> +are 0, this operation is functionally identical to calling
> +.IR "prctl(PR_SET_SECCOMP,\ SECCOMP_MODE_FILTER,\ args)" .
> +
> +The recognized
> +.IR flags
> +are:
> +.RS
> +.TP
> +.BR SECCOMP_FILTER_FLAG_TSYNC
> +When adding a new filter, synchronize all other threads of the current
> +process to the same seccomp filter tree. If any thread cannot do this,
> +the call will not attach the new seccomp filter, and will fail returning
> +the first thread ID found that cannot synchronize.  Synchronization will
> +fail if another thread is in
> +.BR SECCOMP_MODE_STRICT
> +or if it has attached new seccomp filters to itself, diverging from the
> +calling thread's filter tree.
> +.RE
> +.SH FILTERS
> +When adding filters via
> +.BR SECCOMP_SET_MODE_FILTER ,
> +.IR args
> +points to a filter program:
> +
> +.in +4n
> +.nf
> +struct sock_fprog {
> +    unsigned short      len;    /* Number of filter blocks */
> +    struct sock_filter *filter;
> +};
> +.fi
> +.in
> +
> +Each program must contain one or more BPF instructions:
> +
> +.in +4n
> +.nf
> +struct sock_filter {    /* Filter block */
> +    __u16   code;       /* Actual filter code */
> +    __u8    jt;         /* Jump true */
> +    __u8    jf;         /* Jump false */
> +    __u32   k;          /* Generic multiuse field */
> +};
> +.fi
> +.in
> +
> +When executing the instructions, the BPF program executes over the
> +syscall information made available via:
> +
> +.in +4n
> +.nf
> +struct seccomp_data {
> +    int nr;                     /* system call number */
> +    __u32 arch;                 /* AUDIT_ARCH_* value */
> +    __u64 instruction_pointer;  /* CPU instruction pointer */
> +    __u64 args[6];              /* up to 6 system call arguments */
> +};
> +.fi
> +.in
> +
> +A seccomp filter may return any of the following values. If multiple
> +filters exist, the return value for the evaluation of a given system
> +call will always use the highest precedent value. (For example,
> +.BR SECCOMP_RET_KILL
> +will always take precedence.)
> +
> +In precedence order, they are:
> +.TP
> +.BR SECCOMP_RET_KILL
> +Results in the task exiting immediately without executing the
> +system call.  The exit status of the task (status & 0x7f) will
> +be
> +.BR SIGSYS ,
> +not
> +.BR SIGKILL .
> +.TP
> +.BR SECCOMP_RET_TRAP
> +Results in the kernel sending a
> +.BR SIGSYS
> +signal to the triggering task without executing the system call.
> +.IR siginfo\->si_call_addr
> +will show the address of the system call instruction, and
> +.IR siginfo\->si_syscall
> +and
> +.IR siginfo\->si_arch
> +will indicate which syscall was attempted.  The program counter will be
> +as though the syscall happened (i.e. it will not point to the syscall
> +instruction).  The return value register will contain an arch\-dependent
> +value; if resuming execution, set it to something sensible.
> +(The architecture dependency is because replacing it with
> +.BR ENOSYS
> +could overwrite some useful information.)
> +
> +The
> +.BR SECCOMP_RET_DATA
> +portion of the return value will be passed as
> +.IR si_errno .
> +
> +.BR SIGSYS
> +triggered by seccomp will have a
> +.IR si_code
> +of
> +.BR SYS_SECCOMP .
> +.TP
> +.BR SECCOMP_RET_ERRNO
> +Results in the lower 16-bits of the return value being passed
> +to userland as the
> +.IR errno
> +without executing the system call.
> +.TP
> +.BR SECCOMP_RET_TRACE
> +When returned, this value will cause the kernel to attempt to
> +notify a ptrace()-based tracer prior to executing the system
> +call.  If there is no tracer present,
> +.BR ENOSYS
> +is returned to userland and the system call is not executed.
> +
> +A tracer will be notified if it requests
> +.BR PTRACE_O_TRACESECCOMP
> +using
> +.IR ptrace(PTRACE_SETOPTIONS) .
> +The tracer will be notified of a
> +.BR PTRACE_EVENT_SECCOMP
> +and the
> +.BR SECCOMP_RET_DATA
> +portion of the BPF program return value will be available to the tracer
> +via
> +.BR PTRACE_GETEVENTMSG .
> +
> +The tracer can skip the system call by changing the syscall number
> +to \-1.  Alternatively, the tracer can change the system call
> +requested by changing the system call to a valid syscall number.  If
> +the tracer asks to skip the system call, then the system call will
> +appear to return the value that the tracer puts in the return value
> +register.
> +
> +The seccomp check will not be run again after the tracer is
> +notified.  (This means that seccomp-based sandboxes MUST NOT
> +allow use of ptrace, even of other sandboxed processes, without
> +extreme care; ptracers can use this mechanism to escape.)
> +.TP
> +.BR SECCOMP_RET_ALLOW
> +Results in the system call being executed.
> +
> +If multiple filters exist, the return value for the evaluation of a
> +given system call will always use the highest precedent value.
> +
> +Precedence is only determined using the
> +.BR SECCOMP_RET_ACTION
> +mask.  When multiple filters return values of the same precedence,
> +only the
> +.BR SECCOMP_RET_DATA
> +from the most recently installed filter will be returned.
> +.SH RETURN VALUE
> +On success,
> +.BR seccomp ()
> +returns 0.
> +On error, if
> +.BR SECCOMP_FILTER_FLAG_TSYNC
> +was used, the return value is the thread ID that caused the
> +synchronization failure. On other errors, \-1 is returned, and
> +.IR errno
> +is set to indicate the cause of the error.
> +.SH ERRORS
> +.BR seccomp ()
> +can fail for the following reasons:
> +.TP
> +.BR EACCESS
> +the caller did not have the
> +.BR CAP_SYS_ADMIN
> +capability, or had not set
> +.IR no_new_privs
> +before using
> +.BR SECCOMP_SET_MODE_FILTER .
> +.TP
> +.BR EFAULT
> +.IR args
> +was required to be a valid address.
> +.TP
> +.BR EINVAL
> +.IR operation
> +is unknown; or
> +.IR flags
> +are invalid for the given
> +.IR operation
> +.TP
> +.BR ESRCH
> +Another thread caused a failure during thread sync, but its ID could not
> +be determined.
> +.SH VERSIONS
> +This system call first appeared in Linux 3.16.
> +.\" FIXME Add glibc version
> +.SH CONFORMING TO
> +This system call is a nonstandard Linux extensions.
> +.SH NOTES
> +.BR seccomp ()
> +provides a superset of the functionality provided by
> +.IR PR_SET_SECCOMP
> +of
> +.BR prctl (2) .
> +(Which does not support
> +.IR flags .)
> +.SH SEE ALSO
> +.ad l
> +.nh
> +.BR prctl (2),
> +.BR ptrace (2),
> +.BR signal (7)
> +.BR socket (7)
> +.ad
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
