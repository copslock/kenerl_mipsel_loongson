Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Dec 2009 23:38:17 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45995 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1495508AbZLSWiK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Dec 2009 23:38:10 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBJMc2cX025480;
        Sat, 19 Dec 2009 22:38:03 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBJMc2lY025478;
        Sat, 19 Dec 2009 22:38:02 GMT
Date:   Sat, 19 Dec 2009 22:38:01 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH -queue] MIPS: Alchemy: get rid of common/reset.c
Message-ID: <20091219223801.GD23763@linux-mips.org>
References: <1260296294-18904-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1260296294-18904-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 08, 2009 at 07:18:13PM +0100, Manuel Lauss wrote:

> Implement reset/poweroff in the board code instead.  The peripheral
> reset code is gone too since YAMON (which all in-tree boards use)
> does the same work when it boots.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Run-tested on DB1200, compiled tested on all other boards.
> Applies on top of all the other Alchemy stuff in mips-queue.

Yet I got a reject for the first hunk of
arch/mips/alchemy/devboards/db1x00/board_setup.c.  I was looking trivial so
I fixed it up and queued the patch for 2.6.34.

Thanks!

  Ralf
