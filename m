Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 17:55:22 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47484 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493029Ab0LAQzT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Dec 2010 17:55:19 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oB1GtHt0007366;
        Wed, 1 Dec 2010 16:55:17 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oB1GtHUf007363;
        Wed, 1 Dec 2010 16:55:17 GMT
Date:   Wed, 1 Dec 2010 16:55:17 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix build failure on mips_sc_is_activated()
Message-ID: <20101201165517.GA5560@linux-mips.org>
References: <1291221282-9056-1-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1291221282-9056-1-git-send-email-namhyung@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 02, 2010 at 01:34:42AM +0900, Namhyung Kim wrote:

> The commit ea31a6b20371 ("MIPS: Honor L2 bypass bit") breaks
> malta build as follows. Looks like not compile-tested :(

Already fixed in the linux-mips git tree by an identical patch in
commit 9a3475880131752d3d78ac25516fd3eab3fca871.

Thanks anyway!

  Ralf
