Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g55MlanC023477
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 5 Jun 2002 15:47:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g55MlalW023476
	for linux-mips-outgoing; Wed, 5 Jun 2002 15:47:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g55MlVnC023473;
	Wed, 5 Jun 2002 15:47:31 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04048; Wed, 5 Jun 2002 15:49:34 -0700 (PDT)
	mail_from (ica2_ts@csv.ica.uni-stuttgart.de)
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17FjPX-000Lfm-00; Thu, 06 Jun 2002 00:37:47 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17FjQh-0000GW-00; Thu, 06 Jun 2002 00:38:59 +0200
Date: Thu, 6 Jun 2002 00:38:59 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@oss.sgi.com>, "Gleb O. Raiko" <raiko@niisi.msk.ru>,
   Jun Sun <jsun@mvista.com>, Alexandr Andreev <andreev@niisi.msk.ru>,
   linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
Message-ID: <20020605223859.GO23411@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020603230107.GH23411@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1020604163438.17556C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020604163438.17556C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej W. Rozycki wrote:
> On Tue, 4 Jun 2002, Thiemo Seufer wrote:
> 
> > One simple patch [1] is missing from the release. R_MIPS_HIGHEST relocs
> > are zeroed out in a few cases where the assembler resolves them itself.
> > The rest works for me quite nice.
> 
>  How about R_MIPS_26 relocs?  I discovered they are broken for the 64 ABI
> (likely a RELA problem) and I am currently working on a fix.  As a result
> of the bug a kernel executable is useless.

I forgot about this one, sorry. I have a patch for it, I think it will
go in for 2.13.


Thiemo
