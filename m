Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2004 14:43:06 +0000 (GMT)
Received: from p508B7DDE.dip.t-dialin.net ([IPv6:::ffff:80.139.125.222]:36931
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225349AbUCEOnE>; Fri, 5 Mar 2004 14:43:04 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i25Eg0ex020792;
	Fri, 5 Mar 2004 15:42:00 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i25EfxpS020791;
	Fri, 5 Mar 2004 15:41:59 +0100
Date: Fri, 5 Mar 2004 15:41:58 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Williams, Eric A" <eawilliams@howard.edu>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: DHCP/TFTP PROM error (F_magic 0x5330)
Message-ID: <20040305144158.GA20641@linux-mips.org>
References: <012CF7B248DA774B8F93F0F6DBC4AB112B0362@davis.howard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012CF7B248DA774B8F93F0F6DBC4AB112B0362@davis.howard.edu>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 04, 2004 at 12:02:58PM -0500, Williams, Eric A wrote:

> Anyone can give me insight as to what the error means.
> 
> Illegal F_magic number 0x5330, expected MIPSELMAGIC or MIPSEBMAGIC

You're feeding ELF to a machine that is expecting ECOFF binaries.  That's
a very old Indy firmware it seems.

  Ralf
