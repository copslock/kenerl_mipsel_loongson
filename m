Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2010 19:09:17 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36274 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492064Ab0LPSJO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Dec 2010 19:09:14 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oBGI9AKj002549;
        Thu, 16 Dec 2010 18:09:11 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oBGI99Ru002547;
        Thu, 16 Dec 2010 18:09:09 GMT
Date:   Thu, 16 Dec 2010 18:09:09 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add a CONFIG_FORCE_MAX_ZONEORDER Kconfig option.
Message-ID: <20101216180909.GB2293@linux-mips.org>
References: <1286833965-27484-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286833965-27484-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 11, 2010 at 02:52:45PM -0700, David Daney wrote:

> For huge page support with base page size of 16K or 32K, we have to
> increase the MAX_ORDER so that huge pages can be allocated.

I don't think a user should have to configure obscure constants like
this but for the time being this will have to suffice.  Applied.

Thanks,

  Ralf
