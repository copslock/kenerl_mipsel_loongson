Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 19:52:34 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35606 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492087Ab0D2Rwb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Apr 2010 19:52:31 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3THq3nT032017;
        Thu, 29 Apr 2010 18:52:03 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3THptiT032004;
        Thu, 29 Apr 2010 18:51:55 +0100
Date:   Thu, 29 Apr 2010 18:51:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-i2c@vger.kernel.org, ben-linux@fluff.org, khali@linux-fr.org,
        linux-mips@linux-mips.org, rade.bozic.ext@nsn.com
Subject: Re: [PATCH] i2c: Fix section mismatch errors in i2c-octeon.c
Message-ID: <20100429175152.GA31861@linux-mips.org>
References: <1268075061-31748-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1268075061-31748-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 08, 2010 at 11:04:21AM -0800, David Daney wrote:

Nothing heared and patch is trivial so I'll apply and push this to Linus
now.

Thanks,

  Ralf
