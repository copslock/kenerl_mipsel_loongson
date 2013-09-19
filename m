Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 12:32:02 +0200 (CEST)
Received: from pax.zz.de ([88.198.69.77]:52879 "EHLO pax.zz.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827366Ab3ISKb6tkfUU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Sep 2013 12:31:58 +0200
Received: by pax.zz.de (Postfix, from userid 1000)
        id 369F23CCF; Thu, 19 Sep 2013 12:31:58 +0200 (CEST)
Date:   Thu, 19 Sep 2013 12:31:58 +0200
From:   Florian Lohoff <f@zz.de>
To:     linux-mips@linux-mips.org
Subject: Fwd: Roll call for porters of architectures in sid and testing
 (Status update)
Message-ID: <20130919103158.GB7476@pax.zz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <flo@pax.zz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f@zz.de
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


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

just a heads up that Mips and Mipsel are 2 architectures in danger
of beeing dropped by Debian if no one steps up as a porter beeing
reachable for addressing architecture specific bugs.=20

No need to be DD=20

Flo

----- Forwarded message from Niels Thykier <niels@thykier.net> -----

Date: Thu, 19 Sep 2013 10:38:29 +0200
=46rom: Niels Thykier <niels@thykier.net>
To: debian-release@lists.debian.org
CC: debian-ports@lists.debian.org, debian-devel@lists.debian.org
Subject: Re: Roll call for porters of architectures in sid and testing (Sta=
tus
	update)
X-Spam-Status: No, score=3D-1.298 tagged_above=3D-5 required=3D5.5
	tests=3D[RP_MATCHES_RCVD=3D-1.298] autolearn=3Ddisabled

On 2013-09-01 09:33, Niels Thykier wrote:
> Hi,
>=20
> As we announced in [LAST-BITS], we would like to get a better idea of
> that status of the ports, to make an informed decision about which
> port can be released with jessie. One of the steps is to get an
> overview of which of the porters are (still) active for each
> port. Once the results from the role-call are in, we will request
> other information about the status of the ports. In the meantime, feel
> free to update and collect info about the ports in the Debian wiki[WIKI].
>=20
> If you are (or intend to become) an active porter for the lifetime of
> jessie, then please send a signed email explaining your involvement in
> the port to the Release Team <debian-release@lists.debian.org> before
> 1st of October 2013. Please explain the level of your involvement in
> the port.
>=20
> Feel free to use the following template as your reply:
>=20
> [...]
>=20
> Niels, on behalf of the release team
>=20
> [LAST-BITS] http://lists.debian.org/debian-devel-announce/2013/08/msg0000=
6.html
>=20
> [WIKI] https://wiki.debian.org/ArchiveQualification/Jessie
>=20


Hi all,

Here is a little status update on the mails we have received so far.
First off, thanks to all the porters who have already replied!

So far, the *no one* has stepped up to back the following architectures:

   hurd-i386
   ia64
   mips
   mipsel
   s390x

I have pinged some people and #d-hurd, so this will hopefully be amended
soon.  Remember that the *deadline is 1st of October*.

In the list above, I excluded:

  amd64 and i386: requirement for porters is waived
  s390: Being removed from testing during the Jessie cycle
        (Agreement made during the Wheezy release cycle)

The following table shows the porters for each architecture in
*unstable* that I have data on so far:

armel: Wookey (DD)
armhf: Jeremiah Foster (!DD, but NM?), Wookey (DD)
kfreebsd-amd64: Christoph Egger (DD), Axel Beckert (DD),
   Petr Salinger (!DD), Robert Millan (DD)
kfreebsd-i386: Christoph Egger (DD), Axel Beckert (DD),
   Petr Salinger (!DD), Robert Millan (DD)
powerpc: Geoff Levand (!DD), Roger Leigh (DD)
sparc: Axel Beckert (DD), Rainer Herbst (!DD)


If you are missing from this list above, then I have missed your email.
 Please follow up to this mail with a message-ID (or resend it,
whichever you prefer).

We also got a number of people interested in architectures not currently
in unstable.  These are:

  alpha: Bill MacAllister (!DD), Kieron Gillespie (!DD)
  arm64: Wookey (DD)
  parisc/hppa: Helge Deller (!DD)
  ppc64: Steven Gawroriski (!DD)
  sparc64: Steven Gawroriski (!DD), Kieron Gillespie (!DD)

This will hopefully teach me to remember to include the "in unstable"
restriction to the next "roll call".  :)  Anyhow, if you are working on
these architectures on debian-ports and saw a new name in the list
above, this might be an opportunity to recruit new people.


