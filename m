Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 13:50:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55407 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827391Ab3ISLunOhT6n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Sep 2013 13:50:43 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8JBofPZ024831;
        Thu, 19 Sep 2013 13:50:41 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8JBoeRM024830;
        Thu, 19 Sep 2013 13:50:40 +0200
Date:   Thu, 19 Sep 2013 13:50:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: pci: pci-bcm1480: Include missing vt.h header
Message-ID: <20130919115040.GW22468@linux-mips.org>
References: <1379582872-5482-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1379582872-5482-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37879
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

On Thu, Sep 19, 2013 at 10:27:52AM +0100, Markos Chandras wrote:

> It's needed for the MAX_NR_CONSOLES macro.
> 
> Fixes the following build problem on a randconfig:
> 
> arch/mips/pci/pci-bcm1480.c: In function 'bcm1480_pcibios_init':
> arch/mips/pci/pci-bcm1480.c:261:36: error: 'MAX_NR_CONSOLES'
> undeclared (first use in this function)
> arch/mips/pci/pci-bcm1480.c:261:36: note: each undeclared
> identifier is reported only once for each function it appears in
> make[1]: *** [arch/mips/pci/pci-bcm1480.o] Error 1
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

I'm wondering if this *really* has to live in the PCI code.  A VGA in
legacy mode should even work with CONFIG_PCI=n, right?

Anyway, applied.  Thanks!

  Ralf
