Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 15:46:31 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:19364 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225202AbTDOOq2>;
	Tue, 15 Apr 2003 15:46:28 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h3FEk6Ue008145;
	Tue, 15 Apr 2003 07:46:06 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA01823;
	Tue, 15 Apr 2003 07:46:05 -0700 (PDT)
Message-ID: <00ae01c3035e$d431aba0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	<linux-mips@linux-mips.org>
Cc: <source@mvista.com>
References: <Pine.GSO.3.96.1030415161611.13254H-100000@delta.ds2.pg.gda.pl>
Subject: Re: wbflush() abuse for TOSHIBA_RBTX4927
Date: Tue, 15 Apr 2003 16:53:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

I remember that some of the Toshiba parts of the TX39 series
had some interesting quirks relating to the write buffer.  Perhaps
some of these were carried into the TX49 series as well?

----- Original Message ----- 
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: <linux-mips@linux-mips.org>
Cc: <source@mvista.com>
Sent: Tuesday, April 15, 2003 4:22 PM
Subject: wbflush() abuse for TOSHIBA_RBTX4927


> Hello,
> 
>  I see wbflush() is abused in an interesting and inefficient way for
> TOSHIBA_RBTX4927.  Is there any specific reason for such a setup?
> 
>   Maciej
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
> 
> 
