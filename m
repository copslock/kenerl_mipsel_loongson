Received:  by oss.sgi.com id <S553755AbQLNS7v>;
	Thu, 14 Dec 2000 10:59:51 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:4046 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553747AbQLNS7o>;
	Thu, 14 Dec 2000 10:59:44 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA28285;
	Thu, 14 Dec 2000 19:49:39 +0100 (MET)
Date:   Thu, 14 Dec 2000 19:49:38 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Karel van Houten <K.H.C.vanHouten@research.kpn.com>
cc:     Martin Michlmayr <tbm@lanscape.net>, linux-mips@oss.sgi.com
Subject: Re: Cannot type on DECstation prom
In-Reply-To: <200012141830.TAA01589@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1001214194542.22290J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 14 Dec 2000, Karel van Houten wrote:

> These DECStations require full modem control signals on the
> prom console. I would build a D25 serial modem-faker cable:
> 
>  1 ------------------- 1
> 
>  2 -------\ /--------- 2
>            X
>  3 -------/ \--------- 3
> 
>  4 -+               +- 4
>     |               |
>  5 -+               +- 5
> 
>  6 -+               +- 6
>     |               |
>  7 -)---------------)- 7
>     |               |
>  8 -+               +- 8
>     |               |
> 20 -+               +- 20
> 
> This should work.

 It would work for firmware, but it would break for RTS/CTS hanshaking
(the standard one these days).  At 9600bps you may well live with it, but
for anything faster you'll likely lose characters. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
