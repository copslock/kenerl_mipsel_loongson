Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 16:59:36 +0200 (CEST)
Received: from smtp.snhosting.dk ([87.238.248.203]:33200 "EHLO
        smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903712Ab2DTO73 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2012 16:59:29 +0200
Received: from merkur.ravnborg.org (unknown [188.228.89.252])
        by smtp.domainteam.dk (Postfix) with ESMTPA id 79AD5F1B17;
        Fri, 20 Apr 2012 16:59:20 +0200 (CEST)
Date:   Fri, 20 Apr 2012 16:59:20 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v1 1/5] scripts: Add sortextable to sort the kernel's
        exception table.
Message-ID: <20120420145920.GA2891@merkur.ravnborg.org>
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com> <1334872799-14589-2-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1334872799-14589-2-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 32992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Apr 19, 2012 at 02:59:55PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Using this build-time sort saves time booting as we don't have to burn
> cycles sorting the exception table.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  scripts/.gitignore    |    1 +
>  scripts/Makefile      |    1 +
>  scripts/sortextable.c |  273 +++++++++++++++++++++++++++++++++++++++++++++++++
>  scripts/sortextable.h |  168 ++++++++++++++++++++++++++++++

If there is only a single file including the .h file - then there is no gain.
Just fold it into the .c file.


	Sam
