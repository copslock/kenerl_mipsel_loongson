Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2007 01:03:20 +0000 (GMT)
Received: from smtp.ocgnet.org ([64.20.243.3]:64729 "EHLO smtp.ocgnet.org")
	by ftp.linux-mips.org with ESMTP id S20037582AbXA3BDN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2007 01:03:13 +0000
Received: from smtp.ocgnet.org (localhost [127.0.0.1])
	by smtp.ocgnet.org (Postfix) with ESMTP id D15235203F4;
	Mon, 29 Jan 2007 19:02:39 -0600 (CST)
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp [124.34.33.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ocgnet.org (Postfix) with ESMTP id 6B3225203E0;
	Mon, 29 Jan 2007 19:02:39 -0600 (CST)
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id 54DF61029C4;
	Tue, 30 Jan 2007 01:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UGdwcgl1NX24; Tue, 30 Jan 2007 10:00:55 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
	id 74B051029C3; Tue, 30 Jan 2007 10:00:55 +0900 (JST)
Date:	Tue, 30 Jan 2007 10:00:55 +0900
From:	Paul Mundt <lethal@linux-sh.org>
To:	Rodolfo Giometti <giometti@enneenne.com>
Cc:	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org
Subject: Re: Advice on APM-EMU reunion
Message-ID: <20070130010055.GA15907@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Rodolfo Giometti <giometti@enneenne.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org
References: <20070129230755.GA8705@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070129230755.GA8705@enneenne.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 30, 2007 at 12:07:56AM +0100, Rodolfo Giometti wrote:
> some months ago I sent to the MIPS and ARM mail lists a patch to unify
> the several APM emulation codes adding a new dedicated directory so it
> can be used to put there the per board specific code avoiding code
> duplications (see files ./arch/arm/kernel/apm.c,
> ./arch/mips/kernel/apm.c and ./arch/sh/kernel/apm.c that are almost
> the same).
> 
> The patch is here
> "http://www.linux-mips.org/archives/linux-mips/2006-07/msg00144.html"
> and it has been lost in the deep space...
> 
Not quite, the rationale for it being dropped was here:

http://article.gmane.org/gmane.linux.kernel/485831

However, it has since been reposted:

http://article.gmane.org/gmane.linux.kernel/485833
http://article.gmane.org/gmane.linux.kernel/485834
http://article.gmane.org/gmane.linux.kernel/485835
http://article.gmane.org/gmane.linux.kernel/485837

and merged back in to -mm. This is all post 2.6.20 stuff, though..
