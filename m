Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2018 21:31:45 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:42578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994664AbeBSUbdhIATO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Feb 2018 21:31:33 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB8EC2177E;
        Mon, 19 Feb 2018 20:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8EC2177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 19 Feb 2018 20:31:21 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Peter Mamonov <pmamonov@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: fcntl64 syscall causes user program stack corruption
Message-ID: <20180219203120.GA6245@saruman>
References: <20180219180655.wiotjqubelp7ywxs@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20180219180655.wiotjqubelp7ywxs@localhost.localdomain>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 09:06:56PM +0300, Peter Mamonov wrote:
> Hello,
>=20
> After upgrading the Linux kernel to the recent version I've found that th=
e=20
> Firefox browser from the Debian 8 (jessie),mipsel stopped working: it cau=
ses=20
> Bus Error exception at startup. The problem is reproducible with the QEMU=
=20
> virtual machine (qemu-system-mips64el). Thorough investigation revealed t=
hat=20
> the following syscall in /lib/mipsel-linux-gnu/libpthread-2.19.so causes=
=20
> Firefox's stack corruption at address 0x7fff5770:
>=20
> 	0x77fabd28:  li      v0,4220
> 	0x77fabd2c:  syscall
>=20
> Relevant registers contents are as follows:
>=20
> 		  zero       at       v0       v1       a0       a1       a2       a3
> 	 R0   00000000 300004e0 0000107c 77c2e6b0 00000006 0000000e 7fff574c 7ff=
f5770=20
>=20
> The stack corruption is caused by the following patch:
>=20
> 	commit 8c6657cb50cb037ff58b3f6a547c6569568f3527
> 	Author: Al Viro <viro@zeniv.linux.org.uk>
> 	Date:   Mon Jun 26 23:51:31 2017 -0400
> =09
> 	    Switch flock copyin/copyout primitives to copy_{from,to}_user()
> 	   =20
> 	    ... and lose HAVE_ARCH_...; if copy_{to,from}_user() on an
> 	    architecture sucks badly enough to make it a problem, we have
> 	    a worse problem.
> 	   =20
> 	    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>=20
> Reverting the change in put_compat_flock() introduced by the patch preven=
ts the=20
> stack corruption:
>=20
> 	diff --git a/fs/fcntl.c b/fs/fcntl.c
> 	index 0345a46b8856..c55afd836e5d 100644
> 	--- a/fs/fcntl.c
> 	+++ b/fs/fcntl.c
> 	@@ -550,25 +550,27 @@ static int get_compat_flock64(struct flock *kfl, c=
onst struct compat_flock64 __u
> 	=20
> 	 static int put_compat_flock(const struct flock *kfl, struct compat_floc=
k __user *ufl)
> 	 {
> 	-       struct compat_flock fl;
> 	-
> 	-       memset(&fl, 0, sizeof(struct compat_flock));
> 	-       copy_flock_fields(&fl, kfl);
> 	-       if (copy_to_user(ufl, &fl, sizeof(struct compat_flock)))
> 	+       if (!access_ok(VERIFY_WRITE, ufl, sizeof(*ufl)) ||
> 	+           __put_user(kfl->l_type, &ufl->l_type) ||
> 	+           __put_user(kfl->l_whence, &ufl->l_whence) ||
> 	+           __put_user(kfl->l_start, &ufl->l_start) ||
> 	+           __put_user(kfl->l_len, &ufl->l_len) ||
> 	+           __put_user(kfl->l_pid, &ufl->l_pid))
> 	                return -EFAULT;
> 	        return 0;
> 	 }
>=20
> Actually, the change introduced by the patch is ok. However, it looks lik=
e=20
> there is either a mismatch of sizeof(struct compat_flock) between the ker=
nel=20
> and the user space or a mismatch of types used by the kernel and the user=
=20
> space.  Despite the fact that the user space is built for a different ker=
nel=20
> version (3.16), I believe this syscall should work fine with it, since `s=
truct=20
> compat_flock` did not change since the 3.16.  So, probably, the problem i=
s=20
> caused by some discrepancies which were hidden until "Switch flock=20
> copyin/copyout..." patch.
>=20
> Please, give your comments.

Hmm, thanks for reporting this.

The change this commit makes is to make it write the full compat_flock
struct out, including the padding at the end, instead of only the
specific fields, suggesting that MIPS' struct compat_flock on 64-bit
doesn't match struct flock on 32-bit.

Here's struct flock from arch/mips/include/uapi/asm/fcntl.h with offset
annotations for 32-bit:

struct flock {
/*0*/	short	l_type;
/*2*/	short	l_whence;
/*4*/	__kernel_off_t	l_start;
/*8*/	__kernel_off_t	l_len;
/*12*/	long	l_sysid;
/*16*/	__kernel_pid_t l_pid;
/*20*/	long	pad[4];
/*36*/
};

and here's struct compat_flock from arch/mips/include/asm/compat.h with
offset annotations for 64-bit:

struct compat_flock {
/*0*/	short		l_type;
/*2*/	short		l_whence;
/*4*/	compat_off_t	l_start;
/*8*/	compat_off_t	l_len;
/*12*/	s32		l_sysid;
/*16*/	compat_pid_t	l_pid;
/*20*/	short		__unused;
/*24*/	s32		pad[4];
/*40*/
};

Clearly the existence of __unused is outright wrong here.

Please can you test the following patch to see if it fixes the issue.

Thanks again,
James

=46rom ebcbbb431aa7cc97330793da8a30c51150963935 Mon Sep 17 00:00:00 2001
=46rom: James Hogan <jhogan@kernel.org>
Date: Mon, 19 Feb 2018 20:14:34 +0000
Subject: [PATCH] MIPS: Drop spurious __unused in struct compat_flock

MIPS' struct compat_flock doesn't match the 32-bit struct flock, as it
has an extra short __unused before pad[4], which combined with alignment
increases the size to 40 bytes compared with struct flock's 36 bytes.

Since commit 8c6657cb50cb ("Switch flock copyin/copyout primitives to
copy_{from,to}_user()"), put_compat_flock() writes the full compat_flock
struct to userland, which results in corruption of the userland word
after the struct flock when running 32-bit userlands on 64-bit kernels.

This was observed to cause a bus error exception when starting Firefox
on Debian 8 (Jessie).

Reported-by: Peter Mamonov <pmamonov@gmail.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.13+
---
 arch/mips/include/asm/compat.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 946681db8dc3..9a0fa66b81ac 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -86,7 +86,6 @@ struct compat_flock {
 	compat_off_t	l_len;
 	s32		l_sysid;
 	compat_pid_t	l_pid;
-	short		__unused;
 	s32		pad[4];
 };
=20
--=20
2.13.6


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqLNBgACgkQbAtpk944
dnoRdRAAok1NBFXyy5TMm4oerViqhgngHFxtRlbJJhv9XJZ06IZGhWeEr4p6DTFl
HByibDH+0HWkVbmo7eneZK3CEpd53UhL6f+VL5NiAtxuoBrmZO+J7NZIa9N7ulaI
fy4dczvlm16Q9Z6xhtOBV04VOhHwkXr6X6YmNhhnNYxDal8q2w62FpwSA75yQD0J
mFIhAZFniO+oBDUASAfTBTCgtXKdKFINT310X8yym9FEuRyuP4kOxQijJGAx/6ae
z6ljJ0yqp3GTGzzPnKBR70BnQZdMZTjYHXwXzYQNwXCb0/iXegzPrkdlM1Yi+wWc
sNf5QyUeR94/rBhHM4FDpZztg30po+3RudLhnH7nSwtbmB5Hv8kD6e+c7jVoRKZq
gLVJP+J/XjLjDhWcPrn5gP2wCPrE5VIrdqysyF9q4WDJQ+WMmwf84/Bjd+yFwCKi
rulIJw0EI1WQKtTccBCAS4lbq74fKe+Xi4vUURbWmMl17PXMD4V0IdNZGYduEa1z
9PLfo7k3dNkok6UcWRMtYPHfLQxuj0CRTztSe8QxuWPu6ssMFzsm2dL4NKuPc4Vi
c10+tvzPLqRXymF2rft/jOdp54XwQtQ9Ua8/uY4h7M5SBffC+0LUKWoxs6CTz+Eh
WpxWoX5phWbu+bIoaI+/+PIqUAlZAmzI2ZLTVSEozOprsgtXwII=
=ZqfQ
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
