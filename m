Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 22:32:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18554 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993009AbdDDUcZ2L9G0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2017 22:32:25 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 43BD041F8DA6;
        Tue,  4 Apr 2017 22:38:31 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 04 Apr 2017 22:38:31 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 04 Apr 2017 22:38:31 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9443625F0FA4E;
        Tue,  4 Apr 2017 21:32:15 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 4 Apr
 2017 21:32:19 +0100
Date:   Tue, 4 Apr 2017 21:32:19 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Rabin Vincent <rabin.vincent@axis.com>
CC:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [PATCH] MIPS: cevt-r4k: fix array out-of-bounds access
Message-ID: <20170404203219.GK31606@jhogan-linux.le.imgtec.org>
References: <1491291731-5797-1-git-send-email-rabin.vincent@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LuMRVxdB65zydaDL"
Content-Disposition: inline
In-Reply-To: <1491291731-5797-1-git-send-email-rabin.vincent@axis.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57564
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

--LuMRVxdB65zydaDL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rabin,

On Tue, Apr 04, 2017 at 09:42:11AM +0200, Rabin Vincent wrote:
> From: Rabin Vincent <rabinv@axis.com>
>=20
> calculate_min_delta() tries to access a fourth element of buf2 but the
> array has only three elements.  This triggers undefined behaviour and
> causes strange crashes in start_kernel() sometime after timer
> initialization, when built with GCC 5.3, probably due to register/stack
> corruption:
>=20
>  sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 10737418237ns
>  CPU 0 Unable to handle kernel paging request at virtual address ffffb0aa,
>        epc =3D=3D 8067daa8, ra =3D=3D 8067da84
>  Oops[#1]:
>  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.18 #51
>  task: 8065e3e0 task.stack: 80644000
>  $ 0   : 00000000 00000001 00000000 00000000
>  $ 4   : 8065b4d0 00000000 805d0000 00000010
>  $ 8   : 00000010 80321400 fffff000 812de408
>  $12   : 00000000 00000000 00000000 ffffffff
>  $16   : 00000002 ffffffff 80660000 806a666c
>  $20   : 806c0000 00000000 00000000 00000000
>  $24   : 00000000 00000010
>  $28   : 80644000 80645ed0 00000000 8067da84
>  Hi    : 00000000
>  Lo    : 00000000
>  epc   : 8067daa8 start_kernel+0x33c/0x500
>  ra    : 8067da84 start_kernel+0x318/0x500
>  Status: 11000402 KERNEL EXL
>  Cause : 4080040c (ExcCode 03)
>  BadVA : ffffb0aa
>  PrId  : 0501992c (MIPS 1004Kc)
>  Modules linked in:
>  Process swapper/0 (pid: 0, threadinfo=3D80644000, task=3D8065e3e0, tls=
=3D00000000)
>  Call Trace:
>  [<8067daa8>] start_kernel+0x33c/0x500
>  Code: 24050240  0c0131f9  24849c64 <a200b0a8> 41606020  000000c0  0c1a45=
e6
>        00000000  0c1a5f44
>=20
> UBSAN also detects it:
>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  UBSAN: Undefined behaviour in arch/mips/kernel/cevt-r4k.c:85:41
>  load of address 80647e4c with insufficient space
>  for an object of type 'unsigned int'
>  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.18 #47
>  Call Trace:
>  [<80028f70>] show_stack+0x88/0xa4
>  [<80312654>] dump_stack+0x84/0xc0
>  [<8034163c>] ubsan_epilogue+0x14/0x50
>  [<803417d8>] __ubsan_handle_type_mismatch+0x160/0x168
>  [<8002dab0>] r4k_clockevent_init+0x544/0x764
>  [<80684d34>] time_init+0x18/0x90
>  [<8067fa5c>] start_kernel+0x2f0/0x500
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hmm, good catch, thanks! Curious that a stray read would wreck such
havoc, but I suppose the compiler can do whatever weirdness it likes
after that. Clearly it shouldn't be doing that read in the first place.=20

>=20
> Fixes: 1fa405552e33f2 ("MIPS: cevt-r4k: Dynamically calculate min_delta_n=
s")
> Signed-off-by: Rabin Vincent <rabinv@axis.com>
> ---
>  arch/mips/kernel/cevt-r4k.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index 804d2a2..723a1f1 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
> @@ -48,7 +48,7 @@ static int mips_next_event(unsigned long delta,
>  static unsigned int calculate_min_delta(void)
>  {
>  	unsigned int cnt, i, j, k, l;
> -	unsigned int buf1[4], buf2[3];
> +	unsigned int buf1[4], buf2[4];

I think the correct fix is to prevent the read rather than change the
size of the array. buf2[] is intentionally 3 so that out of 5 sorted
samples the last element is the median, whereas buf1 is 4 elements so as
to work out the 75th percentile.

When inserting the 5th sample into buf1 (i.e. j =3D 4), there are already
4 entries, so the highest element it needs to compare against is the 4th
one (buf1[k=3D3]), so thats fine.

For buf2 however its still trying to insert 5 elements, so by the 5th
one (i.e. i =3D 4) it may try to compare against the 4th element to know
whether to insert before it, at which point we simply don't care about
the ordering as its past the median.

So I think something like this would be more correct. Does that fix your
problem?

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 804d2a2a19fe..dd6a18bc10ab 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -80,7 +80,7 @@ static unsigned int calculate_min_delta(void)
 		}
=20
 		/* Sorted insert of 75th percentile into buf2 */
-		for (k =3D 0; k < i; ++k) {
+		for (k =3D 0; k < i && k < ARRAY_SIZE(buf2); ++k) {
 			if (buf1[ARRAY_SIZE(buf1) - 1] < buf2[k]) {
 				l =3D min_t(unsigned int,
 					  i, ARRAY_SIZE(buf2) - 1);

Thanks
James

--LuMRVxdB65zydaDL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY5ALMAAoJEGwLaZPeOHZ6WvwP+wcBD0vhO63tFPosPCinf4CJ
WeWbOlVSBkExh/LheUpxnhsKgPcfpoECSK2SmZ6NyncVtRBPfSDk7qAa3kJGEFxC
xCGVu3eJjVI158P3eNz0dK04tislpnYWXzFM7565mHh33Qcod60XJ+JuaQqGFMCI
juasXNSUGbwHZfLefVI5D+ux85o9Xf8617W/P1HMt7ULSZU+qdojgztBVgToqz+3
B6qYPAGm2SJketfFUiz44zNlqOd/LrPsFD6bZZdbdllLfI7z9afob6U1yh1BZlNr
9Z9I9hgaf/3nzfaDW4k736XbHoGfpENSwNHebUuGaGP4gqE9VeC+R1zUXUv0zSgT
4viQ7BKENtogQpQwt4NfdK+Ajd6giU6dwp3A1wrmbaVIBpuWva0sjJl+uPQHEDK0
PQ0J18Xbep8hdGVbQJ+uE04qWvq/ecvM38PkL6rrs3SAC9YjFWuqWE8lyxELKXqR
7yX90XhGvHjErjMv6cqx7uEmAefR0NethSJJVkXpqc2IFSDD71wXqm8wRt7SZQIS
/JrNF7++Rknop2KWmvEyL/qGo4vCi2ba5HC+GomXzJiZCGdqh/aEln75OcqailsT
ObT3fTP6YQS8yJkqt0/s4k+Vv2fvTngc/kSYZ4yzGlpMlNxGTNVARsZ9AWK4YiA1
70ND0x8cnm/QCsQAeBw3
=KWBp
-----END PGP SIGNATURE-----

--LuMRVxdB65zydaDL--
