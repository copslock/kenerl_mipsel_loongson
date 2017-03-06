Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2017 12:40:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32451 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990514AbdCFLkoXQ3d4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2017 12:40:44 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 66E2441F8D8A;
        Mon,  6 Mar 2017 12:45:30 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 06 Mar 2017 12:45:30 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 06 Mar 2017 12:45:30 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 922EDE945A642;
        Mon,  6 Mar 2017 11:40:35 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 6 Mar
 2017 11:40:38 +0000
Date:   Mon, 6 Mar 2017 11:40:38 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: RFC: Proper locking tips for IRQ handlers?
Message-ID: <20170306114038.GE2878@jhogan-linux.le.imgtec.org>
References: <2c6f8c8d-6380-2f0b-69be-72115e2012c7@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline
In-Reply-To: <2c6f8c8d-6380-2f0b-69be-72115e2012c7@gentoo.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57052
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

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Sat, Mar 04, 2017 at 10:17:41AM -0500, Joshua Kinard wrote:
> I am looking for some feedback on how to improve IRQ handlers on IP30 (SGI
> Octane).  Since switching to the use of per_cpu data structures, I've
> apparently not needed to do any locking when handling IRQs.  However, it =
looks
> like around ~Linux-4.8.x, there's some noticeable contention going on with
> heavy disk I/O, and it's worse in 4.9 and 4.10.  Under 4.8, untar'ing a b=
asic
> Linux kernel source tarball completed fine, but as of 4.9/4.10, there's a
> chance to trigger either an oops or oom killer.  While the untar operation
> happens, I can watch the graphics console and the blinking cursor will
> sometimes pause momentarily, which suggests contention somewhere.
>=20
> So my question is in struct irq_chip accessors like irq_ack, irq_mask,
> irq_mask_ack, etc, should spinlocks be used prior to accessing the HEART =
ASIC?
> And if so, normal spinlocks, raw spinlocks, or the irq save/restore varia=
nts?

On RT kernels spinlock_t becomes a mutex and won't work correctly with
IRQs actually disabled for the IRQ callbacks, so raw spinlocks would be
needed instead.

To decide which variant, a good reference is:
https://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/index.h=
tml
in particular the cheat sheet for locking:
https://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/c214.ht=
ml

(I don't know OTOH which contexts these callbacks are called from,
definitely hard IRQ, but possibly others when registering IRQs etc).

If its only protecting access to per-CPU structures though you shouldn't
need the spinlock part of the locks (but does it not access hardware
registers too, or are those accesses atomic in hardware rather than
software doing read-modify-write?). In that case you could choose to use
the following instead of locks depending on the contexts its used in:

- spin_lock_irqsave/restore -> local_irq_save/restore +
				preempt_disable/enable
- spin_lock_irq -> local_irq_disable/enable +
				preempt_disable/enable
- spin_lock_bh -> local_bh_disable/enable
- spin_lock -> preempt_disable/enable

Hope that helps a bit

Cheers
James

> I've looked at the IRQ implementations for a few other MIPS boards, but b=
ecause
> each system is so unique, there's no clear consensus on the right way to =
do it.
>  Octeon, uses irq_bus_lock and irq_bus_sync_unlock, along with a mutex, f=
or
> locking, while netlogic uses locking only during irq_enable or irq_disabl=
e, and
> loongsoon-3 doesn't appear to employ any locking at all.  Other archs app=
ear to
> be a mix as well, and I'm even seeing newer constructs like the use of
> irq_data_get_irq_chip_data() to fetch a common data structure where the
> spinlock variable is defined.  Other systems use a global spinlock.
>=20
> Any advice would be greatly appreciated.  Thanks!
>=20
> --=20
> Joshua Kinard
> Gentoo/MIPS
> kumba@gentoo.org
> 6144R/F5C6C943 2015-04-27
> 177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943
>=20
> "The past tempts us, the present confuses us, the future frightens us.  A=
nd our
> lives slip away, moment by moment, lost in that vast, terrible in-between=
=2E"
>=20
> --Emperor Turhan, Centauri Republic
>=20

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYvUq1AAoJEGwLaZPeOHZ69dgQALvB88McFpz9crKLzE8EZTml
pQVE+nILFX/uHYR68CY7Pv0gnrKgijV0kHHhTWETJyKpHAkEvghcccy3JMrnBmZf
wRAOsWCehBxUuhalqrRxzq2bew6feUAkCmXZfqmYIBnvqxBsa3ShgnWz7Btc8L9M
8oNxLSFH2rEltZRrIhbFvkM2nPpkbEyrQ/DfP2qA/chYNWLjjkiqrwiTctOowFPi
ReO+RF51izkeZZj81CsfmCMo5rInIEW8nuDwS5C6PwzwDtlAdoIkJdsV1TapXh4N
1NTWoiAE8IZ3UpwQAO6ann8U+Gn16ZKFoCcjmGeXXomJa1Km4847c5Ss30FZGGMq
Ysvm7w4BkxyhWhrp6GnXTEyXlmTWN7ydT5xun9sMknsyVHSWMzK2NPMedrYt1smA
+FEF6w0AlRvvvlzGIbLdHrjYTz7J8Mnc69EDOkr98Bkge/pET5/2VxVudgghjl0b
h0YRFRWkgObIdZh00WFnLTP8I0FPQv50w7byYQ7UFUm1z6wLi1tPm5qkekt9MPvR
MNmxXqoQ7CrSH/wnvK2IDSFe+8GHyIWgPul5KaRZvwWJkLiP9hD90dc6y1d4E4uX
O7bDkH1ZZYD9LF1XNvh/QiJ3xfk45asK01eQXFUZ+cYTpoLXI6fQYZhJhiJa/lw4
NmWaBVZfzF+O3CiZXRsq
=Zqq2
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
