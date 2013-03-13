Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Mar 2013 14:41:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33425 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823033Ab3CMNlka3Chu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Mar 2013 14:41:40 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r2DDfcG6024591;
        Wed, 13 Mar 2013 14:41:38 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r2DDfbNq024590;
        Wed, 13 Mar 2013 14:41:37 +0100
Date:   Wed, 13 Mar 2013 14:41:37 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: loongson: fix random early boot hang
Message-ID: <20130313134137.GB17165@linux-mips.org>
References: <1361232039-12555-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1361232039-12555-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35884
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Feb 19, 2013 at 02:00:39AM +0200, Aaro Koskinen wrote:

> Subject: [PATCH] MIPS: loongson: fix random early boot hang
> 
> Some Loongson boards (e.g. Lemote FuLoong mini-PC) use ISA/southbridge
> device (CS5536 general purpose timer) for the timer interrupt. It starts
> running early and is already enabled during the PCI configuration,
> during which there is a small window in pci_read_base() when the register
> access is temporarily disabled. If the timer interrupts at this point,
> the system will hang. Fix this by adding a fixup that keeps the register
> access always enabled.

Applied, though a bit late.  I really was hoping for one of the Lemote
folks to chime in.

Thanks Aaro,

  Ralf
