Received:  by oss.sgi.com id <S42183AbQFVW3o>;
	Thu, 22 Jun 2000 15:29:44 -0700
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:3833 "EHLO
        mta01-svc.server.ntlworld.com") by oss.sgi.com with ESMTP
	id <S42182AbQFVW3a>; Thu, 22 Jun 2000 15:29:30 -0700
Received: from icserver.ichilton.co.uk ([62.252.236.190])
          by mta02-svc.server.ntlworld.com
          (InterMail vM.4.01.02.27 201-229-119-110) with ESMTP
          id <20000622232436.OCPH10065.mta02-svc.server.ntlworld.com@icserver.ichilton.co.uk>
          for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 23:24:36 +0000
Received: from ian (ian.ichilton.local [192.168.0.8])
	by icserver.ichilton.co.uk (8.10.2/8.10.1) with SMTP id e5MMNZC02639
	for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 23:23:36 +0100
From:   "Ian Chilton" <mailinglist@ichilton.co.uk>
To:     "Linux-MIPS Mailing List" <linux-mips@oss.sgi.com>
Subject: RE: Bootp Problems
Date:   Thu, 22 Jun 2000 23:23:38 +0100
Message-ID: <NAENLMKGGBDKLPONCDDOIEPFCNAA.mailinglist@ichilton.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4132.2800
In-Reply-To: <NAENLMKGGBDKLPONCDDOAEOMCNAA.mailinglist@ichilton.co.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

Problems fixed!

The origional problem was my firewall, and the later problem was, I had a
script to start portmap, rpc.mountd and rpc.nfsd, at boot time. However,
when I log in after booting, rpc.mountd is no longer loaded.

So, the only fix was to stop the 'startnfs' script being run at boottime,
and run it manually.


Bye for Now,

Ian


                     \|||/
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
