Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JDsRv27744
	for linux-mips-outgoing; Fri, 19 Oct 2001 06:54:27 -0700
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JDsOD27740
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 06:54:24 -0700
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP
	id CCD9C590A9; Fri, 19 Oct 2001 05:52:25 -0400 (EDT)
Message-ID: <005f01c158a5$960c9660$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: <linux-mips@oss.sgi.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
References: <Pine.GSO.3.96.1011019152309.1657F-100000@delta.ds2.pg.gda.pl>
Subject: Re: Strange behavior of serial console under 2.4.9
Date: Fri, 19 Oct 2001 09:54:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

H.J., which serial driver are you using?

Regards,
Brad

----- Original Message ----- 
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
Cc: <linux-mips@oss.sgi.com>
Sent: Friday, October 19, 2001 9:26 AM
Subject: Re: Strange behavior of serial console under 2.4.9


> On Thu, 18 Oct 2001, H . J . Lu wrote:
> 
> > I am using 9600 buad. It used to be ok under 2.4.3/2.4.5. But under
> > 2.4.9, the first 10 minutes after boot is very slow. After that, it
> > seems ok.
> 
>  That might be driver-specific.  I'm using drivers/tc/zs.c and it works
> fine at 115200 bps.
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
