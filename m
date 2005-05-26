Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 18:06:25 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:30369 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225976AbVEZRGJ>;
	Thu, 26 May 2005 18:06:09 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50)
	id 1DbLo3-0003ST-Qq; Thu, 26 May 2005 13:06:03 -0400
Date:	Thu, 26 May 2005 13:06:03 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	maxim@mox.ru
Cc:	linux-mips@linux-mips.org
Subject: Re: glibc-2.3.4 mips64 compilation failure
Message-ID: <20050526170603.GA13272@nevyn.them.org>
References: <6097c4905052609326a4c1232@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6097c4905052609326a4c1232@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, May 26, 2005 at 08:32:59PM +0400, Maxim Osipov wrote:
> Hello,
> 
> I am trying to build glibc-2.3.4 using binutils-2.15 and gcc-3.4.3
> from ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/i386-linux/mips64-linux.
> Compilation fails with following messages:

Looks like your kernel headers are too old.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
