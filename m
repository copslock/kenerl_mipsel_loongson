Received:  by oss.sgi.com id <S553698AbQL1M3m>;
	Thu, 28 Dec 2000 04:29:42 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:47600 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553678AbQL1M3T>;
	Thu, 28 Dec 2000 04:29:19 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA22644;
	Thu, 28 Dec 2000 13:25:57 +0100 (MET)
Date:   Thu, 28 Dec 2000 13:25:56 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Joe deBlaquiere <jadb@redhat.com>
cc:     Ralf Baechle <ralf@uni-koblenz.de>,
        the list <linux-kernel@vger.kernel.org>,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: sysmips call and glibc atomic set
In-Reply-To: <3A48CC1D.9000204@redhat.com>
Message-ID: <Pine.GSO.3.96.1001228132356.21148C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 26 Dec 2000, Joe deBlaquiere wrote:

> > Read the ISA manual; sc will fail if the LL-bit in c0_status is cleared
> > which will be cleared when the interrupt returns using the eret instruction.
> 
> I tried to find a MIPSIII manual from mips.com but all I could find was 
> mips32 and mips64 (which are not the same as MIPSII/MIPSIII/MIPSIV).

 Get "IDT MIPS Microprocessor Software Reference Manual" from
http://decstation.unix-ag.org/docs/ic_docs/3715.pdf (the original is no
longer available from IDT servers).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
