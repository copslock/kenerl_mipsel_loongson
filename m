Received:  by oss.sgi.com id <S42276AbQE3Wz6>;
	Tue, 30 May 2000 15:55:58 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:14086 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42263AbQE3Wzu>;
	Tue, 30 May 2000 15:55:50 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA06910; Tue, 30 May 2000 15:38:41 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA00337; Tue, 30 May 2000 15:41:49 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA08346
	for linux-list;
	Tue, 30 May 2000 15:23:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA08409
	for <linux@engr.sgi.com>;
	Tue, 30 May 2000 15:23:41 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: from belgarath.esg-guetersloh.mediapoint.de (belgarath.esg-guetersloh.mediapoint.de [193.189.251.50]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04077
	for <linux@engr.sgi.com>; Tue, 30 May 2000 15:11:16 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: by belgarath.esg-guetersloh.mediapoint.de (Postfix, from userid 1000)
	id 456E851344; Wed, 31 May 2000 00:11:13 +0200 (CEST)
Date:   Wed, 31 May 2000 00:11:12 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux@cthulhu.engr.sgi.com
Cc:     Chris Ruvolo <csr6702@grace.rit.edu>
Subject: Re: Problems booting Indigo...
Message-ID: <20000531001112.A31916@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux@engr.sgi.com, Chris Ruvolo <csr6702@grace.rit.edu>
References: <20000530032958.D15930@lug-owl.de> <Pine.LNX.3.95.1000530093412.580B-100000@whale.dutch.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.3.95.1000530093412.580B-100000@whale.dutch.mountain>; from R.vandenBerg@inter.NL.net on Tue, May 30, 2000 at 09:46:24AM +0200
X-Operating-System: Linux belgarath.esg-guetersloh.mediapoint.de 2.0.35
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2000 at 09:46:24AM +0200, Richard van den Berg wrote:
> On Tue, 30 May 2000, Jan-Benedict Glaw wrote:
>=20
> > >> bootp()parkautomat:/tftpboot/vmlinux.ip12
> > No server for parkautomat:/tftpboot/vmlinux.ip12
>=20
> Just after doing this, does the machine show in the server arp table with
> `arp -a`? If so forget this mail, if not issue (of course with the right
> addresses) `arp -s 192.168.1.15 08:00:2B:2D:90:C0`

Good hint. After playing some (long...) more with different combinations
of any piece of software installed here, I'm currently making steps=20
in the very right direction:

Here my uHowTo:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Server Side:
	- Kernel here is 2.4.0-test1-ac4, so arp(8) no longer knows "pub":

	  [root@parkautomat:/root] #> arp -s 192.168.1.3 08:00:69:06:BA:2E

	  192.168.1.3 is Indigo's IP address, 08:00:69:06:BA:2E is its
	  hardware address (one can find it by giving the "eaddr" command
	  at serial console)
	- ISC dhcpd from .deb (2.0-3) with very short config:
---------------->8=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
option domain-name "lug-owl.de";
option domain-name-servers 192.168.1.1;
option subnet-mask 255.255.255.0;
default-lease-time 600;
max-lease-time 7200;
subnet 192.168.1.0 netmask 255.255.255.0 {
}
host indigo {
  hardware ethernet 08:00:69:06:ba:2e;
  fixed-address 192.168.1.3;
  filename "/tftpboot/vmlinux.ip12";
  option tftp-server-name "192.168.1.4";
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<-------=
-----------------
	- in.tftpd installed (0.10-1)

Client Side:
	- You have to *remove* the netaddr variable:
	  >> unsetenv netaddr
	- Then try to boot:
	  >> boot bootp()/tftpboot/vmlinux.ip12

Effect: The Indigo gets its config, but unfortunately it seems that
incoming tftp UDP packets are not accepted. This might be because
the originating port is !=3D 69 (which is tftp):

[root@parkautomat:/root] #> tcpdump -i eth0 -N not port ssh
tcpdump: listening on eth0
22:26:27.205401 0.0.0.0.bootpc > 255.255.255.255.bootps: xid:0xa223 secs:5 =
[|bootp]
22:26:27.376706 parkautomat.bootps > 255.255.255.255.bootpc: xid:0xa223 sec=
s:5 Y:indigo S:parkautomat [|bootp] [tos 0x10]
22:26:27.377730 arp who-has indigo tell indigo
22:26:27.631528 parkautomat.bootps > indigo.bootpc: xid:0xa223 secs:5 Y:ind=
igo S:parkautomat [|bootp] (DF)
22:26:27.638649 arp who-has parkautomat tell indigo
22:26:27.638814 arp reply parkautomat is-at 0:e0:98:16:22:80
22:26:27.639345 indigo.8740 > parkautomat.tftp: 35 RRQ "/tftpboot/vmlinux.i=
p12"
22:26:27.922485 parkautomat.1028 > indigo.8740: udp 516 (DF)
22:26:32.915339 parkautomat.1028 > indigo.8740: udp 516 (DF)
22:26:37.915225 parkautomat.1028 > indigo.8740: udp 516 (DF)
22:26:42.915152 parkautomat.1028 > indigo.8740: udp 516 (DF)
22:26:47.915233 parkautomat.1028 > indigo.8740: udp 516 (DF)
22:26:57.054788 indigo.8741 > parkautomat.tftp: 35 RRQ "/tftpboot/vmlinux.i=
p12"
22:26:57.125679 parkautomat.1028 > indigo.8741: udp 516 (DF)
22:27:02.125199 parkautomat.1028 > indigo.8741: udp 516 (DF)
22:27:07.125235 parkautomat.1028 > indigo.8741: udp 516 (DF)
22:27:12.125247 parkautomat.1028 > indigo.8741: udp 516 (DF)
22:27:17.125586 parkautomat.1028 > indigo.8741: udp 516 (DF)
22:27:27.054101 indigo.8742 > parkautomat.tftp: 35 RRQ "/tftpboot/vmlinux.i=
p12"
22:27:27.108923 parkautomat.1028 > indigo.8742: udp 516 (DF)
22:27:32.105253 parkautomat.1028 > indigo.8742: udp 516 (DF)
22:27:37.105143 parkautomat.1028 > indigo.8742: udp 516 (DF)
22:27:42.105251 parkautomat.1028 > indigo.8742: udp 516 (DF)
22:27:47.105618 parkautomat.1028 > indigo.8742: udp 516 (DF)
22:27:57.053731 indigo.8743 > parkautomat.tftp: 35 RRQ "/tftpboot/vmlinux.i=
p12"
22:27:57.125781 parkautomat.1028 > indigo.8743: udp 516 (DF)
22:28:02.125304 parkautomat.1028 > indigo.8743: udp 516 (DF)
22:28:07.125518 parkautomat.1028 > indigo.8743: udp 516 (DF)
22:28:12.125208 parkautomat.1028 > indigo.8743: udp 516 (DF)
22:28:17.125177 parkautomat.1028 > indigo.8743: udp 516 (DF)

Now the final question: How can I make in.tftpd to answer *from* port 69?

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I think this is the problem... Who can help???
=09
MfG, JBG
PS: Sorry for this looong mail;)

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEAREBAAYFAjk0PIAACgkQHb1edYOZ4bslEQCcD/uf2Kjl7r2nFnNfUGar4QuG
aEIAn1HRPi1ZhQRL+SbgCt++0kgLsZxM
=qMCv
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
