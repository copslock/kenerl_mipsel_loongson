Received:  by oss.sgi.com id <S42398AbQI1Xk7>;
	Thu, 28 Sep 2000 16:40:59 -0700
Received: from u-123.karlsruhe.ipdial.viaginterkom.de ([62.180.19.123]:6662
        "EHLO u-123.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42190AbQI1Xkg>; Thu, 28 Sep 2000 16:40:36 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869544AbQI1Xjy>;
        Fri, 29 Sep 2000 01:39:54 +0200
Date:   Fri, 29 Sep 2000 01:39:54 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Klaus Naumann <spock@mgnet.de>
Cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        "Maciej W . Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
Message-ID: <20000929013954.A8494@bacchus.dhis.org>
References: <20000928214002.B767@paradigm.rfc822.org> <20000928220046.A22513@spock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000928220046.A22513@spock>; from spock@mgnet.de on Thu, Sep 28, 2000 at 10:00:46PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Sep 28, 2000 at 10:00:46PM +0200, Klaus Naumann wrote:

> BTW: What did you actually fix ? ntpdate still doesn't work
> while ntpd seems to work ok.

The NTP API was outdated.

What is the sympthom you observe with ntpdate?

> But ntpdate would be a very good idea because ntpd doesn't handle
> large offsets ...
> And obviously the realtime clock of the Indigo2 doesn't work 
> correctly. So I was calling ntpdate at every bootup to get my 
> system in a usable state. Maciej, can you take a look at ntpdate 
> please ?

I recently found that the Indigo2 apparently has a different realtime
clock from the Indy.  If that's true it explains your observation and
is unrelated the other problems.

  Ralf
