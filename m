Received:  by oss.sgi.com id <S42387AbQI1UBO>;
	Thu, 28 Sep 2000 13:01:14 -0700
Received: from pC19F6C93.dip.t-dialin.net ([193.159.108.147]:58377 "HELO
        scotty.mgnet.de") by oss.sgi.com with SMTP id <S42380AbQI1UBA>;
	Thu, 28 Sep 2000 13:01:00 -0700
Received: (qmail 13323 invoked from network); 28 Sep 2000 20:00:46 -0000
Received: from spock.mgnet.de (HELO scotty.mgnet.de) (192.168.1.4)
  by scotty.mgnet.de with SMTP; 28 Sep 2000 20:00:46 -0000
Date:   Thu, 28 Sep 2000 22:00:46 +0200
From:   Klaus Naumann <spock@mgnet.de>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
        "Maciej W . Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
Message-ID: <20000928220046.A22513@spock>
Reply-To: spock@mgnet.de
References: <20000928214002.B767@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20000928214002.B767@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Sep 28, 2000 at 21:40:02 +0200
X-Mailer: Balsa 0.8.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Thu, 28 Sep 2000 21:40:02 Florian Lohoff wrote:
> Hi,
> since this commit my machines are all broken (5000/260, 5000/150 
> and 5000/125) - They all hang in the "Calibrating delay loop ...".
> 
> Reverting it let me boot the current kernels ...
> 
> Maciej ?

BTW: What did you actually fix ? ntpdate still doesn't work
while ntpd seems to work ok.
But ntpdate would be a very good idea because ntpd doesn't handle
large offsets ...
And obviously the realtime clock of the Indigo2 doesn't work 
correctly. So I was calling ntpdate at every bootup to get my 
system in a usable state. Maciej, can you take a look at ntpdate 
please ?

	TIA, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
