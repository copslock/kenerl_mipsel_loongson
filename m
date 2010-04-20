Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2010 03:02:21 +0200 (CEST)
Received: from [81.2.74.5] ([81.2.74.5]:40977 "EHLO h5.dl5rb.org.uk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492698Ab0DTBCF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Apr 2010 03:02:05 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3K11Wrq000819;
        Tue, 20 Apr 2010 02:01:32 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3K11VTn000818;
        Tue, 20 Apr 2010 02:01:31 +0100
Date:   Tue, 20 Apr 2010 02:01:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Don't vmap things at address zero.
Message-ID: <20100420010130.GA663@linux-mips.org>
References: <1271702590-17799-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1271702590-17799-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 19, 2010 at 11:43:10AM -0700, David Daney wrote:

Thanks, applied.

  Ralf
