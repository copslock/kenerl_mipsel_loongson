Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 12:42:07 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:65500 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226012AbTAHMmG>; Wed, 8 Jan 2003 12:42:06 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA02452;
	Wed, 8 Jan 2003 13:41:43 +0100 (MET)
Date: Wed, 8 Jan 2003 13:41:41 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@psi.cz>
cc: linux-mips <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Guido Guenther <agx@sigxcpu.org>
Subject: Re: Remove GIO interface
In-Reply-To: <20030108133013.A17162@erebor.psi.cz>
Message-ID: <Pine.GSO.3.96.1030108133732.1580C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 8 Jan 2003, Ladislav Michl wrote:

> * Even in case everything work as stated in documentation, we are unable
>   to use this mechanism to detect Newport for console driver (the main
>   reason why I created this interface was to provide neccessary
>   informations to Xserver), because our DBE handling doesn't work until
>   modules are initialized (in case we are building kernel with modules
>   support).

 That is a bug and it should be fixed.  What are the symptoms?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
