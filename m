Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 00:24:52 +0100 (CET)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:38818
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990486AbdL1XYoSA8qO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 00:24:44 +0100
Received: by mail-io0-x241.google.com with SMTP id 87so35535203ior.5
        for <linux-mips@linux-mips.org>; Thu, 28 Dec 2017 15:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5YmjNvodi+GHUVXPIsIfo7pnye0NuYIdv4EzQP6nscw=;
        b=QEFwuuuzO89cK5vFmp5rScQw8cQ7T2TWXlfu9WSWht4GhaZ+1BFmU7HEUIdmv/1+b3
         wzvP1Rk0l/3UkquqTolvSZaCDs2gzK9NK+kJRBptmXx/Qlk/qwasMCKzcCTuBeJMIvv3
         vFt+OlfJgBgQgXDNYkgV3x7sbVOQlUn9LnHbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5YmjNvodi+GHUVXPIsIfo7pnye0NuYIdv4EzQP6nscw=;
        b=nSQovOxxfqojJldV8Bv2bFqEB2UmmQo/7i2X6/rKDdFkLcflvLhjHKidg9Npv5zRg2
         hqjeI2VWh/WxXpAhP6W06IZrItU1umb3ob40/HVqGrRLNpQtEfLTFTyuviHIxlc1YKt8
         fTL31o5btqOOHnBA1P0xE2IfRAjXotitRgxB2daEVRFRfwSZdDrgk0qitDnFEw3K+M/0
         MbQBWi7EbkBR+WhRrt7eLrJat9I7XWQWSJC6m/42ycy7qXFN3TMPFG0J9EmG4nYAwJox
         BMoO3m3O6W7Nbqr5yaSRuuvgBb+zt9TuPcND4w+kILcsNnpG3+SfSMXb7ci3Gt8xxEM7
         DcwQ==
X-Gm-Message-State: AKGB3mIzc5OiCYyjzZ0ToljmF3xgzLDzRyRWkLbhEBHh9Mkvu2QLOksC
        OAm7xOsBLdL/m6bavHoTCQdtNUOKEsTE3xIY2B0TrA==
X-Google-Smtp-Source: ACJfBov9IrD+oyivAkgz96hraKRzxmVMopgDGZFTijSh8nlxAFcEjIGtTzycbi1+DfEx0Rx8e3vLwdvJk3OsLprnSHE=
X-Received: by 10.107.151.142 with SMTP id z136mr44520388iod.248.1514503477791;
 Thu, 28 Dec 2017 15:24:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.52.14 with HTTP; Thu, 28 Dec 2017 15:24:37 -0800 (PST)
In-Reply-To: <20171228104207.117ee0ff@gandalf.local.home>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-6-ard.biesheuvel@linaro.org> <20171228104207.117ee0ff@gandalf.local.home>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 28 Dec 2017 23:24:37 +0000
Message-ID: <CAKv+Gu-R6yf8C=ZgO8G5vmR+MZtFTijRg6+tH+qscT4ycy1PrQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] kernel: tracepoints: add support for relative references
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mips <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

On 28 December 2017 at 15:42, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 27 Dec 2017 08:50:30 +0000
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> To avoid the need for relocating absolute references to tracepoint
>> structures at boot time when running relocatable kernels (which may
>> take a disproportionate amount of space), add the option to emit
>> these tables as relative references instead.
>>
>
> I gave this patch a quick skim over. It appears to not modify anything
> when CONFIG_HAVE_PREL32_RELOCATIONS is not defined. I haven't
> thoroughly reviewed it or tested it. But if it doesn't break anything,
> I'm fine giving you an ack.
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>

Thank you Steven.

I should mention though (as you don't appear to recall) that an
earlier version of this patch triggered an issue for you

https://marc.info/?l=linux-arch&m=150584374820168&w=2

but I have never managed to reproduce it, neither at the time nor
currently with this v6.


ard@bezzzef:~/linux-2.6$ sudo tools/testing/selftests/ftrace/ftracetest
=== Ftrace unit tests ===
[1] Basic trace file check [PASS]
[2] Basic test for tracers [PASS]
[3] Basic trace clock test [PASS]
[4] Basic event tracing check [PASS]
[5] event tracing - enable/disable with event level files [PASS]
[6] event tracing - restricts events based on pid [PASS]
[7] event tracing - enable/disable with subsystem level files [PASS]
[8] event tracing - enable/disable with top level files [PASS]
[9] ftrace - function graph filters with stack tracer [PASS]
[10] ftrace - function graph filters [PASS]
[11] ftrace - test for function event triggers [PASS]
[12] ftrace - function glob filters [PASS]
[13] ftrace - function pid filters [PASS]
[14] ftrace - function profiler with function tracing [PASS]
[15] ftrace - test reading of set_ftrace_filter [PASS]
[16] ftrace - test for function traceon/off triggers [PASS]
[17] Test creation and deletion of trace instances while setting an event [PASS]
[18] Test creation and deletion of trace instances [PASS]
[19] Kprobe dynamic event - adding and removing [PASS]
[20] Kprobe dynamic event - busy event check [PASS]
[21] Kprobe dynamic event with arguments [PASS]
[22] Kprobes event arguments with types [PASS]
[23] Kprobe event auto/manual naming [PASS]
[24] Kprobe dynamic event with function tracer [PASS]
[25] Kprobe dynamic event - probing module [PASS]
[26] Kretprobe dynamic event with arguments [PASS]
[27] Kretprobe dynamic event with maxactive [PASS]
[28] Register/unregister many kprobe events [PASS]
[29] event trigger - test event enable/disable trigger [PASS]
[30] event trigger - test trigger filter [PASS]
[31] event trigger - test histogram modifiers [PASS]
[32] event trigger - test histogram trigger [PASS]
[33] event trigger - test multiple histogram triggers [PASS]
[34] event trigger - test snapshot-trigger [PASS]
[35] event trigger - test stacktrace-trigger [PASS]
[36] event trigger - test traceon/off trigger [PASS]
[37] (instance)  Basic test for tracers [PASS]
[38] (instance)  Basic trace clock test [PASS]
[39] (instance)  event tracing - enable/disable with event level files [PASS]
[40] (instance)  event tracing - restricts events based on pid [PASS]
[41] (instance)  event tracing - enable/disable with subsystem level
files [PASS]
[42] (instance)  ftrace - test for function event triggers [PASS]
[43] (instance)  ftrace - test for function traceon/off triggers [PASS]
[44] (instance)  event trigger - test event enable/disable trigger [PASS]
[45] (instance)  event trigger - test trigger filter [PASS]
[46] (instance)  event trigger - test histogram modifiers [PASS]
[47] (instance)  event trigger - test histogram trigger [PASS]
[48] (instance)  event trigger - test multiple histogram triggers [PASS]

# of passed:  48
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  0
# of undefined(test bug):  0
