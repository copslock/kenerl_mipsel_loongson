Received:  by oss.sgi.com id <S553743AbQLNSwl>;
	Thu, 14 Dec 2000 10:52:41 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:62157 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553740AbQLNSw2>;
	Thu, 14 Dec 2000 10:52:28 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA28089;
	Thu, 14 Dec 2000 19:44:52 +0100 (MET)
Date:   Thu, 14 Dec 2000 19:44:50 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Martin Michlmayr <tbm@lanscape.net>
cc:     linux-mips@oss.sgi.com
Subject: Re: Cannot type on DECstation prom
In-Reply-To: <20001214115451.A10322@web1.lanscape.net>
Message-ID: <Pine.GSO.3.96.1001214193915.22290I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 14 Dec 2000, Martin Michlmayr wrote:

> I recently got a DECstation 5000/125 and I'm trying to get Linux to run.
> I'm using minicom and while I get output from the machine, I can not
> type anything on the prom.  When I power the machine on, I get:

 Due to historic reasons (DEC 6-pin MMJ connectors) DECstation firmware
only use DTR/DSR hw handshaking on their serial consoles.  You may either
change the wiring (not recommended), use XON/XOFF handshaking or disable
handhaking altogether when talking to the firmware.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
