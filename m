Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 20:12:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39829 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6837142Ab3IESM2L8tO0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Sep 2013 20:12:28 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r85ICNqJ014219;
        Thu, 5 Sep 2013 20:12:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r85ICMM2014216;
        Thu, 5 Sep 2013 20:12:22 +0200
Date:   Thu, 5 Sep 2013 20:12:22 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Prem Mallappa <prem.mallappa@gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: Re: [PATCH v2 2/2] MIPS: KEXEC: Fixes Random crashes while loading
 crashkernel
Message-ID: <20130905181222.GC11592@linux-mips.org>
References: <1378317384-9923-1-git-send-email-pmallappa@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1378317384-9923-1-git-send-email-pmallappa@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, Sep 04, 2013 at 11:26:24PM +0530, Prem Mallappa wrote:
> Date:   Wed,  4 Sep 2013 23:26:24 +0530
> From: Prem Mallappa <prem.mallappa@gmail.com>
> To: linux-mips <linux-mips@linux-mips.org>
> Cc: Prem Mallappa <pmallappa@caviumnetworks.com>
> Subject: [PATCH v2 2/2] MIPS: KEXEC: Fixes Random crashes while loading

Prem,

I only see patch 2/2.  I wonder, has 1/2 been lost in transit or is there
only the 2/2 patch?

Thanks,

  Ralf
