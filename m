Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 01:53:09 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42483 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492640Ab0CKAxF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Mar 2010 01:53:05 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2B0quqt028896;
        Thu, 11 Mar 2010 01:52:57 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2B0qr6B028888;
        Thu, 11 Mar 2010 01:52:53 +0100
Date:   Thu, 11 Mar 2010 01:52:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Yang Shi <yang.shi@windriver.com>, f.fainelli@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: Octeon: Remove redundant declaration of
 octeon_reserve32_memory
Message-ID: <20100311005247.GA18065@linux-mips.org>
References: <1267605801-5305-1-git-send-email-yang.shi@windriver.com>
 <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
 <50e36e8549769a26986f99a23772d23fd039c230.1267604875.git.yang.shi@windriver.com>
 <4B8EA9AD.8070106@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B8EA9AD.8070106@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 03, 2010 at 10:25:49AM -0800, David Daney wrote:

> On 03/03/2010 12:43 AM, Yang Shi wrote:
> >In Octeon's setup.c, octeon_reserve32_memory is defined, so remove the
> >redundant extern declaration of this variable.
> >
> >Signed-off-by: Yang Shi<yang.shi@windriver.com>
> 
> Acked-by: David Daney <ddaney@caviumnetworks.com>
> 
> This looks good to me.  Thanks,
> David Daney

Applied, thanks.

  Ralf
