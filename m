Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 13:25:02 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:15962 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6820484AbaDCLZA2t-gD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2014 13:25:00 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 83D8641F8D75;
        Thu,  3 Apr 2014 12:24:54 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 03 Apr 2014 12:24:54 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 03 Apr 2014 12:24:54 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4C17F13C526B;
        Thu,  3 Apr 2014 12:24:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 3 Apr 2014 12:24:54 +0100
Received: from [192.168.154.65] (192.168.154.65) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 3 Apr
 2014 12:24:53 +0100
Message-ID: <533D4505.4050406@imgtec.com>
Date:   Thu, 3 Apr 2014 12:24:53 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: MT: proc: Add support for printing VPE and TC ids
References: <1381846382-26437-1-git-send-email-markos.chandras@imgtec.com> <20131016151007.GP1615@linux-mips.org> <533BE58C.3010201@imgtec.com> <20140403112019.GA4365@linux-mips.org>
In-Reply-To: <20140403112019.GA4365@linux-mips.org>
X-Enigmail-Version: 1.5.2
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="hMdCw455TwxN3QvUdd00d3qaw70uUaPbf"
X-Originating-IP: [192.168.154.65]
X-ESG-ENCRYPT-TAG: 45e046ea
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--hMdCw455TwxN3QvUdd00d3qaw70uUaPbf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/04/14 12:20, Ralf Baechle wrote:
> On Wed, Apr 02, 2014 at 11:25:16AM +0100, James Hogan wrote:
>=20
>> Both of these patches seem to be applied, Markos' in v3.14-rc1, and yo=
ur
>> one in mips-for-linux-next:
>>
>> $ cat /proc/cpuinfo
>> ...
>> processor               : 3
>> ...
>> core                    : 1
>> VPE                     : 1
>> VCED exceptions         : not available
>> VCEI exceptions         : not available
>> VPE                     : 1
>>
>> Maybe a revert of Markos' patch could be squashed in to your patch?
>=20
> I've reverted this in my tree now.

Thanks Ralf

Cheers
James


--hMdCw455TwxN3QvUdd00d3qaw70uUaPbf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJTPUUFAAoJEGwLaZPeOHZ62UgP/1X4ESavYtLl1mgzs8jCyZhW
0fbE/f79RKVRa+X61yskmUhdQkoH2H27zFgE63DtWKr3eXVTHnt/vXgwjRTk9Tha
MJloH7ZQb0UY66yHOIGc+5Uw5ID5Hv2Tlok10VbdVXI5F+MOq+puw1vOxbscTMUT
idumuDFdM0vqujEPac0tk175xKj0yExaxi3TlpLMs4YPrGFDj0kfhjS2JJy/SxHR
9RXhpUIi0GVUiu4LAD4otqM4sVHsZCNQiFZ/jkGPukdEB9P+zlWnhTD+I6B1/5qu
vdLbSiwgiV5uwxyNTAZBOehp9Xb12LNB/PCXqN7K09+Dn/9jwI24KRo+u9uhOSQK
zTCS+LjP8n4btmduUfUPqAABiJwzRUw9IqtJ/dXOTMyn5YHpt7dVWwPrEJlXPc11
XBDYtiu5AEmFb2ydGEte/Evn8kP60JgU1FwWAWbtz5AhI9VDSNeu991tn8qGZDXW
z0jY4VGcxALZeqs2fRCLtmN/d/jTkSFEq7GtcCP8WCeHjw89ZJ3TwEnV45hSpx1I
JHTsQd9kjJ8RmFlxtkk28FVk7tJHhHAfJWZ7UIARqoVJnowtlyYoGDELkG1T3BAq
HROA9L22apsEUeJXcz/CA64uz56kWZQFoy1BmPB5NImxUggbULKfM9rpK2D3aQOF
Rm6Rg+UI6Bn8RYJpMtyO
=kr55
-----END PGP SIGNATURE-----

--hMdCw455TwxN3QvUdd00d3qaw70uUaPbf--
