Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 16:18:13 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:38820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993828AbeKUPPbLl0Tu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Nov 2018 16:15:31 +0100
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 756B0214F1
        for <linux-mips@linux-mips.org>; Wed, 21 Nov 2018 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542813329;
        bh=kpH9lcQ8P8XV+NLvUJEbt/IT04dFbPXjvuI1ObcBYAw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=khcwjnN3W8oiolVzWdkYwOXyQRAs6P6ySgIXzjCPjOfIH1gHQVWNjJgtidXHIgPRn
         CwCuMol6mW0iA++aIbUocbisf9NKWSLOFkbGX1rEZ7ryIkIhgsKBtW6vWIB93TttT3
         WJlKpw3MsAUNHkwWqZMq8hXPUuneSjETHOFSDLJU=
Received: by mail-wm1-f48.google.com with SMTP id k198so6154685wmd.3
        for <linux-mips@linux-mips.org>; Wed, 21 Nov 2018 07:15:29 -0800 (PST)
X-Gm-Message-State: AGRZ1gKN3BraO7tvvD0xzd1xuTVsXyjTzcTdbSKoSzXpkyc0dQ1lhjau
        u6pv0cwftZFtNFTMcwlHpp+6fcpwa6qTM6RbeOMM/A==
X-Google-Smtp-Source: AJdET5fCl28jWGxXnQdRFKVSpliKHyZtnaunTTizhHy0FVmzumF0Lqgw2R8mpyFkm2xs/3yb8DPm2VruOfQ2rmi5vtI=
X-Received: by 2002:a1c:f112:: with SMTP id p18mr5957608wmh.83.1542813327926;
 Wed, 21 Nov 2018 07:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20181107042751.3b519062@akathisia> <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
In-Reply-To: <20181121004422.GA29053@altlinux.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 21 Nov 2018 07:15:15 -0800
X-Gmail-Original-Message-ID: <CALCETrV8AJPkZF7TzhXSte_wJgNXH+-s7-tPM-8xjcAfYgzdhg@mail.gmail.com>
Message-ID: <CALCETrV8AJPkZF7TzhXSte_wJgNXH+-s7-tPM-8xjcAfYgzdhg@mail.gmail.com>
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *" argument
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-audit@redhat.com,
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <luto@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@kernel.org
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

On Tue, Nov 20, 2018 at 4:44 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
>
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
>

Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
