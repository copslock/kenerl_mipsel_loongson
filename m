Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jun 2014 22:01:52 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53364 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822099AbaFOUBrhjg9d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Jun 2014 22:01:47 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249])
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1WwGcZ-0000ym-5y; Sun, 15 Jun 2014 21:01:43 +0100
Received: from ben by deadeye.wl.decadent.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <ben@decadent.org.uk>)
        id 1WwGcX-0006dT-2T; Sun, 15 Jun 2014 21:01:41 +0100
Message-ID: <1402862492.7797.64.camel@deadeye.wl.decadent.org.uk>
Subject: Re: Bug#751417: linux-image-3.2.0-4-5kc-malta: no SIGKILL after
 prctl(PR_SET_SECCOMP, 1, ...) on MIPS
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg KH <greg@kroah.com>
Cc:     stable <stable@vger.kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, 751417@bugs.debian.org,
        team@security.debian.org, Plamen Alexandrov <plamen@aomeda.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Date:   Sun, 15 Jun 2014 21:01:32 +0100
In-Reply-To: <20140612215947.GA8176@kroah.com>
References: <20140612161903.32229.20589.reportbug@debian-mips."">
         <1402601767.31756.38.camel@deadeye.wl.decadent.org.uk>
         <1402604501.31756.50.camel@deadeye.wl.decadent.org.uk>
         <20140612210323.GA30046@kroah.com> <20140612210531.GB30046@kroah.com>
         <1402607459.31756.58.camel@deadeye.wl.decadent.org.uk>
         <20140612215947.GA8176@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-kUReUyIZL4/N0J2Lz4sh"
X-Mailer: Evolution 3.12.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-kUReUyIZL4/N0J2Lz4sh
Content-Type: multipart/mixed; boundary="=-dIs/NK+4wLBmWjfb5Lno"


--=-dIs/NK+4wLBmWjfb5Lno
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-06-12 at 14:59 -0700, Greg KH wrote:
> On Thu, Jun 12, 2014 at 10:10:59PM +0100, Ben Hutchings wrote:
> > On Thu, 2014-06-12 at 14:05 -0700, Greg KH wrote:
> > > On Thu, Jun 12, 2014 at 02:03:23PM -0700, Greg KH wrote:
> > > > On Thu, Jun 12, 2014 at 09:21:41PM +0100, Ben Hutchings wrote:
> > > > > On Thu, 2014-06-12 at 20:36 +0100, Ben Hutchings wrote:
> > > > > > Control: tag -1 security upstream patch moreinfo
> > > > > > Control: severity -1 grave
> > > > > > Control: found -1 3.14.5-1
> > > > >=20
> > > > > Aurelien Jarno pointed out this appears to be fixed upstream in 3=
.15:
> > > > >=20
> > > > > commit 137f7df8cead00688524c82360930845396b8a21
> > > > > Author: Markos Chandras <markos.chandras@imgtec.com>
> > > > > Date:   Wed Jan 22 14:40:00 2014 +0000
> > > > >=20
> > > > >     MIPS: asm: thread_info: Add _TIF_SECCOMP flag
> > > > >=20
> > > > > It looks like this can be cherry-picked cleanly onto stable branc=
hes for
> > > > > 3.13 and 3.14.  For 3.11 and 3.12, it will need trivial adjustmen=
t.
> > > > >=20
> > > > > For branches older than 3.11, this needs to be cherry-picked firs=
t:
> > > > >=20
> > > > > commit e7f3b48af7be9f8007a224663a5b91340626fed5
> > > > > Author: Ralf Baechle <ralf@linux-mips.org>
> > > > > Date:   Wed May 29 01:02:18 2013 +0200
> > > > >=20
> > > > >     MIPS: Cleanup flags in syscall flags handlers.
> > > >=20
> > > > It also needs parts of 1d7bf993e0731b4ac790667c196b2a2d787f95c3 (MI=
PS:
> > > > ftrace: Add support for syscall tracepoints.) to apply properly to =
stuff
> > > > older than 3.11.  But, I'm not so sure that is good to apply as tha=
t is
> > > > a whole new feature.
> > > >=20
> > > > So I think I'll just do this "by hand" to get it to work properly..=
.
> > >=20
> > > Wait, no, SECCOMP for MIPS isn't even in 3.10 or older kernels, so wh=
y
> > > is this a 3.2 issue?  Did you add it there to your kernel for some
> > > reason?
> >=20
> > Seccomp mode 2 (i.e. filtering with BPF) was only just implenented for
> > MIPS in 3.15.  Mode 1 (fixed set of syscalls) was implemented long ago.
>=20
> Really?  I don't see _TIF_SECCOMP in the mips asm files in 3.10.  I
> don't feel comfortable backporting it to 3.10 or 3.4, are you going to
> do that for 3.2?

