Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Apr 2005 14:49:48 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:51405 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225742AbVDINtd>;
	Sat, 9 Apr 2005 14:49:33 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DKGKt-0001FG-G4; Sat, 09 Apr 2005 09:49:19 -0400
Date:	Sat, 9 Apr 2005 09:49:19 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Sergio Ruiz <quekio@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linking assembled PIC code with Linux libc library
Message-ID: <20050409134919.GA4738@nevyn.them.org>
References: <e02bc66105040905091efb3dc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e02bc66105040905091efb3dc6@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 09, 2005 at 02:09:14PM +0200, Sergio Ruiz wrote:
> Hi, i can't link assembled pic code against the libc running my
> embedded-mips-box under debian, and this is what i do:
> 
> bluebox@bluebox:~$ as -al -EL -membedded-pic -mips1 -o prueba."o" prueba."s"

PIC != embedded-pic.  You shouldn't be using -membedded-pic.

In fact, you shouldn't be using as directly, or ld.  Always use GCC to
assemble and link, and it will take care of the options for you.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
