Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 16:05:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54893 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491127Ab1FHOE7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jun 2011 16:04:59 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p58E4PGK004627;
        Wed, 8 Jun 2011 15:04:25 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p58E4GSD004616;
        Wed, 8 Jun 2011 15:04:16 +0100
Date:   Wed, 8 Jun 2011 15:04:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Eric Paris <eparis@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, monstr@monstr.eu, benh@kernel.crashing.org,
        paulus@samba.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux390@de.ibm.com,
        lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com,
        richard@nod.at, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, viro@zeniv.linux.org.uk,
        oleg@redhat.com, akpm@linux-foundation.org,
        linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
 ptrace.h
Message-ID: <20110608140416.GA19926@linux-mips.org>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6849

On Fri, Jun 03, 2011 at 06:04:51PM -0400, Eric Paris wrote:

Thanks, this looks good & compiles, so:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

I will rebase my pending MIPS audit patches on top of this patch and resend.

Thanks,

  Ralf