I'm attaching the backport to 3.2 which I've now been able to test.  It
appears to apply cleanly to 3.4 and 3.10 as well.  ("MIPS: Cleanup flags
in syscall flags handlers." applies to all branches with some fuzz.)

> > (If prctl(PR_SET_SECCOMP) could return success when CONFIG_SECCOMP is
> > not enabled, that would be even worse!)
>=20
> True, but this seems to have always been broken, right?  :)

Yes, so far as I can see.

Ben.

--=20
Ben Hutchings
Tomorrow will be cancelled due to lack of interest.

--=-dIs/NK+4wLBmWjfb5Lno
Content-Disposition: attachment; filename="MIPS-asm-thread_info-Add-_TIF_SECCOMP-flag.patch"
Content-Type: text/x-patch; name="MIPS-asm-thread_info-Add-_TIF_SECCOMP-flag.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogTWFya29zIENoYW5kcmFzIDxtYXJrb3MuY2hhbmRyYXNAaW1ndGVjLmNvbT4NCkRhdGU6
IFdlZCwgMjIgSmFuIDIwMTQgMTQ6NDA6MDAgKzAwMDANClN1YmplY3Q6IE1JUFM6IGFzbTogdGhy
ZWFkX2luZm86IEFkZCBfVElGX1NFQ0NPTVAgZmxhZw0KT3JpZ2luOiBodHRwczovL2dpdC5rZXJu
ZWwub3JnL2xpbnVzLzEzN2Y3ZGY4Y2VhZDAwNjg4NTI0YzgyMzYwOTMwODQ1Mzk2YjhhMjENCg0K
QWRkIF9USUZfU0VDQ09NUCBmbGFnIHRvIF9USUZfV09SS19TWVNDQUxMX0VOVFJZIHRvIGluZGlj
YXRlDQp0aGF0IHRoZSBzeXN0ZW0gY2FsbCBuZWVkcyB0byBiZSBjaGVja2VkIGFnYWluc3QgYSBz
ZWNjb21wIGZpbHRlci4NCg0KU2lnbmVkLW9mZi1ieTogTWFya29zIENoYW5kcmFzIDxtYXJrb3Mu
Y2hhbmRyYXNAaW1ndGVjLmNvbT4NClJldmlld2VkLWJ5OiBQYXVsIEJ1cnRvbiA8cGF1bC5idXJ0
b25AaW1ndGVjLmNvbT4NClJldmlld2VkLWJ5OiBKYW1lcyBIb2dhbiA8amFtZXMuaG9nYW5AaW1n
dGVjLmNvbT4NCkNjOiBsaW51eC1taXBzQGxpbnV4LW1pcHMub3JnDQpQYXRjaHdvcms6IGh0dHBz
Oi8vcGF0Y2h3b3JrLmxpbnV4LW1pcHMub3JnL3BhdGNoLzY0MDUvDQpTaWduZWQtb2ZmLWJ5OiBS
YWxmIEJhZWNobGUgPHJhbGZAbGludXgtbWlwcy5vcmc+DQpbYndoOiBCYWNrcG9ydGVkIHRvIDMu
MjogdmFyaW91cyBvdGhlciBmbGFncyBhcmUgbm90IGluY2x1ZGVkIGluDQogX1RJRl9XT1JLX1NZ
U0NBTExfRU5UUlldDQpTaWduZWQtb2ZmLWJ5OiBCZW4gSHV0Y2hpbmdzIDxiZW5AZGVjYWRlbnQu
b3JnLnVrPg0KLS0tDQotLS0gYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaA0K
KysrIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmgNCkBAIC0xNDksNyArMTQ5
LDcgQEAgcmVnaXN0ZXIgc3RydWN0IHRocmVhZF9pbmZvICpfX2N1cnJlbnRfdA0KICNkZWZpbmUg
X1RJRl9GUFVCT1VORAkJKDE8PFRJRl9GUFVCT1VORCkNCiAjZGVmaW5lIF9USUZfTE9BRF9XQVRD
SAkJKDE8PFRJRl9MT0FEX1dBVENIKQ0KIA0KLSNkZWZpbmUgX1RJRl9XT1JLX1NZU0NBTExfRU5U
UlkJKF9USUZfU1lTQ0FMTF9UUkFDRSB8IF9USUZfU1lTQ0FMTF9BVURJVCkNCisjZGVmaW5lIF9U
SUZfV09SS19TWVNDQUxMX0VOVFJZCShfVElGX1NZU0NBTExfVFJBQ0UgfCBfVElGX1NZU0NBTExf
QVVESVQgfCBfVElGX1NFQ0NPTVApDQogDQogLyogd29yayB0byBkbyBpbiBzeXNjYWxsX3RyYWNl
X2xlYXZlKCkgKi8NCiAjZGVmaW5lIF9USUZfV09SS19TWVNDQUxMX0VYSVQJKF9USUZfU1lTQ0FM
TF9UUkFDRSB8IF9USUZfU1lTQ0FMTF9BVURJVCkNCg==


