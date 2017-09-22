Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2017 21:03:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57115 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990411AbdIVTC6xNdIg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Sep 2017 21:02:58 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E113B7D28ABF3;
        Fri, 22 Sep 2017 20:02:47 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Sep
 2017 20:02:51 +0100
Received: from np-p-burton.localnet (10.20.79.153) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 22 Sep
 2017 12:02:49 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] MIPS: Search main exception table for data bus errors
Date:   Fri, 22 Sep 2017 12:02:43 -0700
Message-ID: <2306573.vrYFQDzPkg@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <20170922094727.GI4851@linux-mips.org>
References: <20170922064447.28728-1-paul.burton@imgtec.com> <20170922064447.28728-2-paul.burton@imgtec.com> <20170922094727.GI4851@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3484465.qZ9cYAPr62";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.79.153]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart3484465.qZ9cYAPr62
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Ralf,

On Friday, 22 September 2017 02:47:27 PDT Ralf Baechle wrote:
> On Thu, Sep 21, 2017 at 11:44:44PM -0700, Paul Burton wrote:
> > We have 2 exception tables in MIPS kernels:
> >   - __ex_table which is the main exception table used in places where
> >   
> >     the kernel might fault accessing a user address.
> >   
> >   - __dbe_table which is used in various platform & driver code that
> >   
> >     expects that it might trigger a bus error exception.
> > 
> > When a data bus error exception occurs we only search __dbe_table, and
> > thus we have the expectation that access to user addresses will not
> > trigger bus errors.
> > 
> > Sadly, this expectation is not true - at least not since we began
> > mapping the GIC user page for use with the VDSO in commit a7f4df4e21dd
> > ("MIPS: VDSO: Add implementations of gettimeofday() and
> > clock_gettime()"). The GIC user page provides user code with direct
> > access to a hardware-provided memory mapped register interface, albeit a
> > very simple one containing a single register. Like many register
> > interfaces however it has limitations - notably like the rest of the GIC
> > register interface it requires that accesses to it are either 32 bit or
> > 64 bit. Any smaller accesses generate a data bus error exception. Herein
> > our bug lies - we have no such restrictions upon kernel access to user
> > memory, and users can freely cause the kernel to attempt smaller than 32
> > 
> > bit accesses in various ways:
> >   - Perform an unaligned memory access. In cases where this isn't
> >   
> >     handled by the CPU, such as when accessing uncached memory like the
> >     GIC register interface, we'll proceed to attempt to emulate the
> >     unaligned access via do_ade() using byte-sized loads or stores on
> >     MIPSr6 systems.
> >   
> >   - Cause the kernel to invoke __copy_from_user(), __copy_to_user() or
> >   
> >     one of their variants acting upon uncached memory with either a
> >     non-32bit-aligned address or size. Similarly this will cause the
> >     kernel to perform smaller than 32 bit memory accesses. Many syscalls
> >     will allow this to be triggered.
> > 
> > When the kernel attempts smaller than 32 bit access to the GIC user page
> > via any of these means, it generates a bus error exception. We then
> > check __dbe_table for a fixup, find none & call die_if_kernel() from
> > do_be(). Essentially we allow user code to kill the kernel, or rather to
> > cause the kernel to kill itself.
> > 
> > This patch fixes this problem rather simply by searching __ex_table for
> > fixups if we take a data bus error exception which has no fixup in
> > __dbe_table. All of the vulnerable user memory accesses should already
> > have entries in __ex_table, and making use of them seems reasonable.
> > 
> > I have marked this for stable backport as far as v4.4 which introduced
> > the VDSO, and provided users with access to the GIC user page in commit
> > a7f4df4e21dd ("MIPS: VDSO: Add implementations of gettimeofday() and
> > clock_gettime()"). Searching __ex_table may have made sense prior to
> > that, but I'm currently unaware of any other cases in which it could
> > cause problems.
> 
> Unfortunately the DBE exception is imprecise.  The EPC might actually point
> to the far end of the kernel and have no useful relation at all to the
> instruction triggering it.
> 
> As a consequence a false fixup might be used resulting in very silly and
> probably bad things happening.
> 
> So this needs a different solution.
> 
>   Ralf

Fair point, depending upon the CPU. That makes things difficult though...

Handling the unaligned emulation case is "easy" if we simply refuse to emulate 
unaligned access to uncached memory. Generally uncached mappings are going to 
be device I/O which the kernel probably ought not to go attempting to emulate 
without knowing the semantics required for access. Emulating unaligned 
accesses is already a slow path so adding in the check for cacheability seems 
reasonable. I've written a patch which does this & seems to work fine.

Handling copy_from_user()/copy_to_user() & company though is harder. 
Theoretically we could do the same cacheability check in __access_ok() but 
that would add a fair chunk of overhead to regular user memory access. There 
are also the user string functions (strncpy_from_user, strnlen_user) which 
don't appear to check access_ok() at all and presumably just rely on 
recovering from any exceptions via __ex_table.

I'm not sure there's a clean and efficient way to do this without letting the 
bus error happen & recovering afterwards. Any ideas?

Thanks,
    Paul
--nextPart3484465.qZ9cYAPr62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlnFXlMACgkQgiDZ+mk8
HGXoag//V1FklUTTrjDtB3V4x8PjIDKxhRZ4YFGm8HTtCuOY6YSfLacbgl/1W7Gt
PgBOf7scz25GgGHBQ/ggrIWAjpeqHUkvE1+wDWZA2mcy5T6AMEbMp2iKpKNd/492
60AY7oDv8MyziBcsbbbSDu603W08cWids0D4B2kLe/RuGwsr6cOoGNqKjNnOt29g
vPFWCyj2GJUfWhbWkkgD3HEyufnOOIwrDQIIKZvGps8WF6FZsrXIirP+wXy0TiGC
oANhQj/8k1faT7FadzQDX39gOnWhGKs2WaCuEA2W1NTg9wN3G9lFI0BR17LqxeuM
vM2ejINZrKklIRMie6kVpced/C7gKUAJGCRS/P/1fn5j4Ozq6i83eVGp7q8N/I/W
ukNFa1K7aRRs5WPH3PWlZr0/aZ70gc+8Hu1kLtrICR5xEH1UaRnnHusrmGG6JrPT
QgMVg1gI5bW5T2kDqDuoWGUzUG4pcT/+n2eCGs3CtB4FRlpzAVMFGIWOHnlksaxX
adKYCE0PC448KYhf6VgUi58+NEtATv/uhFoH78A1Zk/Rxvqa6IBdBL2hNmQa1cuV
H0/gjY8PcSDg/TwjMEs+DrztN/KiZ7mV0uwMCaY6orZVxFOqnQd8OCIelCYLzh+g
ylPzyG7SdZvAVEHFAVaSIp308Swt7rXE2f51iCmZ95JHJeFb0Xk=
=F5rI
-----END PGP SIGNATURE-----

--nextPart3484465.qZ9cYAPr62--
