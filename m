Received:  by oss.sgi.com id <S42276AbQE3BQq>;
	Mon, 29 May 2000 18:16:46 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:16742 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42271AbQE3BQa>;
	Mon, 29 May 2000 18:16:30 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA05954; Mon, 29 May 2000 18:50:15 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA57111
	for linux-list;
	Mon, 29 May 2000 18:46:27 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA89518
	for <linux@engr.sgi.com>;
	Mon, 29 May 2000 18:46:24 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: from belgarath.esg-guetersloh.mediapoint.de (belgarath.esg-guetersloh.mediapoint.de [193.189.251.50]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA05951
	for <linux@engr.sgi.com>; Mon, 29 May 2000 18:29:59 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: by belgarath.esg-guetersloh.mediapoint.de (Postfix, from userid 1000)
	id 3610B512FC; Tue, 30 May 2000 03:29:58 +0200 (CEST)
Date:   Tue, 30 May 2000 03:29:58 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux@cthulhu.engr.sgi.com
Subject: Problems booting Indigo...
Message-ID: <20000530032958.D15930@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux@engr.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
X-Mailer: Mutt 1.0i
X-Operating-System: Linux belgarath.esg-guetersloh.mediapoint.de 2.0.35 
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi!

I've now build a kernel which I would like to test on my Indigo;) The
problem is that I can't load it;( I tried bootpd as well as ISC dhcpd.
The result is actually just the same:

>> bootp()parkautomat:/tftpboot/vmlinux.ip12                               =
    =20
No server for parkautomat:/tftpboot/vmlinux.ip12                           =
    =20

I tried to do with "parkautomat:", with IPs ("192.168.1.4:"), I leaved
the server totally off the string, I used bootpd and dhcps with rfc1048,
with cmu (bootpd), I checked the "SQE dip switch" at the AUI->10baseT
transceiver. setenv/unsetenv netaddr didn't make a difference, too...
I checked dozends of combinations, but there's no server seen by the
Indigo;(

/etc/bootptab:
ip12:\
        :ht=3Dethernet:\
        :ha=3D08006906ba2e:\
        :bs=3Dauto:\
        :vm=3Dcmu:\
        :ip=3D192.168.1.3:\
        :sm=3D255.255.255.0:\
        :sa=3D192.168.1.4:\
        :bf=3Dvmlinux.ip12:\
        :to=3D7200:
       =20
tcpdump shows:

[root@parkautomat:/root] #> tcpdump -i eth0 -n
tcpdump: listening on eth0
01:46:03.979150 arp who-has 192.168.1.3 tell 192.168.1.3
01:46:03.979864 192.168.1.3.68 > 255.255.255.255.67: xid:0xa0d5 secs:5 C:19=
2.168.1.3 [|bootp]
01:46:03.982352 192.168.1.4.67 > 255.255.255.255.68: xid:0xa0d5 secs:5 C:19=
2.168.1.3 Y:192.168.1.3 S:192.168.1.4 [|bootp] [tos 0x10]
01:46:08.408974 192.168.1.3.68 > 255.255.255.255.67: xid:0xa0d5 secs:10 C:1=
92.168.1.3 [|bootp]
01:46:08.411526 192.168.1.4.67 > 255.255.255.255.68: xid:0xa0d5 secs:10 C:1=
92.168.1.3 Y:192.168.1.3 S:192.168.1.4 [|bootp] [tos 0x10]
01:46:13.408851 192.168.1.3.68 > 255.255.255.255.67: xid:0xa0d5 secs:15 C:1=
92.168.1.3 [|bootp]
01:46:13.411166 192.168.1.4.67 > 255.255.255.255.68: xid:0xa0d5 secs:15 C:1=
92.168.1.3 Y:192.168.1.3 S:192.168.1.4 [|bootp] [tos 0x10]
01:46:18.408664 192.168.1.3.68 > 255.255.255.255.67: xid:0xa0d5 secs:20 C:1=
92.168.1.3 [|bootp]
01:46:18.411001 192.168.1.4.67 > 255.255.255.255.68: xid:0xa0d5 secs:20 C:1=
92.168.1.3 Y:192.168.1.3 S:192.168.1.4 [|bootp] [tos 0x10]

So there are four requests, four replys, but none of them seems to be
seen;( Can anybody tell me how to boot the kernel? The "Diskless
Workstation Administration Guide" didn't help a lot... Maybe I can
(if nothing else helps...) boot the kernel through the tape? If so,
how di I have to put the kernel onto the tape? How to load it off?

MfG, JBG
PS: Hacking the kernel was done in one evening, trying to boot it costed
    dome days...

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEAREBAAYFAjkzGZUACgkQHb1edYOZ4buw2ACdEdTvrmfoTFi+uacc96iG2IzK
EiwAoJB/tQniMDe5LziLZU5mW8nrixc2
=nuwS
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
