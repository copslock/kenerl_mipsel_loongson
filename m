Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 15:59:46 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:60343
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8224861AbTDQO7p>; Thu, 17 Apr 2003 15:59:45 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id E9C302BC37
	for <linux-mips@linux-mips.org>; Thu, 17 Apr 2003 16:59:40 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 26209-03
 for <linux-mips@linux-mips.org>; Thu, 17 Apr 2003 16:59:39 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 9056C2BC33
	for <linux-mips@linux-mips.org>; Thu, 17 Apr 2003 16:59:39 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 016241735C; Thu, 17 Apr 2003 16:56:50 +0200 (CEST)
Date: Thu, 17 Apr 2003 16:56:50 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: R5000 Linux
Message-ID: <20030417145650.GJ22768@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <200304170912.55096.donath@hks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304170912.55096.donath@hks.com>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 17, 2003 at 09:12:55AM -0400, Clarence Donath wrote:
> Is there a Linux kernel for the R5000 IP32?  I would like to get involved.
I can send you a binary image if that's what you're looking for
(although I'm definitely not the right person to offer this since I have
almost 0 knowledge about the O2). I'd recommend to start from the
sources which are available through linux-mips.org's cvs repository.
See:
 http://www.linux-mips.org/kernel.html 
and the patches for the O2 for 2.5 are here:
 http://www.linux-mips.org/~glaurung/
You'll also find a cross toolchain there. The major show stopper for me
is currently the "do_cpu invoked from kernel context!" problem which I
didn't find any time to look into yet. I wonder wether I'm the only
person seeing this?

> 
> I've successfully configured this SGI O2 to boot the available R4000 IP22 
> kernel so I'm ready to go with IP32 if someone would be so kind as to point 
> me to an existing kernel.
Check out the excellent Linux O2 howto (but if you've done that for IP22
alreay this will be easy):
 http://www.total-knowledge.com/progs/mips/o2-howto.shtml
Regards,
 -- Guido
