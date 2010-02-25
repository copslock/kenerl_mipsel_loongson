Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 15:23:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51075 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491869Ab0BYOXK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2010 15:23:10 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1PEN68o006989;
        Thu, 25 Feb 2010 15:23:06 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1PEN60N006987;
        Thu, 25 Feb 2010 15:23:06 +0100
Date:   Thu, 25 Feb 2010 15:23:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Use ALIGN(x, bytes) instead of __ALIGN_MASK(x,
 bytes - 1)
Message-ID: <20100225142306.GC29565@linux-mips.org>
References: <1267072214-23269-1-git-send-email-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1267072214-23269-1-git-send-email-mattst88@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 11:30:14PM -0500, Matt Turner wrote:

Thanks, queue for 2.6.34.

  Ralf
