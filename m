Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2010 07:36:49 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45585 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491914Ab0BEGgl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Feb 2010 07:36:41 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o156awjQ010991;
        Fri, 5 Feb 2010 07:36:58 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o156avId010989;
        Fri, 5 Feb 2010 07:36:57 +0100
Date:   Fri, 5 Feb 2010 07:36:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix __devinit __cpuinit confusion in cpu_cache_init
Message-ID: <20100205063656.GA10884@linux-mips.org>
References: <1265327329-2949-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1265327329-2949-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 04, 2010 at 03:48:49PM -0800, David Daney wrote:

> cpu_cache_init and the things it calls should all be __cpuinit instead
> of __devinit.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Thanks,

  Ralf
