Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 14:25:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:15539 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039425AbWJINZg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Oct 2006 14:25:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k99DPgJe013949;
	Mon, 9 Oct 2006 14:25:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k99DPfe3013948;
	Mon, 9 Oct 2006 14:25:41 +0100
Date:	Mon, 9 Oct 2006 14:25:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	girish <girishvg@gmail.com>, Kaz Kylheku <kaz@zeugmasystems.com>,
	linux-mips@linux-mips.org
Subject: Re: CFE problem: starting secondary CPU.
Message-ID: <20061009132540.GA4372@linux-mips.org>
References: <9D189830-9D85-4360-BEEE-72A3D5510D77@gmail.com> <20061008213538.84372.qmail@web31502.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008213538.84372.qmail@web31502.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 08, 2006 at 02:35:37PM -0700, Jonathan Day wrote:

> > would it be reasonable to choose couple of
> > bootmonitors and support  
> > them under MIPS/Linux umbrella. even bootable linux
> > would be a good  
> > choice.
> 
> I can't see why not. For that matter, I can't imagine
> it would be too hard to write the necessary flash
> support to get LinuxBIOS working.

The average firmware implementation contains alot of dark magic about
hardware initialization.  Producing a decent replacement is not trivial.

The current situation is that every vendor has a favorite firmware
implementation or sometimes even several depending on vintage or endianess.
Repeated problems over the years have taught me the only productive
way to live with most firmware implementations is to touch them as little
as possible since the rules for coexistence with the OS are usually very
weakly worded, inconsistent across platforms and the governing features
generally are bugs, incompatibilites and lack of features.  End of rant :-)

How x86 or Linux centric is LinuxBIOS?  Makers of Linux devices want to
support other operating systems as well.

  Ralf
