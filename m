Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 09:44:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40648 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021496AbXEWIoh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 May 2007 09:44:37 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4N8iOve005109;
	Wed, 23 May 2007 09:44:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4N8iOwZ005108;
	Wed, 23 May 2007 09:44:24 +0100
Date:	Wed, 23 May 2007 09:44:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [NET] meth driver renovation
Message-ID: <20070523084424.GA5083@linux-mips.org>
References: <20070523084330.GA4966@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070523084330.GA4966@linux-mips.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 23, 2007 at 09:43:30AM +0100, Ralf Baechle wrote:

> The meth ethernet driver for the SGI IP32 aka O2 is so far still an old
> style driver which does not use the device driver model.  This is now
> causing issues with some udev based gadgetry in debian-stable.  Fixed by
> converting the meth driver to a platform device.

Since this seems to cause some real world problems I'd like to get this
patch into 2.6.22.

  Ralf
