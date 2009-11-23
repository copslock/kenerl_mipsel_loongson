Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 00:17:55 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40156 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1493457AbZKWXRY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 00:17:24 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nANNHev1006807;
	Mon, 23 Nov 2009 23:17:40 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nANNHecX006806;
	Mon, 23 Nov 2009 23:17:40 GMT
Date:	Mon, 23 Nov 2009 23:17:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 3/3] MIPS: Alchemy: irq: use runtime CPU type detection
Message-ID: <20091123231740.GC27817@linux-mips.org>
References: <1259005202-7771-1-git-send-email-manuel.lauss@gmail.com> <1259005202-7771-2-git-send-email-manuel.lauss@gmail.com> <1259005202-7771-3-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259005202-7771-3-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 23, 2009 at 08:40:02PM +0100, Manuel Lauss wrote:

> Use runtime CPU detection instead of relying on preprocessor symbols.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks, queued for 2.6.33.

  Ralf
