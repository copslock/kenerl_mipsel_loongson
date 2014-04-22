Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 05:09:55 +0200 (CEST)
Received: from pide.tip.net.au ([101.0.96.218]:39839 "EHLO pide.tip.net.au"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822097AbaDVDJtg3Efd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Apr 2014 05:09:49 +0200
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pide.tip.net.au (Postfix) with ESMTPSA id 52FBC1286A5;
        Tue, 22 Apr 2014 13:09:36 +1000 (EST)
Date:   Tue, 22 Apr 2014 13:09:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux@openrisc.net,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/4] ARCH: AUDIT: implement syscall_get_arch for all
 arches
Message-Id: <20140422130931.940f53412d30730aa4bc820b@canb.auug.org.au>
In-Reply-To: <1395266643-3139-3-git-send-email-eparis@redhat.com>
References: <1395266643-3139-1-git-send-email-eparis@redhat.com>
        <1395266643-3139-3-git-send-email-eparis@redhat.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__22_Apr_2014_13_09_31_+1000_flia9hF+yPUdnFYF"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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

--Signature=_Tue__22_Apr_2014_13_09_31_+1000_flia9hF+yPUdnFYF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eric,

[I just noticed that this turned up in linux-next ...]

On Wed, 19 Mar 2014 18:04:02 -0400 Eric Paris <eparis@redhat.com> wrote:
>
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/as=
m/syscall.h
> index b54b2ad..4271544 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -13,6 +13,8 @@
>  #ifndef _ASM_SYSCALL_H
>  #define _ASM_SYSCALL_H	1
> =20
> +#include <uapi/linux/audit.h>
> +#include <linux/compat.h>

You don't need linux/compat.h, I think, but you do need to include
linux/thread_info.h for is_32bit_task() below.

>  #include <linux/sched.h>
> =20
>  /* ftrace syscalls requires exporting the sys_call_table */
> @@ -86,4 +88,14 @@ static inline void syscall_set_arguments(struct task_s=
truct *task,
>  	memcpy(&regs->gpr[3 + i], args, n * sizeof(args[0]));
>  }
> =20
> +static inline int syscall_get_arch(void)
> +{
> +	int arch =3D AUDIT_ARCH_PPC;
> +
> +#ifdef CONFIG_PPC64
> +	if (!is_32bit_task())
> +		arch =3D AUDIT_ARCH_PPC64;
> +#endif
> +	return arch;

This could just be

	return is_32bit_task() ? AUDIT_ARCH_PPC : AUDIT_ARCH_PPC64;

as is_32bit_task() is always defined (and is (1) for !CONFIG_PPC64).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__22_Apr_2014_13_09_31_+1000_flia9hF+yPUdnFYF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTVd1wAAoJEMDTa8Ir7ZwVHfUQAJBjX5ikUyun82MFtAMdTh2x
9nOveILFcSwGt4ZDyYica+UARDkB0KbtMB38pF7MPePG9f93twRYMnRskrM5XaN0
GDLOJxVoikuMRlt2HxyIVmrLs0JvCccOZz+Uy1Pq50RlB+GqBqCPbDMd7IZBQYKb
MdPoYr+0wIe2eMYRc+Rj9CBzCuY79FoQhCl6rIMsQRJ1/SrD7zvDP8x8J2n/8hpk
+jbgeX30zDIQlCP/a5MjSBFdmqW6N8d5GKLcNPdBSdWe0Ff8G/d/8gz8Q2lvyNxQ
dZdNxa116iZwE5H8p6zLchiwyel3vZzvLCMILCoc1ysMxQXx9Z+sfroFAjYjClm9
EIzBfzV7GR8QsssjCKSkcfFgfviHxIWFWo1ypmlnU/HMNkDB4ywHF6u6t8sx54c0
ZAfKuXa4gs+y99SuEoNbqPB1ssGwhFGdPV9A5n5m5aP8BaRYDFvat7rKA46mWCE2
JFA5CNWHCqzR3Ap/FDht3SeTNFUmDOnY/mfLB5CtjYg8HoTkAT+GB2eXKM9nn5nB
9UiqxLBFgfp1S0aFYlQqixJN872WxkT3L+V7V9DSwLR83RS4PBoSTWKivdZ4/01Y
DOhcrsMkZuOtcJO5QQrZ7hU31ngIHOuVdesryVcVTnh28r1IfviH/YW9xXoC9aS1
axXNb3h4pYFXeMyYxoZ0
=gnUE
-----END PGP SIGNATURE-----

--Signature=_Tue__22_Apr_2014_13_09_31_+1000_flia9hF+yPUdnFYF--
