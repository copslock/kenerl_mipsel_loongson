Received:  by oss.sgi.com id <S553900AbQK3Vab>;
	Thu, 30 Nov 2000 13:30:31 -0800
Received: from natmail2.webmailer.de ([192.67.198.65]:63201 "EHLO
        post.webmailer.de") by oss.sgi.com with ESMTP id <S553816AbQK3VaH>;
	Thu, 30 Nov 2000 13:30:07 -0800
Received: from scotty.mgnet.de (pC19F6F69.dip.t-dialin.net [193.159.111.105])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id WAA05262
	for <linux-mips@oss.sgi.com>; Thu, 30 Nov 2000 22:30:06 +0100 (MET)
Received: (qmail 30794 invoked from network); 30 Nov 2000 21:29:59 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 30 Nov 2000 21:29:59 -0000
Date:   Thu, 30 Nov 2000 22:30:01 +0100 (CET)
From:   Klaus Naumann <spock@mgnet.de>
To:     Calvine Chew <calvine@sgi.com>
cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: I'm stuck...
In-Reply-To: <43FECA7CDC4CD411A4A3009027999112267CAB@sgp-apsa001e--n.singapore.sgi.com>
Message-ID: <Pine.LNX.4.21.0011302226250.30299-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 30 Nov 2000, Calvine Chew wrote:

> Hi Klaus...
> 
> I would have installed RedHat 6.2 (like a trueblue SGI-man :-) but
> the boot kernel hits the PC Card Services hang on installation.
> SuSE 6.4 doesn't, hooked up my ethernet/modem and scsi cards beautifully.

It's ok - I was just kiddin' because it's known that I'm not a big fan
of the SuSE distribution for several reasons - but I'm far away from
wanting to start a distro war here. So to make it clear I really was
joking.

[snipped verbose message]

Calvine, what I'm asking myself is, if the box actually has connection
to the net. Becuase if you don't get a single packet out on bootp time
then something really is broken. So please try to check in any way if
the box has netconn - does it have an AUI ? Some SGI systems seem
to use that as first ethernet adapter and have problems with it ...

			HTH, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
