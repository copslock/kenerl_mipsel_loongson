Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 01:17:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41384 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493229Ab0AZARY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2010 01:17:24 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0Q0HSGh011045;
        Tue, 26 Jan 2010 01:17:29 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0Q0HRpO011032;
        Tue, 26 Jan 2010 01:17:27 +0100
Date:   Tue, 26 Jan 2010 01:17:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Decode c0_config4 for large TLBs.
Message-ID: <20100126001726.GA10453@linux-mips.org>
References: <1264463629-9005-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264463629-9005-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16320

On Mon, Jan 25, 2010 at 03:53:49PM -0800, David Daney wrote:

> For processors that have more than 64 TLBs, we need to decode both
> config1 and config4 to determine the total number TLBs.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
> 
> This is the second version, it uses more symbolic values and fewer
> magic numbers.

Thanks for making this change.  Queued for 2.6.34.

  Ralf
