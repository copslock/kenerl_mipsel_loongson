Received:  by oss.sgi.com id <S553681AbRCHH7d>;
	Wed, 7 Mar 2001 23:59:33 -0800
Received: from mailout4-0.nyroc.rr.com ([24.92.226.120]:893 "EHLO
        mailout4-0.nyroc.rr.com") by oss.sgi.com with ESMTP
	id <S553648AbRCHH7R>; Wed, 7 Mar 2001 23:59:17 -0800
Received: from hork (roc-24-161-76-252.rochester.rr.com [24.161.76.252])
	by mailout4-0.nyroc.rr.com (8.11.2/RoadRunner 1.03) with ESMTP id f287tDb17402;
	Thu, 8 Mar 2001 02:55:34 -0500 (EST)
Received: from molotov by hork with local (Exim 3.22 #1 (Debian))
	id 14avJ2-0003Zg-00; Thu, 08 Mar 2001 02:57:52 -0500
Date:   Thu, 8 Mar 2001 02:57:51 -0500
To:     nick@snowman.net
Cc:     linux-mips@oss.sgi.com
Subject: Re: Problem makeing an O2 run bootp
Message-ID: <20010308025751.G5830@hork>
Mail-Followup-To: nick@snowman.net, linux-mips@oss.sgi.com
References: <20010306135856.E1184@bacchus.dhis.org> <Pine.LNX.4.21.0103062231010.23542-100000@ns>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0103062231010.23542-100000@ns>; from nick@snowman.net on Tue, Mar 06, 2001 at 10:36:45PM -0500
From:   Chris Ruvolo <csr6702@grace.rit.edu>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2001 at 10:36:45PM -0500, nick@snowman.net wrote:
> I've got an o2 that I'm trying to make netboot, and it seems to work,
> however the o2 never acks the tftp packets.  The tcpdump is attached.  If
> anyone has suggestions/ideas I'd love to hear them.  I booted the o2 and
> ran "bootp():" from the arc prompt.

I had the same problem with my Indy.  I think this is in the HOWTO now, but
in case you missed it..  If you are running your tftpd on Linux >=3D 2.3.x=
=20

echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc

Worked for me.

-Chris

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6pzt/KO6EG1hc77ERAlZjAJ4+vNnSmpU7qNKbatB8quD403xqmwCg4IBE
mcSkUMYaY9GfYfWRQJHJ4lE=
=npxq
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
