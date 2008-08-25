Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2008 17:57:11 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:62126 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20025817AbYHYQ5J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Aug 2008 17:57:09 +0100
Received: from lagash (p549AF43E.dip.t-dialin.net [84.154.244.62])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id D389248918;
	Mon, 25 Aug 2008 18:57:08 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1KXfNL-0004Ks-ME; Mon, 25 Aug 2008 18:57:07 +0200
Date:	Mon, 25 Aug 2008 18:57:07 +0200
From:	Thiemo Seufer <ths@networkno.de>
To:	David Daney <ddaney@avtrex.com>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: What's up with cpu_is_noncoherent_r10000() ?
Message-ID: <20080825165707.GD994@networkno.de>
References: <48B2DF15.5030903@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48B2DF15.5030903@avtrex.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> I am bringing up the git HEAD on an old ATI Xilleon X226.  This nice  
> system claims to be 4KEc, but for some reason doesn't support mips32r2,  
> but I digress.

FYI, early revisions of the 4KEc, most notably the TI AR7, are MIPS32R1.


Thiemo
