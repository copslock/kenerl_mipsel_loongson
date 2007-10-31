Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 13:06:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13954 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025073AbXJaNGj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 13:06:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9VD6MKp015019;
	Wed, 31 Oct 2007 13:06:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9VD6MPe015018;
	Wed, 31 Oct 2007 13:06:22 GMT
Date:	Wed, 31 Oct 2007 13:06:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	veerasena reddy <veerasena_b@yahoo.co.in>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: porting KGDB onto MIPS24K processor running linux-2.6.18.8
Message-ID: <20071031130622.GD14187@linux-mips.org>
References: <245251.43610.qm@web8413.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <245251.43610.qm@web8413.mail.in.yahoo.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 31, 2007 at 03:32:58PM +0530, veerasena reddy wrote:

> I would like to port KGDB on MIPS24K target processor which is running linux-2.6.18.8 kernel.
> Could you please guide me, where can I get the appropriate KGDB patch for 2.6.18.8 kernel?

Generic MIPS KGDB support is in the kernel.  You will need to add two
functions getDebugChar and putDebugChar to do the debug I/O plus whatever
initialization the KGDB serial interface needs and have your platform
set SYS_SUPPORTS_KGDB in Kconfig to indicate it actually supports KGDB.

  Ralf
