Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3N4XJa04674
	for linux-mips-outgoing; Sun, 22 Apr 2001 21:33:19 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3N4XIM04671
	for <linux-mips@oss.sgi.com>; Sun, 22 Apr 2001 21:33:18 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 9964BF1A9; Sun, 22 Apr 2001 21:32:35 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id D43DF1F42A; Sun, 22 Apr 2001 21:33:05 -0700 (PDT)
Date: Sun, 22 Apr 2001 21:33:05 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: Re: ls from fileutils-4.0.43 segfaults
Message-ID: <20010422213305.C6180@foobazco.org>
References: <20010422224018.A9017@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010422224018.A9017@excalibur.cologne.de>; from karsten@excalibur.cologne.de on Sun, Apr 22, 2001 at 10:40:18PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Apr 22, 2001 at 10:40:18PM +0200, Karsten Merker wrote:

> I have tried to install fileutils_4.0.43-1_mipsel.deb from
> source.rfc822.org and found that "ls" segfaults, the other binaries seem
> to be ok. So I have tried compiling it myself against glibc-2.2.2 on
> repeat.rfc822.org and also on my DECstation, but the effect stays the
> same.

As others have pointed out, you may be afflicted with the dreaded
sysmips bug.  I can confirm that my new toolchain builds a working ls,
among other wonders.  I'll be releasing a new make-cross-based package
very soon for all to enjoy.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
