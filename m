Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 04:28:12 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:64950 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225348AbTISD2J>;
	Fri, 19 Sep 2003 04:28:09 +0100
Received: from drow by nevyn.them.org with local (Exim 4.22 #1 (Debian))
	id 1A0Bw9-00037v-Ky; Thu, 18 Sep 2003 23:28:01 -0400
Date: Thu, 18 Sep 2003 23:28:01 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: echristo@redhat.com, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030919032801.GA11998@nevyn.them.org>
Mail-Followup-To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	echristo@redhat.com, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
References: <20030918212727.GA24686@nevyn.them.org> <1063940280.2423.13.camel@ghostwheel.sfbay.redhat.com> <20030919.122940.45519247.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919.122940.45519247.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 19, 2003 at 12:29:40PM +0900, Atsushi Nemoto wrote:
> >>>>> On Thu, 18 Sep 2003 19:58:00 -0700, Eric Christopher <echristo@redhat.com> said:
> echristo> mips-linux-gcc -mabi=32 -march=64bitarch is my suggestion.
> 
> But mips64 kernel assumes that the kernel itself is compiled with
> "-mabi=64".  For example, some asm routines pass more than 4 arguments
> via aN registers.

I was able to build using -mabi=64 -Wa,-mabi=o64.  There are... some
issues... but I think that's just this board port.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
