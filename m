Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 12:41:44 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49890 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903688Ab1KJLlk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 12:41:40 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAABfHVf021592;
        Thu, 10 Nov 2011 11:41:17 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAABfFAx021585;
        Thu, 10 Nov 2011 11:41:15 GMT
Date:   Thu, 10 Nov 2011 11:41:15 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@google.com>, Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Chris Metcalf <cmetcalf@tilera.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/5] treewide: Remove useless NORET_TYPE macro and uses
Message-ID: <20111110114115.GA21453@linux-mips.org>
References: <cover.1320917551.git.joe@perches.com>
 <e69163f6245513b05d5d21c2f57b916931ad5bff.1320917557.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e69163f6245513b05d5d21c2f57b916931ad5bff.1320917557.git.joe@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9237

On Thu, Nov 10, 2011 at 01:41:44AM -0800, Joe Perches wrote:

>  arch/mips/include/asm/ptrace.h         |    2 +-
>  arch/mips/kernel/traps.c               |    2 +-

For the MIPS bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
