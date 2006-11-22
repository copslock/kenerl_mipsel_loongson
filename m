Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2006 19:38:36 +0000 (GMT)
Received: from real.realitydiluted.com ([66.43.201.61]:51617 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S20039197AbWKVTic (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Nov 2006 19:38:32 +0000
Received: from sjhill by real.realitydiluted.com with local (Exim 4.63)
	(envelope-from <sjhill@real.realitydiluted.com>)
	id 1Gmxve-0002QS-EC; Wed, 22 Nov 2006 13:38:42 -0600
Date:	Wed, 22 Nov 2006 13:38:42 -0600
To:	Ashlesha Shintre <ashlesha@kenati.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: request_module: runaway loop modprobe net-pf-1
Message-ID: <20061122193842.GA9307@real.realitydiluted.com>
References: <1164224559.6511.4.camel@sandbar.kenati.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164224559.6511.4.camel@sandbar.kenati.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	sjhill@real.realitydiluted.com
Return-Path: <sjhill@real.realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@real.realitydiluted.com
Precedence: bulk
X-list: linux-mips

> During boot up on the Encore M3 board (AU1500 MIPS) of the 2.6.14.6
> kernel, the process stops after the NFS filesystem has been mounted,
> memory freed  and spits out the following message:
> 
> 
> > request_module: runaway loop modprobe net-pf-1
> 
If I had to guess, you have a big endian kernel and you used a little
endian filesystem or the converse.

-Steve
