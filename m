Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Apr 2010 19:12:39 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38656 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492428Ab0D3RMg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Apr 2010 19:12:36 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3UHCXDs001534;
        Fri, 30 Apr 2010 18:12:33 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3UHCWOK001532;
        Fri, 30 Apr 2010 18:12:32 +0100
Date:   Fri, 30 Apr 2010 18:12:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf =?iso-8859-1?Q?R=F6sch?= <ralf.roesch@rw-gmbh.de>
Subject: Re: Fwd: check_for_high_segbits not used when 32bit
Message-ID: <20100430171232.GA992@linux-mips.org>
References: <4BDB0C0A.1060506@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BDB0C0A.1060506@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 30, 2010 at 09:57:46AM -0700, David Daney wrote:

> Sorry about that.
> 
> Perhaps you can send it with a Signed-off-by: to lmo.

Not needed - I ran into the same issue and the fix is already committed.

  Ralf
