Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2011 13:35:23 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50064 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903698Ab1LHMfT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Dec 2011 13:35:19 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pB8CZA5f012175;
        Thu, 8 Dec 2011 12:35:10 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pB8CZ9bD012173;
        Thu, 8 Dec 2011 12:35:09 GMT
Date:   Thu, 8 Dec 2011 12:35:09 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: Don't increase PCIe payload sizes.
Message-ID: <20111208123509.GA10113@linux-mips.org>
References: <1322761877-30221-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322761877-30221-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6728

On Thu, Dec 01, 2011 at 09:51:17AM -0800, David Daney wrote:

> The existing code breaks devices that are capable of large PCIe
> transfers (Silicon Image SATA controllers for example).  We don't have
> code to properly determine the maximum payload size on a per-bus
> basis, so the easiest thing to do is just have all devices use the
> default (128).

Folded into 53ba9ae0 [MIPS: Octeon: Update PCI Latency timer, PCIe payload,
and PCIe max read to allow larger transactions].

Thanks,

  Ralf
