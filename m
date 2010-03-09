Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 15:16:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56180 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492147Ab0CIOQW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Mar 2010 15:16:22 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o29EGC1g030848;
        Tue, 9 Mar 2010 15:16:15 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o29EG9A8030695;
        Tue, 9 Mar 2010 15:16:09 +0100
Date:   Tue, 9 Mar 2010 15:16:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Yang Shi <yang.shi@windriver.com>, f.fainelli@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: Octeon: Add add_wired_entry decralation in
 header file
Message-ID: <20100309141605.GA30829@linux-mips.org>
References: <1267605801-5305-1-git-send-email-yang.shi@windriver.com>
 <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
 <50e36e8549769a26986f99a23772d23fd039c230.1267604875.git.yang.shi@windriver.com>
 <004eb64c73b3bcec90612663598ada4cf678f236.1267604875.git.yang.shi@windriver.com>
 <4B8EA94B.1020203@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B8EA94B.1020203@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 03, 2010 at 10:24:11AM -0800, David Daney wrote:

> On 03/03/2010 12:43 AM, Yang Shi wrote:
> >Octeon's setup.c uses add_wired_entry, but it is not declared
> >anywhere. Copy add_wired_entry decralation from pgtable-32.h to
> >pgtable-64.h and include asm/pgtable.h into Octeon's setup.c.
> >
> >Signed-off-by: Yang Shi<yang.shi@windriver.com>
> 
> NAK!
> 
> We are removing the use of add_wired_entry(), so adding a
> declaration will not be necessary.

For explanation - add_wired_entry is a horrible API; it requires the user
to have knowledge about the TLB structure, code differently for 32-bit and
64-bit kernels.  It's just the API of terror.

  Ralf
