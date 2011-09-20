Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2011 04:42:09 +0200 (CEST)
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:36789 "EHLO
        qmta04.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490965Ab1ITCmF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2011 04:42:05 +0200
Received: from omta21.emeryville.ca.mail.comcast.net ([76.96.30.88])
        by qmta04.emeryville.ca.mail.comcast.net with comcast
        id ag291h0071u4NiLA4qhu7W; Tue, 20 Sep 2011 02:41:54 +0000
Received: from [192.168.1.13] ([76.106.65.35])
        by omta21.emeryville.ca.mail.comcast.net with comcast
        id aqqU1h0090leNgC8hqqUQf; Tue, 20 Sep 2011 02:50:29 +0000
Message-ID: <4E77FD57.2000407@gentoo.org>
Date:   Mon, 19 Sep 2011 22:41:27 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
MIME-Version: 1.0
To:     BSDero <bsdero@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Does the VIA VT6212 USB Host controller works on SGI/Mips?
References: <loom.20110920T021938-457@post.gmane.org>
In-Reply-To: <loom.20110920T021938-457@post.gmane.org>
X-Enigmail-Version: 1.2.1
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC82FCDA4FF75AD272A8389E"
X-archive-position: 31109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10303

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC82FCDA4FF75AD272A8389E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/19/2011 20:22, BSDero wrote:

> I'm working on a Driver for this device in Irix, and I don't know if th=
is works
> ok... I can not get PCI interrupts with this device...=20
>=20
> How is it in SGI/MIps Linux?=20

Can't say I've ever tested that specific chip.  I have tested VIA chips i=
n
an SGI O2 before, and if memory serves, ohci worked pretty well.  I think=

there were problems with uhci.  ehci seemed to work fine, too.  Not teste=
d
xhci yet.

That said, why IRIX?  That's been dead for almost 6 years now.

--=20
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  A=
nd
our lives slip away, moment by moment, lost in that vast, terrible in-bet=
ween."

--Emperor Turhan, Centauri Republic


--------------enigBC82FCDA4FF75AD272A8389E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQIcBAEBAgAGBQJOd/1XAAoJENsjoH7SXZXjf14P/0bcjtMBRtknC/JpbKbLuaqv
IIUHl0eiZU13UOuNKeS1eBhWy6iHXM94lU8H/Nqv8Pqssyxtlx3l4v3XqEIsUrA8
kBVhOjuH2MWt+pnjenH+akrI3RfwBsh+RbTwSetpt2s+1ZuxEZfygg9xOkiTdyHo
P4HGvpt5tf8mD8XIT6fcbO2n1aReZFZW0DX124bkXWeNIyW69uXodBaU/OJguP3j
+qbWT8r+49vhgVSsMKlJ0Aaa926RXMK4oob2kiausPC4w5V9iSO7f4BQ6Um6Sxkf
bogL+7na/3yBl6NmP62dWUT9MYt2yFAsAtqCSvgp6m+QjQqh3WU2ckXFyPIyGoCs
rPFctg/SD9dkiinYwN42iv+0si41bYuUoDToDdTgrlmy0vG1zRzIcSjeUeD1vGS1
874cV2NRKSDYFONLfi/ePRtD8pe4iFs7x1eMPbM9zjZp2I/GaY3YE4jVrXEPb1ns
gpIs/lzGop60eQbXBHhT8KGg5wJy4x4EGaRyVoVOLzHSnLBMwxN3gX41msONvsDB
/qOr/gCWS1d21rgwhgQ8nwBGGz5ixhNFwLX4vrvFVkNAMFlopQzxjl1HIGdo0tiG
WnoJ7HAgnHM710P/I+AN65iU9mDvuYgbL2k2/PczTkZxQ85OKkIDSHFMZgG2aiHw
8d7R5t5IaPpCfYHlKZDU
=0iXi
-----END PGP SIGNATURE-----

--------------enigBC82FCDA4FF75AD272A8389E--
