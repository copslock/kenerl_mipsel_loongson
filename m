Received:  by oss.sgi.com id <S305162AbQBOFwt>;
	Mon, 14 Feb 2000 21:52:49 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:5949 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBOFwd>; Mon, 14 Feb 2000 21:52:33 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id VAA09707; Mon, 14 Feb 2000 21:55:24 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id VAA20005; Mon, 14 Feb 2000 21:52:32 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA29388
	for linux-list;
	Mon, 14 Feb 2000 21:39:03 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA99604
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 14 Feb 2000 21:39:01 -0800 (PST)
	mail_from (sgi.com!Cologne.DE!excalibur.cologne.de!karsten)
Received: from fileserv2.Cologne.DE (fileserv2.cologne.de [193.29.188.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id VAA02594
	for <linux@cthulhu.engr.sgi.com>; Mon, 14 Feb 2000 21:38:59 -0800 (PST)
	mail_from (Cologne.DE!excalibur.cologne.de!karsten)
Received: from localhost (1472 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m12KahL-0006xPC@fileserv2.Cologne.DE>
	for <linux@cthulhu.engr.sgi.com>; Tue, 15 Feb 2000 06:38:55 +0100 (CET)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id WAA05152;
	Mon, 14 Feb 2000 22:23:12 +0100
Message-ID: <20000214222312.D3707@excalibur.cologne.de>
Date:   Mon, 14 Feb 2000 22:23:12 +0100
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: Where can I find the SRPMs
Mail-Followup-To: linux@cthulhu.engr.sgi.com
References: <38A820B1.BA9FD53F@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91i
In-Reply-To: <38A820B1.BA9FD53F@mips.com>; from Carsten Langgaard on Mon, Feb 14, 2000 at 04:35:13PM +0100
X-No-Archive: yes
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Feb 14, 2000 at 04:35:13PM +0100, Carsten Langgaard wrote:

> I haven't been able to locate the SRPMs for the following RPMs:
> 
> info-3.12-4.mipseb.rpm
> zlib-devel-1.1.2-2.mipseb.rpm
> glibc-devel-2.0.6-4.mipseb.rpm

I do not have the locations for these available, but at least on little
endian systems the RedHat-6.0 packages zlib-1.1.3 and info-3.12f compile
out of the box.
I have a glibc-2.0.6-6.src.rpm from ftp.linux.sgi.com but I have not
seen a glibc-2.0.6-4.src.rpm.

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