--=-dIs/NK+4wLBmWjfb5Lno--

--=-kUReUyIZL4/N0J2Lz4sh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAU537pOe/yOyVhhEJAQrB7BAAj/tvk4GSgC3m5DEuyBx7tFd2Dp7kL0nW
1oX3NTtrrMn58yhatRkB5neBSo6N3mJo8O/hBvehWqUo1D5TYU+V7OcnSTLQW36w
1Yhe2S/QMRdi32G8BCYjZLQxVMYOy2C/opeyWH2W9dRg8I+jvx9sqgLv8qZUff7u
GzT3OewHhq1wN6NXLwKCs5SFtNzkc1GPOLz7Xy/b0ii1T0DYuAfNHnGvuCbJvMmx
O3yf6r6DvPjh7U1CiFI92H6R5zNbufmR/pOdA7OBeRl9zVYGi56/3zBHQUDANqFp
Rp0YHQPB0G/fwwQ+jfiMXa3O5L7S68o/NBN8ykl6kSHysshnryIvznh2B0SMevDs
nNHKAOMZlAOsvv/60ntLBQQ73QN7UOOkj1j4TngMT+SIrffJ6Q8VCGEYCYvOZA/X
2dbTVhb3cLaHdC5DnH2gUPDpc101tI1heKEDW+pz7r+KDDRba6/xZIN2vnoLczGd
iE68w2hEYYnqPYnvl4iNAeZ1Z8pIOVmRW3YsaaQIJGy0gjMmH5uuNrIW2VGwUZL8
YmCLYGCkjCwrPhdz4wWrmT1LxxAM1YV8AXokFQR/ZkhhrDzq6iEzxFtL7Eyi/o57
chWej1nzSEaUBM8w92uLwoEbSWEGbpxAUIVLfXd90q+yQRnsfNXWSKH5LICl3nWj
4+Z5VmHcIzs=
=3fel
-----END PGP SIGNATURE-----

--=-kUReUyIZL4/N0J2Lz4sh--
