Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76ABhq01359
	for linux-mips-outgoing; Mon, 6 Aug 2001 03:11:43 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76ABMV01336;
	Mon, 6 Aug 2001 03:11:22 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 421571E532; Mon,  6 Aug 2001 12:11:16 +0200 (MEST)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
Mail-Copies-To: never
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "H . J . Lu" <hjl@lucon.org>, Eric Christopher <echristo@redhat.com>,
   gcc@gcc.gnu.org, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
References: <20010805094806.A3146@lucon.org>
	<20010806115913.B17179@bacchus.dhis.org>
From: Andreas Jaeger <aj@suse.de>
Date: Mon, 06 Aug 2001 12:10:59 +0200
In-Reply-To: <20010806115913.B17179@bacchus.dhis.org> (Ralf Baechle's
 message of "Mon, 6 Aug 2001 11:59:13 +0200")
Message-ID: <hoofptjy6k.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

--=-=-=
Content-Transfer-Encoding: quoted-printable

Ralf Baechle <ralf@oss.sgi.com> writes:

> On Sun, Aug 05, 2001 at 09:48:06AM -0700, H . J . Lu wrote:
>
>> I am working with Eric to clean up the Linux/mips configuration in
>> gcc 3.x. I'd like to change WCHAR_TYPE from "long int" to "int". They
>> are the same on Linux/mips. There won't be any run-time problems. I am
>> wondering if there are any compatibility problems at the compile time
>> at the source and binary level. For one thing, __WCHAR_TYPE__ will be
>> changed from "long int" to "int". The only thing I can think of is
>> the C++ libraries. But gcc 3.x doesn't work on Linux/mips. The one
>> I am working on will be the first gcc 3.x for Linux/mips. So there
>> shouldn't be any problems. Am I right?
>
> The MIPS ABI defines wchar_t to long.  So please go ahead and make the
> change.

I'm confused.  The ABI defines it to be long - and he should change it
nevertheless?

Andreas
=2D-=20
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7bm0zOJpWPMJyoSYRArSgAJ9Ct50CFo0gDljzP3M9kE0sdN+70QCeN6n9
WlALwFwEUpNW6OVo6ZPpa6k=
=uKbi
-----END PGP SIGNATURE-----
--=-=-=--
