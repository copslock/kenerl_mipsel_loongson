Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 23:36:50 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:61877 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022514AbXCWXgs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 23:36:48 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2NNahSi001608;
	Fri, 23 Mar 2007 23:36:44 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2NNaeh8001606;
	Fri, 23 Mar 2007 23:36:40 GMT
Date:	Fri, 23 Mar 2007 23:36:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ravi Pratap <Ravi.Pratap@hillcrestlabs.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, miklos@szeredi.hu,
	linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
Message-ID: <20070323233639.GA517@linux-mips.org>
References: <20070323190617.GA26884@linux-mips.org> <36E4692623C5974BA6661C0B18EE8EDF6CD3C5@MAILSERV.hcrest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36E4692623C5974BA6661C0B18EE8EDF6CD3C5@MAILSERV.hcrest.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 23, 2007 at 06:17:25PM -0400, Ravi Pratap wrote:

> > Yes, that's perfectly reproducable here (running a VSMP 
> > kernel on a 34K).
> > So the fix I posted earlier was good but I did a few tweaks 
> > to it anyway.
> > Will commit to all 2.6 -stable branch and master later.
> 
> 
> Thanks so much! Will this go into 2.6.15 by any chance?

I don't recall that there every has been such a kernel release ;-)

But seriously, 2.6.15 is as dead as Tutankhamun.  I've never maintained
a 2.6.15-stable branch nor does anybody else still seem to be interested in
wasting his time on it.  And anyway flush_anon_page was only introduced in
2.6.17, so I've only fixed 2.6.17-stable and up.

  Ralf
