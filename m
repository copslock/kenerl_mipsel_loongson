Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 00:25:38 +0100 (BST)
Received: from [194.216.112.127] ([194.216.112.127]:20874 "EHLO trollied.org")
	by ftp.linux-mips.org with ESMTP id S8133620AbVJRXZW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2005 00:25:22 +0100
Received: from localhost ([127.0.0.1] helo=trollied.org)
	by trollied.org with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.43)
	id 1ES0p0-0000AN-SF; Wed, 19 Oct 2005 00:24:42 +0100
Received: (from movement@localhost)
	by trollied.org (8.12.11/8.12.11/Submit) id j9INOgqc000642;
	Wed, 19 Oct 2005 00:24:42 +0100
Date:	Wed, 19 Oct 2005 00:24:42 +0100
From:	John Levon <levon@movementarian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>,
	oprofile-list@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: [Patch] Fix lookup_dcookie for MIPS o32
Message-ID: <20051018232442.GA29235@trollied.org>
References: <17236.6951.865559.479107@dl2.hq2.avtrex.com> <20051018114526.GC2656@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018114526.GC2656@linux-mips.org>
X-Url:	http://www.movementarian.org/
User-Agent: Mutt/1.5.9i
Return-Path: <movement@trollied.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: levon@movementarian.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 18, 2005 at 12:45:26PM +0100, Ralf Baechle wrote:

> > +	    && defined(_MIPSEB))
> 
> Small nit - please use __MIPSEB__ rsp. __MIPSEL__; I think there are

I made it so; David, please check.

thanks
john
