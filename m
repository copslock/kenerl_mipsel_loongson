Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 18:08:34 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57564 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493467AbZLBRIb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 18:08:31 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB2H8TJr032484;
        Wed, 2 Dec 2009 17:08:30 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB2H8TuH032482;
        Wed, 2 Dec 2009 17:08:29 GMT
Date:   Wed, 2 Dec 2009 17:08:28 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fix and enhance built-in kernel command line
Message-ID: <20091202170828.GA13441@linux-mips.org>
References: <1258835681-32200-1-git-send-email-dmitri.vorobiev@movial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1258835681-32200-1-git-send-email-dmitri.vorobiev@movial.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 21, 2009 at 10:34:41PM +0200, Dmitri Vorobiev wrote:

> Currently, MIPS kernels silently overwrite kernel command-line
> parameters hardcoded in CONFIG_CMDLINE by the ones received
> from firmware.  Therefore, using firmware remains the only
> reliable method to transfer the command-line parameters, which
> is not always desirable or convenient, and the CONFIG_CMDLINE
> option is thereby effectively rendered useless.
> 
> This patch fixes the problem described above and introduces
> a more flexible scheme of handling the kernel command line,
> in a manner identical to what is currently used for x86.
> The default behavior, i.e. when CONFIG_CMDLINE_BOOL is not
> defined, retains the existing semantics, and firmware
> command-line arguments override the hardcoded ones.

Queued for 2.6.33.  I also patched up the defconfig files to use the
right settings for CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE.

Thanks,

  Ralf
