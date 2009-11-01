Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Nov 2009 07:33:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47448 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492381AbZKAGdH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Nov 2009 07:33:07 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA16YQew008813;
	Sun, 1 Nov 2009 07:34:28 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA16YPAA008809;
	Sun, 1 Nov 2009 07:34:25 +0100
Date:	Sun, 1 Nov 2009 07:34:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH -queue v2] MIPS: Alchemy: UARTs are of type 16550A
Message-ID: <20091101063421.GA4551@linux-mips.org>
References: <1256762986-4416-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1256762986-4416-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 28, 2009 at 09:49:46PM +0100, Manuel Lauss wrote:

> UART autodetection breaks on the Au1300 but the IP blocks are identical,
> at least according to the datasheets.  Help the 8250 driver by passing
> on uart type information via platform data.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> On top of the other alchemy patches in mips-queue.

Thanks, queued.

  Ralf
