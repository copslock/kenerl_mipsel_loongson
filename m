Return-Path: <SRS0=1tgX=ZI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDF1C43141
	for <linux-mips@archiver.kernel.org>; Sat, 16 Nov 2019 18:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3A421925
	for <linux-mips@archiver.kernel.org>; Sat, 16 Nov 2019 18:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfKPSKK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 16 Nov 2019 13:10:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:49284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727437AbfKPSKK (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 16 Nov 2019 13:10:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECC11B13A;
        Sat, 16 Nov 2019 18:10:02 +0000 (UTC)
Date:   Sun, 17 Nov 2019 05:09:34 +1100
From:   Aleksa Sarai <asarai@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dev@opencontainers.org, containers@lists.linux-foundation.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v16 02/12] namei: allow nd_jump_link() to produce errors
Message-ID: <20191116180934.fajrkc4jqcewiuqd@yavin.dot.cyphar.com>
References: <20191116002802.6663-1-cyphar@cyphar.com>
 <20191116002802.6663-3-cyphar@cyphar.com>
 <20191116003702.GX26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ushqsy2n2ywnjdre"
Content-Disposition: inline
In-Reply-To: <20191116003702.GX26530@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


--ushqsy2n2ywnjdre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-16, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, Nov 16, 2019 at 11:27:52AM +1100, Aleksa Sarai wrote:
> > +	error =3D nd_jump_link(&path);
> > +	if (error)
> > +		path_put(&path);
>=20
> > +	error =3D nd_jump_link(&ns_path);
> > +	if (error)
> > +		path_put(&ns_path);
>=20
> > +	error =3D nd_jump_link(&path);
> > +	if (error)
> > +		path_put(&path);
>=20
> 3 calls.  Exact same boilerplate in each to handle a failure case.
> Which spells "wrong calling conventions"; it's absolutely clear
> that we want that path_put() inside nd_jump_link().
>=20
> The rule should be this: reference that used to be held in
> *path is consumed in any case.  On success it goes into
> nd->path, on error it's just dropped, but in any case, the
> caller has the same refcounting environment to deal with.
>=20
> If you need the same boilerplate cleanup on failure again and again,
> the calling conventions are wrong and need to be fixed.

Will do.

> And I'm not sure that int is the right return type here, to be honest.
> void * might be better - return ERR_PTR() or NULL, so that the value
> could be used as return value of ->get_link() that calls that thing.

I don't agree, given that the few callers of ns_get_path() are
inconsistent with regards to whether they should use IS_ERR() or check
for NULL, not to mention that "void *error" reads to me as being very
odd given how common "int error" is throughout the kernel. There's also
the "error =3D=3D ERR_PTR(-EAGAIN)" checks which also read as being quite
odd too.

But the main motivating factor for changing it was that the one use
where "void *" is useful (proc_ns_get_link) becomes needlessly ugly
because of the "nd_jump_link() can return errors" change:

	error =3D ERR_PTR(nd_jump_link(&ns_path));

Or probably (if you don't want to rely on ERR_PTR(0) =3D=3D NULL):

	int err =3D nd_jump_link(&ns_path);
	if (err)
		error =3D ERR_PTR(err);

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ushqsy2n2ywnjdre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXdA7WwAKCRCdlLljIbnQ
EkhIAQCTW+ppymqPGqw4uOB2Z70GQdn52zl46zQ6xxp5L3kEHQD9FZ2+HHtYsZC+
LGfFupqoyojLXID+lx72AXf4CJ7KLw4=
=aGSY
-----END PGP SIGNATURE-----

--ushqsy2n2ywnjdre--
