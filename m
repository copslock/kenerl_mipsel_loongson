Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 14:35:42 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:1938 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20035170AbYFMNfk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jun 2008 14:35:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5DDZLQ1005380;
	Fri, 13 Jun 2008 14:35:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5DDZLIc005379;
	Fri, 13 Jun 2008 14:35:21 +0100
Date:	Fri, 13 Jun 2008 14:35:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] decstation: Document more MB ASIC register bits
Message-ID: <20080613133521.GD703@linux-mips.org>
References: <Pine.LNX.4.55.0806130015490.23634@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0806130015490.23634@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 13, 2008 at 12:25:36AM +0100, Maciej W. Rozycki wrote:

>  Document a few more register bits provided by the MB ASIC used on R4000SC
> (KN04) and R4400SC (KN05) CPU daughtercards with the DECstation.  
> 
>  Reverse-engineered and not documented anywhere else to the best of my
> knowledge.  Bit names appended to the last underscore the same as reported
> by the firmware in register dumps.

You realize that documentation the DECstation code endangers the safety of
your job as DECstation maintainer, do you ;-)

Queued for 2.6.27, thanks!

  Ralf
