Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 15:25:37 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:27063 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225357AbUANPZf>; Wed, 14 Jan 2004 15:25:35 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 4B8464BE10; Wed, 14 Jan 2004 16:25:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 3BCA244F39; Wed, 14 Jan 2004 16:25:33 +0100 (CET)
Date: Wed, 14 Jan 2004 16:25:33 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dan Aizenstros <dan@quicklogic.com>, Pete Popov <ppopov@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <4004295F.9060104@quicklogic.com>
Message-ID: <Pine.LNX.4.55.0401141623210.9549@jurand.ds.pg.gda.pl>
References: <20040113080926Z8225270-16706+2387@linux-mips.org>
 <4004295F.9060104@quicklogic.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 13 Jan 2004, Dan Aizenstros wrote:

> You broke any build that does not define CONFIG_SERIAL_AU1X00
> by adding an #error in the include/asm-mips/serial.h file.
> 
> -- Dan A.
> 
> ppopov@linux-mips.org wrote:
> 
> > CVSROOT:	/home/cvs
> > Module name:	linux
> > Changes by:	ppopov@ftp.linux-mips.org	04/01/13 08:09:22

 Thanks for the report.  It looks like a typo.  I've removed the #error
statement -- Pete please check if that's what's intended.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
