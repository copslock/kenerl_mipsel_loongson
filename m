Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 05:25:53 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45734 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492029Ab0KIEYP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Nov 2010 05:24:15 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oA8NLoG8008031;
        Mon, 8 Nov 2010 23:21:50 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oA8NLnEC008029;
        Mon, 8 Nov 2010 23:21:49 GMT
Date:   Mon, 8 Nov 2010 23:21:48 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] MIPS: Rework GENERIC_HARDIRQS Kconfig.
Message-ID: <20101108232148.GA7806@linux-mips.org>
References: <1288995168-17511-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288995168-17511-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 05, 2010 at 03:12:48PM -0700, David Daney wrote:

> Recent changes to CONFIG_GENERIC_HARDIRQS have caused us to start
> getting:
> 
> warning: (SMP && SYS_SUPPORTS_SMP) selects IRQ_PER_CPU which has unmet direct dependencies (HAVE_GENERIC_HARDIRQS)
> 
> Rearranging our Kconfig quiets the message.

Thanks, applied.

I noticed that some of the same sort of cruft also still exists in
other architectures.

  Ralf
