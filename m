Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 01:10:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54641 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492726Ab0A2AKn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 01:10:43 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0T0Ar9I014503;
        Fri, 29 Jan 2010 01:10:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0T0AqUo014495;
        Fri, 29 Jan 2010 01:10:52 +0100
Date:   Fri, 29 Jan 2010 01:10:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mmc: au1xmmc: allow platforms to disable host
 capabilities
Message-ID: <20100129001051.GD13143@linux-mips.org>
References: <4AD57FDE.1040206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD57FDE.1040206@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18522

On Wed, Oct 14, 2009 at 09:38:06AM +0200, Manuel Lauss wrote:

> Although the hardware supports a 4/8bit SD interface and the driver
> unconditionally advertises all hardware caps to the MMC core, not all
> datalines may actually be wired up.  This patch introduces another
> field to au1xmmc platform data allowing platforms to disable certain
> advanced host controller features.

Haven't heared anything from the MMC folks so I've queued this one for
2.6.34.

Thanks,

  Ralf
