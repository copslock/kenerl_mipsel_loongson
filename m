Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 02:28:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37797 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493062AbZJLA2A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 02:28:00 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9C0TBlr030347;
	Mon, 12 Oct 2009 02:29:11 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9C0T7ww028146;
	Mon, 12 Oct 2009 02:29:07 +0200
Date:	Mon, 12 Oct 2009 02:29:07 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Julia Lawall <julia@diku.dk>
Cc:	Geert Uytterhoeven <geert.uytterhoeven@gmail.com>,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [Linux-fbdev-devel] [PATCH 3/3] drivers/video: Correct use of
	request_region/request_mem_region
Message-ID: <20091012002907.GA835@linux-mips.org>
References: <Pine.LNX.4.64.0908090943560.13271@ask.diku.dk> <10f740e80908090224p13d2119do9e4f4d7730ed001e@mail.gmail.com> <Pine.LNX.4.64.0908091141150.13271@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0908091141150.13271@ask.diku.dk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 09, 2009 at 11:42:32AM +0200, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> request_region should be used with release_region, not request_mem_region.
> 
> Geert Uytterhoeven pointed out that in the case of drivers/video/gbefb.c,
> the problem is actually the other way around; request_mem_region should be
> used instead of request_region.
> 
> The semantic patch that finds/fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r1@
> expression start;
> @@
> 
> request_region(start,...)
> 
> @b1@
> expression r1.start;
> @@
> 
> request_mem_region(start,...)
> 
> @depends on !b1@
> expression r1.start;
> expression E;
> @@
> 
> - release_mem_region
> + release_region
>   (start,E)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Any reason this still hasn't been applied?

  Ralf
