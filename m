Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Dec 2002 19:17:14 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:27028 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S8225205AbSLCSRN>;
	Tue, 3 Dec 2002 19:17:13 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18JJTv-0005l7-00; Tue, 03 Dec 2002 14:17:23 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18JHbr-0003Zz-00; Tue, 03 Dec 2002 13:17:27 -0500
Date: Tue, 3 Dec 2002 13:17:27 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Aric, Wang" <aricwang@svanetworks.com>
Cc: linux-mips@linux-mips.org
Subject: Re: can't checkout linux source code
Message-ID: <20021203181727.GA13744@nevyn.them.org>
References: <023c01c29ac3$22050610$6808a8c0@rd.svanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023c01c29ac3$22050610$6808a8c0@rd.svanetworks.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 03, 2002 at 07:57:14PM +0800, Aric, Wang wrote:
> I can't check out the linux directory by execute the following commands:
>  
> cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs login
> password: cvs
> 
> cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co linux
> 
> This was work some days before. How about it now? How can give me some thread?

Use cvs.linux-mips.org, as was announced on the list a couple days ago.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
