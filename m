Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 19:42:58 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:45992 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20032283AbXKGTmz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Nov 2007 19:42:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA7Jgtji008360;
	Wed, 7 Nov 2007 19:42:55 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA7Jgsuc008359;
	Wed, 7 Nov 2007 19:42:54 GMT
Date:	Wed, 7 Nov 2007 19:42:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manoj Ekbote <manoj.ekbote@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Deleting read-only environment variable on Sibyte board.
Message-ID: <20071107194254.GA7193@linux-mips.org>
References: <20071106222834.GA4079@linux-mips.org> <03235919BBDE634289BB6A0758A20B36025B79F4@NT-SJCA-0751.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03235919BBDE634289BB6A0758A20B36025B79F4@NT-SJCA-0751.brcm.ad.broadcom.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 07, 2007 at 11:36:38AM -0800, Manoj Ekbote wrote:

> It looks like the variable was set with 'setenv -ro' command. This will
> need a manual delete.
> Bad news -  This would probably require a new firmware build.  There is
> no current command to remove -ro variables (non-existing feature).

I ran over a bit of documentation regarding how variables are stored by
CFE.  Looks easy enough to write a little app to convert those variables
to writeable.

  Ralf
