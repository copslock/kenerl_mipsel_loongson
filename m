Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2009 08:17:38 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:65161 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492118AbZJTGRc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Oct 2009 08:17:32 +0200
Received: by ewy10 with SMTP id 10so6704490ewy.33
        for <linux-mips@linux-mips.org>; Mon, 19 Oct 2009 23:17:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=lx7LBNatXhgBfAs7kD3U2WegA+uEc8Z2eAZj13WvHF8=;
        b=H6UEhAq+7ODqBjEA1YMIAOAaEEItEdWwSgRvfKDkTFne9HktsgLSQT5IS4p5nZrsV0
         HZz+69I28bBIkPpq8dReGtXdnO3nzKYF1nCJsP7kEI9zP6O46aen4QER2Im5mstds1WK
         UHJUxaCGl4S3BCpuEolGQAT7JNb3pxcWK6CUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=x3ze4qT0UYrSO/d/RDbu5PRwdSrugH0vpdQEn8SaMIziM8pkSxRuoUan3AF+0Lex++
         X8vKXoscAo4lHyfiLUq2X0xvIVwX9iJZokzKeEUYuXbyiXzlpkkSmCwGU1/KWhoOwNVx
         NW2nhdusKDmeDCPuMcECzCmbegGyqdYh49YBY=
Received: by 10.216.88.209 with SMTP id a59mr1341678wef.50.1256019446508;
        Mon, 19 Oct 2009 23:17:26 -0700 (PDT)
Received: from lenovo.localnet (147.59.76-86.rev.gaoland.net [86.76.59.147])
        by mx.google.com with ESMTPS id 7sm3713624eyg.10.2009.10.19.23.17.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Oct 2009 23:17:25 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:	myuboot@fastmail.fm
Subject: Re: serial port 8250 messed up after coverting from little endian to big endian on kernel  2.6.31
Date:	Tue, 20 Oct 2009 08:17:23 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.29-2-686; KDE/4.3.1; i686; ; )
Cc:	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>
References: <1255735395.30097.1340523469@webmail.messagingengine.com> <4AD906D8.3020404@caviumnetworks.com> <1255996564.10560.1340920621@webmail.messagingengine.com>
In-Reply-To: <1255996564.10560.1340920621@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4081583.Nnz8PKjnI1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910200817.24018.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart4081583.Nnz8PKjnI1
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 20 octobre 2009 01:56:04, myuboot@fastmail.fm a =E9crit :
> I am trying to bringup a MIPS32 board using 2.6.31. It is working in
> little endian mode. After changing the board's hardware from little
> endian to bit endian, the serial port print messed up. It prints now
> something like - "=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0" on th=
e screen. When I trace the
> execution, I can see the string the kernel is trying print is correct -
> "Linux version 2.6.31 ..." and etc.
>=20
> I guess it means the initialization of the serial port is not properly
> done. But I am not sure where I should check for the problem. The serial
> port device I am using is 8250. Please give me some advise.

If the same initialization routine used to work in little-endian, check how=
=20
you actually write and read characters from the UART FIFO and especially if=
=20
your hardware requires you to do word or byte access to these registers.

You can have a look at AR7, which has the same code working for Little and =
Big=20
Endian modes in arch/mips/ar7/prom.c lines 272 to the end of the file. It a=
lso=20
uses a 8250-compatible UART.

--nextPart4081583.Nnz8PKjnI1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkrdVfMACgkQlyvkmBGtjyYRAwCfR3P8YgiNVpAQw+WPnOke42t/
aucAoLaDJ/ICmDVQ4RqN7ly1vS/hqwOR
=ZwRw
-----END PGP SIGNATURE-----

--nextPart4081583.Nnz8PKjnI1--
