Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBBGdgT29394
	for linux-mips-outgoing; Tue, 11 Dec 2001 08:39:42 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBBGdVo29390
	for <linux-mips@oss.sgi.com>; Tue, 11 Dec 2001 08:39:31 -0800
Received: from GS256.SP.CS.CMU.EDU by ux3.sp.cs.cmu.edu id aa07164;
          11 Dec 2001 10:39 EST
Subject: RE: no kernel prompt
From: Justin Carlson <justincarlson@cmu.edu>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <25369470B6F0D41194820002B328BDD2195AD9@ATLOPS>
References: <25369470B6F0D41194820002B328BDD2195AD9@ATLOPS>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-oVNvjeFXAym9xp/m5Ksq"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 11 Dec 2001 10:39:02 -0500
Message-Id: <1008085142.1022.21.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-oVNvjeFXAym9xp/m5Ksq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2001-12-10 at 23:36, Marc Karasek wrote:
> I ran across something like this before.  Whatever you are using for
> yourinit is it dynamically linked?  If so try to statically link it.  I w=
as
> seeing something similar happen and it was because of a problem in the
> dynamic linking.  It was failing to find the proper lib to continue, but
> could not dump any output to the terminal to tell me.  It was a bear to f=
ind
> ... :-)=20
>=20
> -----Original Message-----
> From: balaji.ramalingam@philips.com
> To: linux-mips@oss.sgi.com
> Sent: 12/10/01 10:59 PM
> Subject: no kernel prompt
>=20
>=20
>=20
> Hello guys,
>=20
> I was able to sort out the console issue and know I think the kernel is
> able to open /dev/console and I 'm not getting that error message from
> the kernel saying
> unable to open console blau blau..
>=20
> I also inserted some printk's in the init/main.c before and after the
> kernel executing /sbin/init.
> So I thing the kernel can execute the sbin/init. I replace the init fiel
> with a simple
> shell script which echo the "hello world" message.
>=20

I'm I reading this right, in that you've got something like this:

...
   printk("Going to exec init\n");
   execve("/sbin/init");
   printk("After exec\n");
...

And you're seeing both printk's come out?  Or are you seeing just the=20
first one?  If you're seeing both, then the exec is failing.  But=20
you should see another message about failing to exec init if that was
the case.

Also, something I've been bitten by; if you replace /sbin/init with
something that outputs and exits, the kernel will panic when init
exits, and so your output can be lost, depending on the driver=20
used for the output. =20

Try something like this:

#include <stdio.h>
#include <stdlib.h>

int main()
{
	char msg[] =3D "Hello, world!\n";
	write(1, msg, sizeof(msg));
	while(1) {}
}

this avoids having to load all of a shell interpreter just to do some=20
output.  Link the binary statically (with -static in gcc) and use
it as /sbin/init. =20

If you still don't see output, you'll have to start tracing your way
into the exec path to see where things are failing.  Look at
do_execve() in fs/exec.c, and fs/binfmt_elf.c (assuming your=20
init is in elf format).


> Is there a simple test which I can do to confirm that I dont have any
> issue with
> the console or with my ramdisk image?

The fact that you are successfully mounting a root filesystem seems to
indicate that your ramdisk is OK (at least, it's a valid filesystem).=20
There's nothing that's come out of the console yet, though.

-Justin


--=-oVNvjeFXAym9xp/m5Ksq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8FiiW47Lg4cGgb74RAurOAJ9rom11qWh3G7B66GxUUQ0eBFLfcgCgpZoZ
zwvFBJmgi8i0jcEBh/DWIn8=
=fr4F
-----END PGP SIGNATURE-----

--=-oVNvjeFXAym9xp/m5Ksq--
