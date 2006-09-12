Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Sep 2006 17:18:37 +0100 (BST)
Received: from gate.ebshome.net ([208.106.21.240]:2784 "EHLO gate.ebshome.net")
	by ftp.linux-mips.org with ESMTP id S20038598AbWILQSd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 Sep 2006 17:18:33 +0100
Received: (qmail 17615 invoked by uid 1000); 12 Sep 2006 09:18:25 -0700
Date:	Tue, 12 Sep 2006 09:18:25 -0700
From:	Eugene Surovegin <ebs@ebshome.net>
To:	Youngduk Goo <ydgoo9@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: NOR Flash memory write speed.
Message-ID: <20060912161824.GA5987@gate.ebshome.net>
Mail-Followup-To: Youngduk Goo <ydgoo9@gmail.com>,
	linux-mips@linux-mips.org
References: <38dc7fce0609120440o11c6a11ejf7f0a3cb1371bb40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38dc7fce0609120440o11c6a11ejf7f0a3cb1371bb40@mail.gmail.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.8i
Return-Path: <ebs@ebshome.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebs@ebshome.net
Precedence: bulk
X-list: linux-mips

On Tue, Sep 12, 2006 at 08:40:43PM +0900, Youngduk Goo wrote:
> Hello, all
> 
> I am developing the system using the NOR flash (32MB) and the core is
> about 300MHz mips.
> I wonder how long takes the whole erase and write time to flash memory.
> I tried it on the bootloader. Firstof all, bootloader(YAMON) load the image
> and erase the flash except bootloader region, write the image..
> It took about 14-16minutes.I think it is too long.
> 

Yeah, this seems way too slow. Check if your chip supports "buffer 
write" mode and make sure software uses it.

-- 
Eugene
