Received:  by oss.sgi.com id <S553870AbRAHSF1>;
	Mon, 8 Jan 2001 10:05:27 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:61414 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553866AbRAHSFL>;
	Mon, 8 Jan 2001 10:05:11 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA09757;
	Mon, 8 Jan 2001 18:56:56 +0100 (MET)
Date:   Mon, 8 Jan 2001 18:56:55 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Carsten Langgaard <carstenl@mips.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>,
        "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
In-Reply-To: <3A59EFEB.9D35514E@mips.com>
Message-ID: <Pine.GSO.3.96.1010108184721.23234Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 8 Jan 2001, Carsten Langgaard wrote:

> Exactly that I need, but I don't think it is implemented properly for mips.
> It simply flushes all the caches, no matter what options you gives it.

 Yep, it's just a limitation of the implementation.  But it's the right
function and now that I know of the problem it goes to my to do list (but
processing of the list is not that fast these days, so anyone feel free to
do it oneself). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
