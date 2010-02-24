Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 16:55:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56917 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492454Ab0BXPzj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 16:55:39 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1OFtcCb024357;
        Wed, 24 Feb 2010 16:55:38 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1OFtcEW024355;
        Wed, 24 Feb 2010 16:55:38 +0100
Date:   Wed, 24 Feb 2010 16:55:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: crazy spinlock speed test.
Message-ID: <20100224155538.GB5130@linux-mips.org>
References: <1266362795-20199-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1266362795-20199-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 16, 2010 at 03:26:35PM -0800, David Daney wrote:

> This is just a test program for raw_spinlocks.  The main reason I
> wrote it is to validate my spinlock changes that I sent in a previous
> patch.
> 
> To use it enable CONFIG_DEBUG_FS and CONFIG_SPINLOCK_TEST then at run
> time do:
> 
> # mount -t debugfs none /sys/kernel/debug/
> # cat /sys/kernel/debug/mips/spin_single
> # cat /sys/kernel/debug/mips/spin_multi
> 
> On my 600MHz octeon cn5860 (16 CPUs) I get
> 
> 		spin_single	spin_multi
> base		106885		247941
> spinlock_patch	75194		219465
> 
> This shows that for uncontended locks the spinlock patch gives 41%
> improvement and for contended locks 12% improvement (1/time).
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Also queued for 2.6.34.

Thanks!

  Ralf
