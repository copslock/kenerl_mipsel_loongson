Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jan 2003 02:20:57 +0000 (GMT)
Received: from p508B5ED1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.209]:30421
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225256AbTAaCU4>; Fri, 31 Jan 2003 02:20:56 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0V2KqJ08008;
	Fri, 31 Jan 2003 03:20:52 +0100
Date: Fri, 31 Jan 2003 03:20:52 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Long Li <long21st@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: register declared variable for no optimization
Message-ID: <20030131032052.A7245@linux-mips.org>
References: <20030130231119.65802.qmail@web40412.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030130231119.65802.qmail@web40412.mail.yahoo.com>; from long21st@yahoo.com on Thu, Jan 30, 2003 at 03:11:19PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 30, 2003 at 03:11:19PM -0800, Long Li wrote:

> Why the gcc-3.0.4 did the weird stuff? Do I have to
> use at least level 1 to make the register declared
> work for it?

Most modern C compilers simply ignore the register specifier because in
practice it would result in worse code and as for code quality the
result of -O0 are not of interest anyway.

Linux code must be optmized at least -O1 or it probably won't build or
work properly.

  Ralf
