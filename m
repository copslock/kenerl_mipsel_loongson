Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 19:23:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64480 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023001AbXJ2TX5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 19:23:57 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TJNnFI020827;
	Mon, 29 Oct 2007 19:23:49 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TJNiwf020826;
	Mon, 29 Oct 2007 19:23:44 GMT
Date:	Mon, 29 Oct 2007 19:23:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] sb1250-swarm_defconfig: Enable GenBus IDE
Message-ID: <20071029192344.GA20818@linux-mips.org>
References: <Pine.LNX.4.64N.0710121641150.21684@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710121641150.21684@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 12, 2007 at 04:46:56PM +0100, Maciej W. Rozycki wrote:

>  Enable the onboard GenBus IDE interface in the default configuration.

Indeed, that's sort of useful ;-)

> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
>  I see no reason to keep it disabled; I think the onboard devices deserve 
> some automatic build-time testing -- at least ones for which drivers are 
> known to be in a reasonable shape.

It got disabled when some IDE maintainer went out of control and removed the
driver entirely.

>  As a side note, this configuration template has not been regenerated for 
> a long time and is thus severely outdated.  I am tempted to do this, 
> obviously setting any new options to my liking -- I'll send another patch 
> for it unless somebody objects.

Feel free.

  Ralf
