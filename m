Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2010 15:03:36 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34271 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491819Ab0BPODd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Feb 2010 15:03:33 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1GE3O9P004009;
        Tue, 16 Feb 2010 15:03:26 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1GE3KBA004002;
        Tue, 16 Feb 2010 15:03:21 +0100
Date:   Tue, 16 Feb 2010 15:03:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix RIXI patch for au1000 processors.
Message-ID: <20100216140318.GA31590@linux-mips.org>
References: <1266258801-17841-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1266258801-17841-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 15, 2010 at 10:33:21AM -0800, David Daney wrote:

> Several macros need to be defined even though they are only used in
> dead code paths.

Thanks, folded into the existing patch.

  Ralf
