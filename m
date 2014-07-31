Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 21:07:28 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:65113 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860195AbaGaTHZtMY0t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jul 2014 21:07:25 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6VJ74b6031891
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jul 2014 15:07:04 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s6VJ70G6001304;
        Thu, 31 Jul 2014 15:07:00 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Thu, 31 Jul 2014 21:05:22 +0200 (CEST)
Date:   Thu, 31 Jul 2014 21:05:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "<linux-arm-kernel@lists.infradead.org>" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: TIF_NOHZ can escape nonhz mask? (Was: [PATCH v3 6/8] x86:
        Split syscall_trace_enter into two phases)
Message-ID: <20140731190518.GA21938@redhat.com>
References: <20140728192209.GA26017@localhost.localdomain> <20140729175414.GA3289@redhat.com> <20140730163516.GC18158@localhost.localdomain> <20140730174630.GA30862@redhat.com> <20140731003034.GA32078@localhost.localdomain> <20140731160353.GA14772@redhat.com> <20140731171329.GD7842@localhost.localdomain> <20140731181230.GA18695@redhat.com> <20140731184729.GA12296@localhost.localdomain> <CAFTL4hyHh3Bw0eeJe9q50HVrt=B-zgmyu6C_hy+RoW21kQEJtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTL4hyHh3Bw0eeJe9q50HVrt=B-zgmyu6C_hy+RoW21kQEJtg@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41855
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

On 07/31, Frederic Weisbecker wrote:
>
> 2014-07-31 20:47 GMT+02:00 Frederic Weisbecker <fweisbec@gmail.com>:
> > On Thu, Jul 31, 2014 at 08:12:30PM +0200, Oleg Nesterov wrote:
> >> On 07/31, Frederic Weisbecker wrote:
> > No, because preempt_schedule_irq() does the ctx_state save and restore with
> > exception_enter/exception_exit.
>
> Similar thing happens with schedule_user().
>
> preempt_schedule_irq() handles kernel preemption and schedule_user()
> the user preemption. On both cases we save and restore the context
> tracking state.
>
> This might be the missing piece you were missing :)

YYYYYEEEEESSSS, thanks!!

And in fact I was going to suggest to add this logic into preempt schedule
paths to improve the situation if we can't make TIF_NOHZ per-cpu.

But Frederic, perhaps I'll return here tomorrow with another question, it
is too late for me now ;)

Thanks!

Oleg.