We also received a couple of emails from people who are not or did not
want to be porters at the moment.  However, they expressed an interest
in the architectures:

  David Kuehling: mipsel
    - debug arch-related issues
  Meelis Roos: ppc, sparc64 (parisc)
    - test and report bugs in upstream kernel
  Peter Green: armhf (possibly any-arm)
    - works on raspbian


In the template email included in the roll call, we included some tasks
that people might be doing.  These are the task people have said they
are doing for a given port.

  * test packages: armhf, kfreebsd-amd64 (x4), kfreebsd-i386 (x4),
     powerpc, sparc (x2)
  * fix toolchain issues: armhf, powerpc
  * triage arch-specific bugs: armhf, kfreebsd-amd64 (x3),
     kfreebsd-i386 (x3), powerpc, sparc (x2)
  * fix arch-related bugs: armhf, kfreebsd-amd64 (x3),
      kfreebsd-i386 (x3), powerpc
  * maintain buildds: armhf, kfreebsd-amd64, kfreebsd-i386

NB: I have manually translated some prose-text into the items above, so
something might have been lost (or gained) in that translation.

Some of the porters also added some new items.  I have included some of
these items below:

  + test d-i "when needed": powerpc (x2)
  + maintain arch-related pkgs: kfreebsd-amd64, kfreebsd-i386
  + maintain non-DSA porter box: kfreebsd-amd64
  + maintain production system of $arch: sparc/stable
  + can offer hardware access[1]: sparc (Axel Beckert)
  + eglibc issues: kfreebsd-amd64, kfreebsd-i386
  + maintain+test cross-toolchains for $arch: armel, armhf

~Niels

[1] Restrictions may apply.


--=20
To UNSUBSCRIBE, email to debian-mips-REQUEST@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.o=
rg
Archive: http://lists.debian.org/523AB805.7000305@thykier.net

----- End forwarded message -----

--=20
Florian Lohoff                                                 f@zz.de

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBUjrSnZDdQSDLCfIvAQiwjg//SeReingYow9p/MbFNKCwvoovwkd+njyA
2kTC/7JCA7MwIJx2ETHovOMqShbLAruloBAW2tpHLyG1F92nYuC5P59P+J/370G5
/USbwe0ZAl79u5tzgA7rW1OJsurpozPkHL4uM6c8LbCOQudwtWhql2JPF02ir6IQ
/ujiJllDzgc1raEdgl61lWUongGXKSUNnnVpfXoBtz5zDRzdVkZ0HB2cDIULX55b
g2kCcDWlkbPWIn/btrn0KySznnL/8WjCn8Ta/LKAHU8V47dmDZBjoBcyLGJAubFm
u0HSvVUUwGSF0aXAVr3GKpLnsLboIfH5HuPsnvdnOaVtJTU54cFZWkMQzejYY8Tv
bUb+ZK3LXh0ImLFZ4gZJjEBfZJUXTWvA8QgulEVBxhaHDvgbrd1TcEqQdNWUNekA
sryjmdzTEWsqyMd7+rrLn7TD5HP3JtQnS+ARVqKQ0zx5n52ERA9N9ItqT7Vb5V3M
uEoA+LwXdOPJwjY2VQcrG0r20/I6jNnWjKK28md5YS/wavizdCSIlARzO5J+mwtf
ZqYSBgHcZIr2mXQKK63ORwKX1HUfY9S15g/jZ+2F8YVFOP4CQ8/+COoZsnHPcw+J
t4mvecSL687JnwTuZOEpUYjxzr2IlxXF39UPja0IsH6B4KzZxuzKLtN+CxfWgYvD
RNjQKFegzlM=
=Amd6
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
