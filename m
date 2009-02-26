Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2009 17:51:30 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50098 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20808693AbZBZRv2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2009 17:51:28 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n1QHpN19001714;
	Thu, 26 Feb 2009 17:51:23 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n1QHpLGm001712;
	Thu, 26 Feb 2009 17:51:21 GMT
Date:	Thu, 26 Feb 2009 17:51:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Robert Richter <robert.richter@amd.com>
Cc:	"M. Asselstine" <Mark.Asselstine@windriver.com>,
	linux-mips@linux-mips.org, oprofile-list@lists.sf.net
Subject: Re: [PATCH] oprofile: VR5500 performance counter driver
Message-ID: <20090226175121.GB1222@linux-mips.org>
References: <1235406394-2650-1-git-send-email-mark.asselstine@windriver.com> <20090225165953.GF25042@erda.amd.com> <200902261130.48307.Mark.Asselstine@windriver.com> <20090226170725.GM25042@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090226170725.GM25042@erda.amd.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 26, 2009 at 06:07:25PM +0100, Robert Richter wrote:

> I found this:
> 
>  arch/mips/include/asm/mipsregs.h:#define  CAUSEB_CE		28
> 
> Not sure if this is the same register. If so, you could add the macro
> to mipsregs.h too.

It is the same register.

  Ralf
