Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 13:07:10 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:39056 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225192AbTB0NHK>; Thu, 27 Feb 2003 13:07:10 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA22035;
	Thu, 27 Feb 2003 14:07:21 +0100 (MET)
Date: Thu, 27 Feb 2003 14:07:21 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Change -mcpu option for VR41xx
In-Reply-To: <20030227213707.5d8eb02a.yoichi_yuasa@montavista.co.jp>
Message-ID: <Pine.GSO.3.96.1030227140134.19733F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 27 Feb 2003, Yoichi Yuasa wrote:

> >  Ah, I see how it happens now -- "-mipsN" has a higher priority than
> > "-mcpu=" (but lower than "-march=") so in this case "-mips2" overrides
> > "-mcpu=vr4100".  How about:
> > 
> > GCCFLAGS	+= -mcpu=vr4100 -Wa,--trap
> > 
> > then?
> 
> That is fine.
> However, the following warning is displayed.
> 
> Warning: The -mcpu option is deprecated.  Please use -march and -mtune instead.

 Does is disappear with "-m4100"?  That would be strange.  And "-mcpu=" is
indeed deprecated, but it works for most versions and "-march=" and
"-mtune=" are too new to be used by everyone.  But as I wrote, we will end
with a test for these options eventually as "-mcpu=" is already removed
from the trunk.  As a result the warning will disappear.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
