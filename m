Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAGDN3b27711
	for linux-mips-outgoing; Fri, 16 Nov 2001 05:23:03 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAGDN1g27707
	for <linux-mips@oss.sgi.com>; Fri, 16 Nov 2001 05:23:01 -0800
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 164ixQ-0004mP-00; Fri, 16 Nov 2001 14:23:00 +0100
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 164iwC-0006BG-00; Fri, 16 Nov 2001 14:21:44 +0100
Date: Fri, 16 Nov 2001 14:21:43 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: Re: [PATCH] indy_int clenaup
Message-ID: <20011116142143.A23733@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <Pine.LNX.4.21.0111161316240.26371-100000@hlubocky.del.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0111161316240.26371-100000@hlubocky.del.cz>; from ladislav.michl@hlubocky.del.cz on Fri, Nov 16, 2001 at 01:49:22PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Nov 16, 2001 at 01:49:22PM +0100, Ladislav Michl wrote:
> note for those, who are waiting for VINO driver: at the beginning I was
> unable to start DMA transfer. now i'm unable to stop it... so to bring my
> ego from dust, i decided to write HAL2 driver, which needs HPC interupts.
> this patch is HAL2 driver by-product...
I've done some work on porting Ulf's old ALSA HAL2 codebase to a more recent
(0.9) version of alsa, could that be of any use to you? 
 -- Guido
