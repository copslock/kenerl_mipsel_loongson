Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g619eRnC019504
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 02:40:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g619eRga019503
	for linux-mips-outgoing; Mon, 1 Jul 2002 02:40:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g619eBnC019479;
	Mon, 1 Jul 2002 02:40:11 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 0752013373; Mon,  1 Jul 2002 11:43:59 +0200 (CEST)
Date: Mon, 1 Jul 2002 11:43:59 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1
Message-ID: <20020701094359.GP17216@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com,
	Ralf Baechle <ralf@oss.sgi.com>
References: <20020629220513.GC17216@lug-owl.de> <20020630174717.GI17216@lug-owl.de> <20020701091321.GO17216@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/F2XdnRjS8y2HUtp"
Content-Disposition: inline
In-Reply-To: <20020701091321.GO17216@lug-owl.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--/F2XdnRjS8y2HUtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-07-01 11:13:22 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de>
wrote in message <20020701091321.GO17216@lug-owl.de>:
> On Sun, 2002-06-30 19:47:17 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de>
> wrote in message <20020630174717.GI17216@lug-owl.de>:
> > On Sun, 2002-06-30 00:05:13 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de>
> > wrote in message <20020629220513.GC17216@lug-owl.de>:
> > [...]
> > >   10:   bc600060  0xbc600060
> > > Code;  88016ce0 <r4k_flush_cache_range_d32i32+e4/16c>
> > >   14:   bc600080  0xbc600080
> >=20
> > Well, I've bulid the same kernel with CONFIG_MIPS_UNCACHED and the box
> > is running^Wsnailing fine with it. I'm experiencing a little peformance
> > drop (100 BogoMips -> 2.79 BogoMips), but it comes up in finite time:-)
>=20
> I've got some mail that support for my early R4600 (well, the bug fixes
> for it...) got removed some time ago. I've looked at the diff of r1.3
> (2.4.16) and r1.3.2.3 (2.4.19-rc1) and it seems that mostly calls to
> __save_and_cli() and __restore_flags() got removed. Reading <asm/war.h>,
> it really seems that this is causing my problem.
>=20
> Ralf, would you accept a patch adding these lines again surrounded by
> #ifdef CONFIG_CPU_R4X00 ... #endif /* CONFIG_CPU_R4X00 */? The current
> state however isn't that fine: running uncached is no fun:-(

Okay, stupid idea. All these flush functions seem to be never called in
parallel or recursive, so if might be possible to have a global flags
variable and instead of always calling __save..() and __restore..(),
we bulid a pair of inline functions doing this. This wouldn't give
any penalty for !CONFIG_CPU_R4X00 and doesn't obscure the code so much
as all those #ifdef and #endif's would do... I'll test my suggestion
as fast as I reach my Indy again (is powered down at home...).

#ifdef CONFIG_CPU_R4X00
long buggy_r4600_flags;
#endif /* CONFIG_CPU_R4X00 */


static inline void
r4600_bug_start()
{
#ifdef CONFIG_CPU_R4x00
	__save_and_cli(buggy_r4600_flags);
#endif /* CONFIG_CPU_R4x00 */
	return;
}

static inline void
r4600_bug_finish()
{
#ifdef CONFIG_CPU_R4x00
	__restore_flags(buggy_r4600_flags);
#endif /* CONFIG_CPU_R4x00 */
	return;
}

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--/F2XdnRjS8y2HUtp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9ICReHb1edYOZ4bsRAg4SAJ9qm8iPV6A0ylxrhn9AyHxVKCSPhACfaZBb
ECRyU7vndNJlT8On8hDqxy8=
=B0TB
-----END PGP SIGNATURE-----

--/F2XdnRjS8y2HUtp--
