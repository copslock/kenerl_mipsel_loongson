Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 17:16:24 +0100 (BST)
Received: from smtp.seznam.cz ([IPv6:::ffff:212.80.76.43]:59035 "HELO
	smtp.seznam.cz") by linux-mips.org with SMTP id <S8225477AbUEQQQX>;
	Mon, 17 May 2004 17:16:23 +0100
Received: (qmail 1036 invoked from network); 17 May 2004 16:16:08 -0000
Received: from unknown (HELO umax645sx) (Ladislav.Michl@160.218.40.10)
  by smtp.seznam.cz with SMTP; 17 May 2004 16:16:08 -0000
Received: from ladis by umax645sx with local (Exim 3.36 #1 (Debian))
	id 1BPkm6-0001Ue-00; Mon, 17 May 2004 18:15:34 +0200
Date: Mon, 17 May 2004 18:15:16 +0200
To: Alexander Markley <alex@cyberMalex.com>
Cc: linux-mips@linux-mips.org
Subject: Re: SGI O2 MIPS R5000 bootp problems
Message-ID: <20040517161515.GA5706@umax645sx>
References: <40A8E08B.7070203@cyberMalex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A8E08B.7070203@cyberMalex.com>
User-Agent: Mutt/1.5.6i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 17, 2004 at 11:55:55AM -0400, Alexander Markley wrote:
> Hi. I just get an SGI O2 with a MIPS R5000 chip in it, and I'd love to 
> run linux on it. The machine seems to be in working order, and has been 
> known to boot into IRIX in the recent past.
> 
> I have gotten the debian tftp boot images and things, and have properly 
> set up dhcp and tftp, but I cannot make this machine boot!
> 
> ...
> > boot f bootp():r5000_boot.img
> Setting $netaddr to 192.168.1.235 (from server )
> Obtaining r5000_boot.img from server
> 7536
> Cannot load bootp():r5000_boot.img.
> Range check failure: text start 0x88802000, size 0x1d70.
                                  ^^^^^^^^^^
What kernel version are you running? This bug was fixed quite long ago.
I'd recommend using recent cvs and patch by Ilya
http://www.total-knowledge.com/progs/mips/patches

> Text section would overwrite an already loaded program.Unable to execute 
> bootp():r5000_boot.img:  not enough space
> Unable to load bootp():r5000_boot.img: not enough space
[snip]

	ladis
