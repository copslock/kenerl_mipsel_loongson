Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2004 22:31:49 +0100 (BST)
Received: from p508B7C48.dip.t-dialin.net ([IPv6:::ffff:80.139.124.72]:24605
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224930AbUHBVbp>; Mon, 2 Aug 2004 22:31:45 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i72LVhkK008057;
	Mon, 2 Aug 2004 23:31:43 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i72LVgdW008056;
	Mon, 2 Aug 2004 23:31:42 +0200
Date: Mon, 2 Aug 2004 23:31:42 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: willem.acke@alcatel.be
Cc: linux-mips@linux-mips.org
Subject: Re: RM9000x2 TLB load exception
Message-ID: <20040802213142.GB3980@linux-mips.org>
References: <410E071F.4060907@alcatel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410E071F.4060907@alcatel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 02, 2004 at 11:19:27AM +0200, willem.acke@alcatel.be wrote:

> I'm trying to port the mips-kernel to a RM9000x2 based custom board.
> The kernel file (mips 32) is loaded using VxWorks boot loader.
> I got the to the point where the kernel starts loading, but exits with a 
> 'TLB load exception'.
> After putting in a number of printks, it seems that it fails on 
> 'flush_icache_range' in arch/mips/mm/pg-r4k.c -> build_clear_page.
> Since I'm a newbie to this, any pointers to how to tackle this problem 
> would be appreciated.

Funny :-)  This is a particularly crazy function where I decieded to
generate the clear_function at runtime since we had to many versions
optimized for the one or other processor or configuration which had
become excessivly large.

> Exception:
> Tlb Load Exception
> Exception Program Counter: 0x00000000
> Status Register: 0x3404ff00
> Cause Register: 0x01100008
> Access Address : 0x00000000
> Task: 0x83e2c760 ""
[...]

The register dump is unseless since you didn't say what all the addresses
point to.

Other information that's needed to make sense out of a bug report would be:

 - gcc and binutils version used to compile the kernel
 - kernel version and also where did you get it from (linux-mips.org?)

  Ralf
