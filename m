Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2017 16:00:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13552 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992214AbdCQO7x2sM0h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2017 15:59:53 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B502741F8E96;
        Fri, 17 Mar 2017 16:05:09 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 17 Mar 2017 16:05:09 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 17 Mar 2017 16:05:09 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1B2AB73B2FD17;
        Fri, 17 Mar 2017 14:59:44 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 17 Mar
 2017 14:59:47 +0000
Date:   Fri, 17 Mar 2017 14:59:47 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Lars Persson <lars.persson@axis.com>
CC:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Lars Persson <larper@axis.com>
Subject: Re: [PATCH] MIPS: disable page faults in syscall_get_arguments
Message-ID: <20170317145947.GK2878@jhogan-linux.le.imgtec.org>
References: <1489744570-16929-1-git-send-email-larper@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Content-Disposition: inline
In-Reply-To: <1489744570-16929-1-git-send-email-larper@axis.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 10:56:10AM +0100, Lars Persson wrote:
> We call a sleeping function in MIPS' get_syscall_arguments to read
> from the userspace stack. Disable page faults around these calls to
> prevent sleep in atomic contexts.
>=20
> The problem was observed as the following splat with ftrace system
> call tracing enabled:
>=20
> BUG: sleeping function called from invalid context at arch/mips/include/a=
sm/syscall.h:48
> in_atomic(): 1, irqs_disabled(): 0, pid: 1389, name: sh
> Preemption disabled at:
> [<801d31d4>] __fd_install+0x50/0x194
> CPU: 2 PID: 1389 Comm: sh Not tainted 4.9.14-axis4-devel #6
> Stack : 809d7bfa 0000003b 00000000 00000000 00000000 00000000 800a5438 80=
8c3507
>         8e77599c 0000056d 00000002 809c4f44 8fc060e0 8dc07f68 00000005 80=
0a5468
>         00000005 80403b30 00000000 00000000 807f5b64 8dc07e0c 8dc07df4 80=
14a36c
>         00000000 8004927c 809d7bf8 00000024 8dc07e0c 00000000 00000002 80=
7eaf58
>         00000000 00000000 00000000 00000000 00000000 00000000 00000000 00=
000000
>         ...
> Call Trace:
> [<80021a68>] show_stack+0x94/0xb0
> [<803f4e38>] dump_stack+0x98/0xd0
> [<80074838>] ___might_sleep+0x160/0x1e4
> [<801205f8>] ftrace_syscall_enter+0x1c8/0x3ac
> [<8001f77c>] syscall_trace_enter+0x18c/0x1f8
> [<8002b3f8>] syscall_trace_entry+0x44/0x94

Hmm, tricky. If for some reason the stack page was swapped out before
syscall_get_arguments() was called, then by disabling page faults the
args would be left uninitialised, even when not called from IRQ disabled
context...

We already copy the args to the kernel stack in handle_sys (with IRQs
enabled), but thats as arguments to the syscall handler function and I
suppose there's nothing to stop it overwriting those arguments.

Cheers
James

>=20
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  arch/mips/include/asm/syscall.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/sysc=
all.h
> index d878825..270a6d5 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -104,8 +104,10 @@ static inline void syscall_get_arguments(struct task=
_struct *task,
>  	    (regs->regs[2] =3D=3D __NR_syscall))
>  		i++;
> =20
> +	pagefault_disable();
>  	while (n--)
>  		ret |=3D mips_get_syscall_arg(args++, task, regs, i++);
> +	pagefault_enable();
> =20
>  	/*
>  	 * No way to communicate an error because this is a void function.
> --=20
> 2.1.4
>=20
>=20

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYy/nTAAoJEGwLaZPeOHZ6hkQP/0P+u8LQ+BE6QxkZa8B0fw0F
YzUriM76DPX3ZBPmcT3D9kAUP0GfJzzqOv52RqyUfhIHOiF/5CHlk582egxryCoA
MeKR9caygTJbYelE/TjWmcA4RugkBOcFeHqELRGroz/siHes+CNjSY93gaaxB46s
yMSU3WrB7GGRLXxL/ekv0eK+Zqmy8Xh+BwQAVN9f6dIxK4Cp8sduJYczdBwPcpQ1
YP/RnxCfcgPMNOz3cBVAx8qRoRdT4gOwExoOsDOgxgCeiPEJyid2llL1GdYeIO2E
ELlKxaahLniiiBDmsu0xC+mi9IftfOoMAyC+uTZGOMs9KxQErncTWhSwAyMgAaFK
XVMw+6nvff1LiXxRB3fnLTcORsv+WGv11TYPY3KMYcvUMPwovQWB8UPsv+btNNob
t5qqdbfVg7PMqGAr14C2u6Q0wTBFoUCkIBrALYah2zQNW4JmVym1VCunRU/cJHNJ
/PhC8phFL72jqmLjfakwS8k+g+E3Izv7xWTW+zKjwjsnZ4mZR/DTyI8vQleYuZZ7
uCbfIRdSlCa3P15T3mIcgXFLh3wKPW1y3hYU1GPzdmdKTCGCHK8CqQRzcc5KPFX0
L+J0D3S7xl4G7Sf/JWauk+2sf1I5xCyLfnqQPMcnIHN6TY9258/8zpFNVMsvNfyQ
wZrWfKGTX0vq4pdRCVIE
=+9Bj
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--
