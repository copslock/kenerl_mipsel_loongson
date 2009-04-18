Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2009 13:22:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43450 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20025782AbZDRMWl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Apr 2009 13:22:41 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3ICMbIM021045;
	Sat, 18 Apr 2009 14:22:37 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3ICMYxM021043;
	Sat, 18 Apr 2009 14:22:34 +0200
Date:	Sat, 18 Apr 2009 14:22:34 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org, yanh@lemote.com, zhangfx@lemote.com,
	penglj@lemote.com
Subject: Re: [PATCH] Loongson 2 requires no NOP insns to work around hazards
Message-ID: <20090418122234.GH11339@linux-mips.org>
References: <1239786112-22120-1-git-send-email-r0bertz@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1239786112-22120-1-git-send-email-r0bertz@gentoo.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 15, 2009 at 05:01:52PM +0800, Zhang Le wrote:

> Quoting from Loongson2FUserGuide.pdf:
> 
> 5.22.1 Hazards
> The processor detects most of the pipeline hazards in hardware, including CP0 hazards and
> load hazards. No NOP instructions are required to correct instruction sequences.

Patch looks ok - but *please* generate patches against a new source tree.
Your patch rejects because of another patches that was applied over two
week before you sent this one.

Applied,

  Ralf
