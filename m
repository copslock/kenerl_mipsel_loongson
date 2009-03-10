Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Mar 2009 17:12:15 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:36529 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S21365597AbZCJRML (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Mar 2009 17:12:11 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E028940028;
	Tue, 10 Mar 2009 18:12:01 +0100 (CET)
Received: from [192.168.10.105] (c-30bde555.035-105-73746f38.cust.bredbandsbolaget.se [85.229.189.48])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id B3DDA40021;
	Tue, 10 Mar 2009 18:12:01 +0100 (CET)
Cc:	linux-mips@linux-mips.org
Message-Id: <F2420C80-46CA-4135-A82A-1A9396161FDB@lysator.liu.se>
From:	Markus Gothe <nietzsche@lysator.liu.se>
To:	ard <ard+lm@kwaak.net>
In-Reply-To: <20090308160328.GC9943@kwaak.net>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2-699887765"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Ingenic JZ4730 - illegal instruction
Date:	Tue, 10 Mar 2009 18:12:05 +0100
References: <49B1510B.8020606@kernelconcepts.de> <F2075B11-1B80-4C7B-9316-C82A0CE448C1@lysator.liu.se> <20090308160328.GC9943@kwaak.net>
X-Pgp-Agent: GPGMail 1.2.0 (v56)
X-Mailer: Apple Mail (2.930.3)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <nietzsche@lysator.liu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nietzsche@lysator.liu.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2-699887765
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Afaik it's running Xiptech uCLinux/Stuff.
When I dug into the Xburst-subarch it seemed to miss lots of stuff  
that you'd expect in a MIPS Corp. CPU core.

//Markus

On 8 Mar 2009, at 17:03, ard wrote:

> Hello,
>
> On Sun, Mar 08, 2009 at 03:53:49PM +0100, Markus Gothe wrote:
>> Well, the Xburst-arch seems to be pretty fucked up beyond all repair.
>
> Hmmm, that doesn't sound promising. But do you have references
> for that?
> Maybe google has some more info than since I first started
> searching.
> Anyway: for now it happily runs debian, and for what I can see,
> the kernel patches have no real changes except for extra drivers
> and extra board and powermanagement drivers.
> So if you have hints in which way the xburst deviates from
> "standard" mips, it could help us a lot.
> In the mean time I am going to subscribe to the ingenic forum
> ( http://www.ingenic.cn/eng/forum/vvFrmDefault.aspx )
> that contains more characters that I can't read than characters
> that I can read :-(.
>
> Regards,
> Ard
>
>
> -- 
> .signature not found
>


--Apple-Mail-2-699887765
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkm2n2UACgkQ6I0XmJx2Nrwl/ACfTm1S8mQwd2Xo/BRwI2uJyby+
JzwAoKtciwMIwkaZHWZ53f110t3nn8tv
=f0tp
-----END PGP SIGNATURE-----

--Apple-Mail-2-699887765--
