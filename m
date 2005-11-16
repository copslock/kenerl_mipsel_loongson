Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 14:30:29 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:62238 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134061AbVKPOaL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 14:30:11 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAGEWBmj011538;
	Wed, 16 Nov 2005 14:32:11 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAGEWBSj011537;
	Wed, 16 Nov 2005 14:32:11 GMT
Date:	Wed, 16 Nov 2005 14:32:11 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems with Linux kernel on Broadcom SB1
Message-ID: <20051116143211.GE3229@linux-mips.org>
References: <20051115204828.31990.qmail@web31501.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115204828.31990.qmail@web31501.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 15, 2005 at 12:48:28PM -0800, Jonathan Day wrote:

> Trying to build the Linux kernel currently in the git
> archive on a Broadcom SB1 (specifically, the 1250 dual
> processor system).
> 
> I've not been able to get any of the page sizes other
> than the 4K pages to work at all - it stops at boot,

This option is marked experimental.  So you choose to experiment and you
saw the pyrotechnics fly ;-)

  Ralf
