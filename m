Received:  by oss.sgi.com id <S42277AbQFTJId>;
	Tue, 20 Jun 2000 02:08:33 -0700
Received: from belgarath.esg-guetersloh.mediapoint.de ([193.189.251.50]:60749
        "HELO belgarath.esg-guetersloh.mediapoint.de") by oss.sgi.com
	with SMTP id <S42229AbQFTJIS>; Tue, 20 Jun 2000 02:08:18 -0700
Received: by belgarath.esg-guetersloh.mediapoint.de (Postfix, from userid 1000)
	id 0C86B51317; Tue, 20 Jun 2000 11:08:21 +0200 (CEST)
Date:   Tue, 20 Jun 2000 11:08:21 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Cc:     engel@unix-ag.org
Subject: Kernel image is not executable?
Message-ID: <20000620110821.D32072@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com, engel@unix-ag.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
X-Mailer: Mutt 1.0i
X-Operating-System: Linux belgarath.esg-guetersloh.mediapoint.de 2.0.35
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi!

I've recovered so far from my developement machine's hardware crash
and can now start to tftp the kernel image:
>> unsetenv netaddr
>> boot bootp()vmlinuz.ip12
167120+81888+319472 entry: 0x80700c90
Setting $netaddr to 192.168.1.3 (from server )
bootp()vmlinuz.ip12: is not an executable file
Can't load bootp()vmlinuz.ip12

Only the first 2x512 Bytes are transferred.

[root@air:/tftpboot] #> uname -a
Linux air 2.4.0-test1-ac18 #2 Thu Jun 15 07:58:27 CEST 2000 alpha unknown
# This is an up-to-date Potato system
[root@air:/tftpboot] #> file *
unix:         MIPSEB COFF executable (impure) not stripped - version 3.18
vmlinuz.ip12: MIPSEB COFF executable stripped - version 0.0

"unix" is my IRIX5.2 kernel. Just as a guess, I changes the version
stamp to reflect 3.18 -- no success. I fixed the TEXT entry in
=2E/linux/arch/mips/Makefile to the above value as well, but what
does make a tftp'ed file executable in Indigo's eyes?

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEAREBAAYFAjlPNIUACgkQHb1edYOZ4btH8gCgiMLlasG3G4FlT57FTW2F4QoE
LqYAn0Si59mGd/TEIDgo8WpS32G1Ify2
=uw1z
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
