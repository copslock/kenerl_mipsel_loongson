Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 14:39:41 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:39049 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225211AbTBEOjl>; Wed, 5 Feb 2003 14:39:41 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA09363;
	Wed, 5 Feb 2003 15:39:51 +0100 (MET)
Date: Wed, 5 Feb 2003 15:39:51 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Long Li <long21st@yahoo.com>
cc: linux-mips@linux-mips.org
Subject: Re: Specify the as path when gcc runs
In-Reply-To: <20030205024153.67587.qmail@web40401.mail.yahoo.com>
Message-ID: <Pine.GSO.3.96.1030205153557.8316A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 4 Feb 2003, Long Li wrote:

> Is there a way that I can specify the path for 'as' on
> the fly when I use gcc? I have a MIPS cross compiler

 Use "-B<path>".  You may use "-print-prog-name=as" to get feedback to be
sure the right binary is picked.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
