Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2003 20:02:04 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:24035
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8225198AbTL1UCB>; Sun, 28 Dec 2003 20:02:01 +0000
Received: (qmail 25544 invoked from network); 28 Dec 2003 20:01:50 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (12.234.207.60)
  by alpha.total-knowledge.com with DES-CBC3-SHA encrypted SMTP; 28 Dec 2003 20:01:50 -0000
Received: (qmail 635 invoked by uid 502); 28 Dec 2003 12:01:49 -0800
Date: Sun, 28 Dec 2003 12:01:49 -0800
From: ilya@theIlya.com
To: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: 2.6 64bit kernels
Message-ID: <20031228200149.GA617@gateway.total-knowledge.com>
References: <20031228195433.GH1298@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228195433.GH1298@bogon.ms20.nix>
User-Agent: Mutt/1.5.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips

See arch/mips/Makefile part of my minimal patchset:
http://www.selfsoft.com/progs/mips/patches/

in shor, to get things to work, one needs to play with
-mabi=o64/-64/-32 options.


On Sun, Dec 28, 2003 at 08:54:34PM +0100, Guido Guenther wrote:
> Hi,
> could anybody explain to me how one builds 2.6 (current CVS) 64bit
> kernel resulting in a 32bit ELF executable with a current (gcc >= 3.3,
> bintuils >= 2.14.90.0.5) toolchain.
> Major showstopper is that -Wa,-mabi=o64 doesn't work anymore, but
> -Wa,-mabi=32 -Wa,-mgp64 doesn't either since the assembler doesn't
> accept it.
> Thanks for any help,
>  -- Guido
> 
