Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 14:15:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58042 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492747AbZKFNMr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Nov 2009 14:12:47 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA6DEHY3011062;
	Fri, 6 Nov 2009 14:14:17 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA6DEH3O011061;
	Fri, 6 Nov 2009 14:14:17 +0100
Date:	Fri, 6 Nov 2009 14:14:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH -queue 2/2] [loongson] oprofile: avoid do_IRQ for
	perfcounter when the interrupt is from bonito
Message-ID: <20091106131417.GD31392@linux-mips.org>
References: <cover.1257504242.git.wuzhangjin@gmail.com> <578fdf2cd4a665bb8b56635e2ba7384ec9059ff8.1257504242.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578fdf2cd4a665bb8b56635e2ba7384ec9059ff8.1257504242.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 06, 2009 at 06:45:06PM +0800, Wu Zhangjin wrote:

> In loongson2f, the IP6 is shared by bonito and perfcounter, we need to
> avoid do_IRQ for perfcounter when the interrupt is from bonito. This
> patch does it.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Queued for 2.6.33.  Thanks!

  Ralf
