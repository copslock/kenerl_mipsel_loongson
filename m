Received:  by oss.sgi.com id <S42272AbQI2FvB>;
	Thu, 28 Sep 2000 22:51:01 -0700
Received: from pC19F6C93.dip.t-dialin.net ([193.159.108.147]:12811 "HELO
        scotty.mgnet.de") by oss.sgi.com with SMTP id <S42190AbQI2Fuj>;
	Thu, 28 Sep 2000 22:50:39 -0700
Received: (qmail 19574 invoked from network); 29 Sep 2000 05:50:35 -0000
Received: from spock.mgnet.de (HELO scotty.mgnet.de) (192.168.1.4)
  by scotty.mgnet.de with SMTP; 29 Sep 2000 05:50:35 -0000
Date:   Fri, 29 Sep 2000 07:50:35 +0200
From:   Klaus Naumann <spock@mgnet.de>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com, "Maciej W . Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
Message-ID: <20000929075035.A23290@spock>
Reply-To: spock@mgnet.de
References: <20000929013954.A8494@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20000929013954.A8494@bacchus.dhis.org>; from ralf@oss.sgi.com on Fri, Sep 29, 2000 at 01:39:54 +0200
X-Mailer: Balsa 0.8.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Fri, 29 Sep 2000 01:39:54 Ralf Baechle wrote:
> On Thu, Sep 28, 2000 at 10:00:46PM +0200, Klaus Naumann wrote:
> 
> > BTW: What did you actually fix ? ntpdate still doesn't work
> > while ntpd seems to work ok.
> 
> The NTP API was outdated.
> 
> What is the sympthom you observe with ntpdate?

When I call it it's sleeping for several seconds.
And after that I get

29 Sep 07:49:37 ntpdate[10880]: poll(): nfound = 0, error: Operation not
permitted

which seems to loop then.
If I would have a working strace on my box I could tell you more :/

 
> > But ntpdate would be a very good idea because ntpd doesn't handle
> > large offsets ...
> > And obviously the realtime clock of the Indigo2 doesn't work 
> > correctly. So I was calling ntpdate at every bootup to get my 
> > system in a usable state. Maciej, can you take a look at ntpdate 
> > please ?
> 
> I recently found that the Indigo2 apparently has a different realtime
> clock from the Indy.  If that's true it explains your observation and
> is unrelated the other problems.

Yes, it's of course unrelated to the other problem - it's just
an explanation why ntpdate is of real use.

		CU, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
