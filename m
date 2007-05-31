Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2007 13:25:53 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11160 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021367AbXEaMZv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 May 2007 13:25:51 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4VCPeRD000988;
	Thu, 31 May 2007 13:25:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4VCPdbJ000977;
	Thu, 31 May 2007 13:25:39 +0100
Date:	Thu, 31 May 2007 13:25:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] zs: Updates to fix issues raised
Message-ID: <20070531122539.GA32168@linux-mips.org>
References: <Pine.LNX.4.64N.0705311023100.7856@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0705311023100.7856@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 31, 2007 at 11:04:53AM +0100, Maciej W. Rozycki wrote:

>  This is a set of fixes to the initial revision of the zs driver port to 
> the serial subsystem.  They include an update to the recovery delay, and 
> the race on interrupt handler registration.  As well as a number of style 
> fixes throughout.

Cool.  So this leaves sb1250_duart.c as the last stoneage driver.

  Ralf
