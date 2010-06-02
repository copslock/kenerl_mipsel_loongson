Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 09:32:55 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39170 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491112Ab0FBHcs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jun 2010 09:32:48 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o527WkZV003731;
        Wed, 2 Jun 2010 08:32:46 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o527WjJT003729;
        Wed, 2 Jun 2010 08:32:45 +0100
Date:   Wed, 2 Jun 2010 08:32:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     apatard@mandriva.com
Cc:     linux-mips@linux-mips.org, aba@not.so.argh.org
Subject: Re: [patch 1/1] Loongson: define rtc device on mc146818 compatible
 systems
Message-ID: <20100602073244.GB1962@linux-mips.org>
References: <20100601223953.165137063@n5.mandriva.com>
 <20100601224232.291773884@n5.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100601224232.291773884@n5.mandriva.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 26985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1066

On Wed, Jun 02, 2010 at 12:39:54AM +0200, apatard@mandriva.com wrote:

> This patch declare the rtc device present on systems with clock compatible with
> the mc146818 and handled by rtc-cmos. I've introduced a new Kconfig entry because
> there are some systems without rtc-cmos compatible clock.

Applied, but:

/home/ralf/src/linux/linux-mips/.git/rebase-apply/patch:87: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Empty lines at end of file, bad karma.  Also to keep log messages in
"git log" under 80 characters, keep posted log messages to at most 76
columns.

Anyway, applied.  Thanks for sorting this!

  Ralf
