Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OBJB206306
	for linux-mips-outgoing; Wed, 24 Oct 2001 04:19:11 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OBJ4D06296
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 04:19:04 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A973E80F; Wed, 24 Oct 2001 13:19:02 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 17D10472E; Wed, 24 Oct 2001 13:16:12 +0200 (CEST)
Date: Wed, 24 Oct 2001 13:16:11 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Moving kernel_entry to LOADADDR
Message-ID: <20011024131611.C19143@paradigm.rfc822.org>
References: <3BCF7AD2.2000000@esstech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <3BCF7AD2.2000000@esstech.com>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2001 at 07:58:58PM -0500, Gerald Champagne wrote:
> I'm planning to work with a very minimal boot loader, and I'd like
> to hard-code a jump to kernel_entry in my boot loader.  I got tired
> of having kernel_entry moving around, so I just moved it to the top
> of head.S, just afte the ".fill 0x280".  That places kernel_entry at
> the same place every time.  It's always at LOADADDR+0x280.

Dont do this - Its easy to decode the elf stuff:

Basically this is the code needed to relocate the elf chunks
and return the entry point. I might have corrupted it a bit due to stripping
unneeded bits but you will get the point. This code even clears bss
chunk which the kernel will do itself again.


	Elf32_Ehdr	*fhdr =3D fb;
	Elf32_Shdr	*shdr;=09
	int		i;

	if (fhdr->e_machine !=3D EM_MIPS) {
		printf("No Mips ELF\n");
		return(0);=09
	}

	fhdr=3D(void *) KSEG1ADDR(fb);

	shdr=3Dfb + fhdr->e_shoff;

	for(i=3D0;i<fhdr->e_shnum;i++,shdr++) {

		if (shdr->sh_size <=3D 0)=20
			continue;

		if (shdr->sh_type =3D=3D SHT_PROGBITS) {
			memcpy((void *) KSEG1ADDR(shdr->sh_addr),
				KSEG1ADDR(fb + shdr->sh_offset),
				shdr->sh_size);
		} else if (shdr->sh_type =3D=3D SHT_NOBITS) {
			memset((void *) KSEG1ADDR(shdr->sh_addr), 0x0, shdr->sh_size);
		}
	}
	return((void *) fhdr->e_entry);

--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE71qL7Uaz2rXW+gJcRAt2VAJ4i2L8QBekR+xJwBViSE2uswKCVygCeLLgC
74R1ya5zrWR1Wf/2AUp0ApA=
=zby9
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
