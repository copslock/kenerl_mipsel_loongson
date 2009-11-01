Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Nov 2009 08:07:48 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37314 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492554AbZKAHHp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Nov 2009 08:07:45 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA1794q1009535;
	Sun, 1 Nov 2009 08:09:04 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA1790L8009518;
	Sun, 1 Nov 2009 08:09:00 +0100
Date:	Sun, 1 Nov 2009 08:09:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] serial 8250: fixes for Alchemy uarts.
Message-ID: <20091101070900.GB4551@linux-mips.org>
References: <1256762248-4305-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1256762248-4305-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 28, 2009 at 09:37:28PM +0100, Manuel Lauss wrote:

> Limit the amount of address space claimed for Alchemy serial ports
> to 0x1000.  On the Au1300, ports are only 0x1000 apart, and the
> registers only extend to 0x110 at most on all supported alchemy models.
> 
> On the Au1300 the autodetect logic no longer works and this makes
> it necessary to specify the port type through platform data.  Because
> of this the MSR quirk needs to be moved outside the autoconfig()
> function which will no longer be called when UPF_FIXED_TYPE is
> specified.

Andrew,

looks sane to me.  Since this is a MIPS patch I'd like to funnel it through
the MIPS tree.  Ok?

  Ralf
