Received:  by oss.sgi.com id <S553840AbRAHQoS>;
	Mon, 8 Jan 2001 08:44:18 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:48869 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553781AbRAHQoI>;
	Mon, 8 Jan 2001 08:44:08 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA06414;
	Mon, 8 Jan 2001 17:34:06 +0100 (MET)
Date:   Mon, 8 Jan 2001 17:34:05 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Carsten Langgaard <carstenl@mips.com>,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
In-Reply-To: <20010108140506.B886@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010108173143.23234K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 8 Jan 2001, Ralf Baechle wrote:

> You obviously want to allow partial cache flushes or trampolines don't work
> and flushing the entire cache can be constructed from that.

 It depends on the implementation.  The current one obviously allows it. 
;-) 

 I'm writing of the design. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
