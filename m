Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 16:09:08 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:29447 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134064AbVKPQIv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 16:08:51 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAGGAjSD016500;
	Wed, 16 Nov 2005 16:10:46 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAGGAWlP016496;
	Wed, 16 Nov 2005 16:10:32 GMT
Date:	Wed, 16 Nov 2005 16:10:32 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	colin <colin@realtek.com.tw>
Cc:	linux-mips@linux-mips.org
Subject: Re: Does oProfile support 4KE now?
Message-ID: <20051116161031.GH3229@linux-mips.org>
References: <006c01c5ea83$c7cec780$106215ac@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006c01c5ea83$c7cec780$106215ac@realtek.com.tw>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 16, 2005 at 04:00:16PM +0800, colin wrote:

> >From the CVS of oProfile
> http://cvs.sourceforge.net/viewcvs.py/oprofile/oprofile/events/mips/, I
> donot see 4KE in it.

The 4K processors don't implement performance counters which are required
for any serious use of Oprofile.  Lacking performance counters there is
always the fallback option of using the timer interrupt but of course
that means you won't be able to take advantage of much of Oprofile's
fancyness.

  Ralf
