Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2003 17:06:03 +0000 (GMT)
Received: from p508B634D.dip.t-dialin.net ([IPv6:::ffff:80.139.99.77]:41611
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224939AbTANRGC>; Tue, 14 Jan 2003 17:06:02 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0EH5q923779;
	Tue, 14 Jan 2003 18:05:52 +0100
Date: Tue, 14 Jan 2003 18:05:52 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Gilad Benjamini <gilad@riverhead.com>
Cc: linux-mips@linux-mips.org
Subject: Re: insmod failure: "Unhandled relocation" errors
Message-ID: <20030114180551.A23742@linux-mips.org>
References: <001801c2bbb4$a6177de0$7100000a@riverhead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <001801c2bbb4$a6177de0$7100000a@riverhead.com>; from gilad@riverhead.com on Tue, Jan 14, 2003 at 12:06:46PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 14, 2003 at 12:06:46PM +0200, Gilad Benjamini wrote:

> I've built,compiled and ran successfully a 64 bit kernel on my 
> mips64 platform. Kernel was compiled with support for 32 bit binaries.
> 
> I am now trying to insert a module, a standard module from
> the kernel tree, and get lots of errors such as:
> "Unhandled relocation of type 18 for"
> or
> "Unhandled relocation of type 18 for <function_name>"
> 
> How can this be resolved ?

Modules are not supported on 64-bit kernel yet.

  Ralf
