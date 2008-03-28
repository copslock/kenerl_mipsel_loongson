Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 14:32:58 +0100 (CET)
Received: from oss.sgi.com ([192.48.170.157]:4796 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S528708AbYC1Ncw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 14:32:52 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2SDWCHJ007905
	for <linux-mips@linux-mips.org>; Fri, 28 Mar 2008 06:32:13 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2SDWjkO007437;
	Fri, 28 Mar 2008 13:32:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2SDWhfS007436;
	Fri, 28 Mar 2008 13:32:43 GMT
Date:	Fri, 28 Mar 2008 13:32:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org, Nico Coesel <ncoesel@DEALogic.nl>
Subject: Re: FW: Alchemy power managment code.
Message-ID: <20080328133243.GA7429@linux-mips.org>
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF804@dealogicserver.DEALogic.nl> <47E7B970.30105@ru.mvista.com> <47E7BB4B.3080507@ru.mvista.com> <20080327223134.GA26997@linux-mips.org> <47ECD828.8090600@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ECD828.8090600@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 28, 2008 at 02:36:08PM +0300, Sergei Shtylyov wrote:

>    The Alchemy code doesn't even try to use CP0 counter when CONFIG_PM=y if 
> you look into arch/mips/au1000/common/time.c... or at least it didn't 
> before Atsushi removed do_fast_pm_gettimeoffset().

That decission is now done by the generic time.c based only on the
availability of a counter and the mfc0 $count bug.

  Ralf
