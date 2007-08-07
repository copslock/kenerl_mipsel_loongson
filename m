Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 14:22:57 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:7810 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20022117AbXHGNWr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2007 14:22:47 +0100
Received: from anguille.univ-lyon1.fr ([134.214.4.207])
	by hall.aurel32.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1IIP1E-0003V8-Rw; Tue, 07 Aug 2007 15:22:41 +0200
Message-ID: <46B87218.1080704@aurel32.net>
Date:	Tue, 07 Aug 2007 15:22:32 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>, Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: Re: [PATCH -mm 0/4] MIPS BCM947xx CPUs support
References: <20070806150701.GE24308@hall.aurel32.net> <20070807125521.GA23739@linux-mips.org> <46B86F1E.6060206@aurel32.net> <20070807131447.GA24212@linux-mips.org>
In-Reply-To: <20070807131447.GA24212@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Ralf Baechle a écrit :
> On Tue, Aug 07, 2007 at 03:09:50PM +0200, Aurelien Jarno wrote:
> 
>> I don't see a patch corresponding to the MIPS tree in the broken-out
>> directory. Anyway what other solution do you propose? I can see:
> 
> There isn't because until -rc2 everything went straight to Linus.  The
> next -mm should have a git-mips patch again.
> 
>> - Integrate the patches that have the most risk of conflicts (I think
>> patch #1) into the MIPS tree.
>> - Integrate all BCM947xx patches into the MIPS tree accepting that it
>> can compile without additional patches.
>> - Integrate SSB patches into the MIPS tree.
> 
> I can do that if Andrew is ok with it?

Well that was actually three different ways to go.


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
