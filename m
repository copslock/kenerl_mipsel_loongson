Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77ECN419855
	for linux-mips-outgoing; Tue, 7 Aug 2001 07:12:23 -0700
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77ECKV19839
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 07:12:20 -0700
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP
	id 8C5BC590AC; Tue,  7 Aug 2001 10:09:51 -0400 (EDT)
Message-ID: <089d01c11f4b$449b4800$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010807160731.3289D-100000@delta.ds2.pg.gda.pl>
Subject: Re: cross-mipsel-linux-ld --prefix library path
Date: Tue, 7 Aug 2001 10:14:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----- Original Message -----
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Tuesday, August 07, 2001 10:10 AM
Subject: Re: cross-mipsel-linux-ld --prefix library path


>  You don't need to specify "--prefix=/usr/mipsel-linux" for building
> cross-binutils.  The scripts will add the target alias automatically for
> files that need it -- if you look at the scripts,
> "${prefix}/${target_alias}" is the so called "tooldir".

Oh...  The mysteries of cross-toolchain building.  Thanks.

So if I leave out --prefix alogether, will "make install" overwrite any x86
stuff, like that libbfd.la file I mentioned?

Regards,
Brad
