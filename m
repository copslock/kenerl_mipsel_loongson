Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 11:34:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57989 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20307314AbYISKee (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 11:34:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8JAYY8S014709;
	Fri, 19 Sep 2008 12:34:34 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8JAYXDv014707;
	Fri, 19 Sep 2008 12:34:33 +0200
Date:	Fri, 19 Sep 2008 12:34:33 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Klatt Uwe <U.Klatt@miwe.de>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Same mipsel binary =?iso-8859-1?Q?f=FC?=
	=?iso-8859-1?Q?r?= 2.4 and 2.6 kernel possible?
Message-ID: <20080919103433.GA14602@linux-mips.org>
References: <A1F06CF959C7E14EAC28F277F368175805686A8D6D@MAS15.arnstein.miwe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A1F06CF959C7E14EAC28F277F368175805686A8D6D@MAS15.arnstein.miwe.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 19, 2008 at 09:58:29AM +0200, Klatt Uwe wrote:

> I have a custom hardware (AU1100) with kernel 2.4 and an working binary using floats (compiled with gcc 3.3.5).
> Now I am testing with kernel 2.6.
> 
> When I use the old binary, float math isn't working anymore.
> I have to recompile the source with new gcc 4.1.2 but then the new binary is working only on kernel 2.6.

Are you using the kernel floating point emulator or a software floating
point library?

Whatever, it sounds like a bug.  The kernel is supposed to be backward
compatible with old binaries.

  Ralf
