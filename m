Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 12:16:44 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49433 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903684Ab1KJLQl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 12:16:41 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAABGBm9018999;
        Thu, 10 Nov 2011 11:16:11 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAABG48X018967;
        Thu, 10 Nov 2011 11:16:04 GMT
Date:   Thu, 10 Nov 2011 11:16:04 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@google.com>, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH 4/5] treewide: Convert uses of ATTRIB_NORETURN to
 __noreturn
Message-ID: <20111110111604.GB1580@linux-mips.org>
References: <cover.1320917551.git.joe@perches.com>
 <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9225

On Thu, Nov 10, 2011 at 01:41:45AM -0800, Joe Perches wrote:

> Use the more commonly used __noreturn instead of ATTRIB_NORETURN.

Subject and here: s/ATTRIB_NORETURN/ATTRIB_NORET/

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/ia64/kernel/machine_kexec.c       |    2 +-
>  arch/m68k/amiga/config.c               |    2 +-
>  arch/mips/include/asm/ptrace.h         |    2 +-
>  arch/mips/kernel/traps.c               |    2 +-

For the MIPS bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
