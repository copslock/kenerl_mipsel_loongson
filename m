Received:  by oss.sgi.com id <S553793AbRADSVZ>;
	Thu, 4 Jan 2001 10:21:25 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:25519 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553706AbRADSU7>;
	Thu, 4 Jan 2001 10:20:59 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA15729;
	Thu, 4 Jan 2001 19:12:21 +0100 (MET)
Date:   Thu, 4 Jan 2001 19:12:20 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Joe deBlaquiere <jadb@redhat.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>,
        John Van Horne <JohnVan.Horne@cosinecom.com>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        "'wesolows@foobazco.org'" <wesolows@foobazco.org>
Subject: Re: your mail
In-Reply-To: <3A54B6F4.7000909@redhat.com>
Message-ID: <Pine.GSO.3.96.1010104190629.15475A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 4 Jan 2001, Joe deBlaquiere wrote:

> It was meant as a workaround...
> 
> Perhaps we could have an option to objcopy that would allow you to copy 
> the addresses without sign extension?

 Please do either implement a clean solution or wait until someone else
(possibly me) does.  We don't want any more hacks -- MIPS/Linux already
has enough of them.  This is my view of the situation at present. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
