Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2003 18:53:46 +0100 (BST)
Received: from p508B6977.dip.t-dialin.net ([IPv6:::ffff:80.139.105.119]:22248
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225429AbTJJRxe>; Fri, 10 Oct 2003 18:53:34 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9AHrWNK016847;
	Fri, 10 Oct 2003 19:53:32 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9AHrV7U016846;
	Fri, 10 Oct 2003 19:53:31 +0200
Date: Fri, 10 Oct 2003 19:53:31 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Krishna Kondaka <Krishna.Kondaka@MCDATA.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mips 32 bit HIGHMEM support
Message-ID: <20031010175331.GA11082@linux-mips.org>
References: <501EA67E9359C645A10C42EB5B52480D2AB2D0@SNEXCH01.mcdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <501EA67E9359C645A10C42EB5B52480D2AB2D0@SNEXCH01.mcdata.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 10, 2003 at 10:44:19AM -0700, Krishna Kondaka wrote:

> How safe is it to enable HIGHMEM for sibyte/broadcom's BCM12500 processors?
> Do you know if any one is using HIGHMEM enabled linux on BCM12500s?

Perfectly reliable - in fact highmem for MIPS was written and debugged
on this chip but there are many other that will work just as fine since
they share the technical properties required to run highmem.

Actually with the latest change in CVS enabling CONFIG_HIGHMEM is always
safe; in cases where it's not safe the kernel will simply limit the
memory it's using to just lowmem.

Stil the usual warning applies - highmem is a kludge and for systems
doing heavy I/O it can be a rather slow kludge.  64-bit is the Nirvana
kernel hackers are seeking ;-)

  Ralf
