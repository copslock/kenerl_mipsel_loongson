Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 12:29:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26525 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021978AbXHBL30 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 12:29:26 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l72BTQ6w026989;
	Thu, 2 Aug 2007 12:29:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l72BTQhN026988;
	Thu, 2 Aug 2007 12:29:26 +0100
Date:	Thu, 2 Aug 2007 12:29:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Imre Kaloz <kaloz@openwrt.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Sync SiByte system code to the new DUART driver
Message-ID: <20070802112926.GB25949@linux-mips.org>
References: <op.twfh4cuw2s3iss@ecaz.afh.b-m.hu> <20070802111314.GA25949@linux-mips.org> <Pine.LNX.4.64N.0708021218280.22591@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0708021218280.22591@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 02, 2007 at 12:26:22PM +0100, Maciej W. Rozycki wrote:

>  Most of that stuff does not work anymore anyway and now you risk link 
> errors. ;-)  I do not think there is place for driver-related #ifdefs 
> under arch/ anyway, the answer being platform devices.  Though chances are 
> nobody might be bothered to ever implement them here.
> 
>  Also the #ifdefs in arch/mips/sibyte/cfe/console.c do not make sense to 
> me.

Unfortunately you're right ...

  Ralf
