Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2004 21:39:40 +0000 (GMT)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:7428 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225255AbUKDVjf>;
	Thu, 4 Nov 2004 21:39:35 +0000
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Thu, 04 Nov 2004 22:39:29 +0100
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
To: linux-mips@linux-mips.org
Subject: Re: Compile Mips-Architecture on an i386?
Date: Thu, 4 Nov 2004 22:32:50 +0100
User-Agent: KMail/1.7
References: <20244.1099567205@www38.gmx.net> <418A2C6F.7010508@enix.org>
In-Reply-To: <418A2C6F.7010508@enix.org>
Organization: 4G Systems
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2220995.2bMazBtAf9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411042232.55210.bruno.randolf@4g-systems.biz>
X-Rcpt-To: <linux-mips@linux-mips.org>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart2220995.2bMazBtAf9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi!

another option is to use the openembedded build system:

http://openembedded.org/oe_wiki/

it includes the cross-toolchain and has lots of packages which you can=20
compile.

bruno

On Thursday 04 November 2004 14:19, Thomas Petazzoni wrote:
> Hello,
>
> Hannes Bischof a =E9crit :
> > What do I need to compile the software so that it runs under the linux
> > system of the router??
>
> You need a cross-compilation toolchain (that is a gcc, binutils and libc
> that runs on your i386, but that generates binaries for MIPS).
>
> Different tools are available to do that :
>
>   * Toolchain  : http://www.uclibc.org/toolchains.html
>   * Crosstool  : http://kegel.com/crosstool/
>   * Debian way : http://skaya.enix.org/wiki/ToolChain
>
> Thomas

--nextPart2220995.2bMazBtAf9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBiqAHfg2jtUL97G4RAtL7AKCKp6DFHVjb9a3CcPDN/eeGdaEf6wCfWC08
UPCKeMZNOuY/wQBiPbaQ4Y0=
=0p2d
-----END PGP SIGNATURE-----

--nextPart2220995.2bMazBtAf9--
