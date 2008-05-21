Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2008 08:50:11 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:56037 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030261AbYEUHuJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 May 2008 08:50:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m4L7jNpu025044;
	Wed, 21 May 2008 08:45:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4L7jJgh025013;
	Wed, 21 May 2008 08:45:19 +0100
Date:	Wed, 21 May 2008 08:45:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	linux-mips@linux-mips.org,
	"Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [2.6 patch] mips/kernel/Makefile: remove CONFIG_CPU_R4000 line
Message-ID: <20080521074518.GB30479@linux-mips.org>
References: <20080520225502.GC16264@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080520225502.GC16264@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 21, 2008 at 01:55:02AM +0300, Adrian Bunk wrote:

> The existing options are named CONFIG_CPU_R4300 and CONFIG_CPU_R4X00, 
> and they are directly below.
> 
> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Applied.  Thanks,

  Ralf
