Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2010 13:23:46 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37153 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492066Ab0CSMXl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Mar 2010 13:23:41 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2JCNdKM016579;
        Fri, 19 Mar 2010 13:23:39 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2JCNdnP016577;
        Fri, 19 Mar 2010 13:23:39 +0100
Date:   Fri, 19 Mar 2010 13:23:39 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 5/7] MIPS: bcm63xx: fix typo in cpu-feature-overrides
 file.
Message-ID: <20100319122339.GM4554@linux-mips.org>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
 <1264872898-28149-6-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264872898-28149-6-git-send-email-mbizon@freebox.fr>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 30, 2010 at 06:34:56PM +0100, Maxime Bizon wrote:

> Fix typo: CONFIG_BCMCPU_IS_63xx does not exists,
> CONFIG_BCM63XX_CPU_63xx is the valid config option.

Thanks, applied.

  Ralf
