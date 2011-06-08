Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 20:39:39 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:32773 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491190Ab1FHSja (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jun 2011 20:39:30 +0200
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p58Id1Dl030763
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 8 Jun 2011 14:39:01 -0400
Received: from tranklukator.englab.brq.redhat.com (dhcp-1-166.brq.redhat.com [10.34.1.166])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id p58IcpYE003255;
        Wed, 8 Jun 2011 14:38:51 -0400
Received: by tranklukator.englab.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed,  8 Jun 2011 20:37:30 +0200 (CEST)
Date:   Wed, 8 Jun 2011 20:37:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Eric Paris <eparis@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, monstr@monstr.eu, ralf@linux-mips.org,
        benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux390@de.ibm.com,
        lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com,
        richard@nod.at, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-ia64@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
        ptrace.h
Message-ID: <20110608183720.GA16883@redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com> <20110607171952.GA25729@redhat.com> <1307472796.2052.12.camel@localhost.localdomain> <20110608163653.GA9592@redhat.com> <1307556823.2577.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1307556823.2577.5.camel@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
X-archive-position: 30300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7088

On 06/08, Eric Paris wrote:
>
> On Wed, 2011-06-08 at 18:36 +0200, Oleg Nesterov wrote:
> > And I guess, all CONFIG_AUDITSYSCALL code in entry.S is only needed to
> > microoptimize the case when TIF_SYSCALL_AUDIT is the only reason for the
> > slow path. I wonder if it really makes the measureble difference...
>
> All I know is what Roland put in the changelog:
>
> Avoiding the iret return path when syscall audit is enabled helps
> performance a lot.
>
> I believe this was a result of Fedora starting auditd by default and
> then Linus bitching about how slow a null syscall in a tight loop was.
> It was an optimization for a microbenchmark.  How much it affects things
> on a real syscall that does real work is probably going to be determined
> by how much work is done in the syscall.

and probably by how much work is done in audit_syscall_entry/exit.

OK. Thanks a lot Eric for your explanations.

Oleg.
