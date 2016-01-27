Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 12:16:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24031 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010687AbcA0LQD4skZM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 12:16:03 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 709B041F8E43;
        Wed, 27 Jan 2016 11:15:58 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 27 Jan 2016 11:15:58 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 27 Jan 2016 11:15:58 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 605DB301F75E7;
        Wed, 27 Jan 2016 11:15:56 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 27 Jan 2016 11:15:58 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 27 Jan
 2016 11:15:57 +0000
Date:   Wed, 27 Jan 2016 11:15:57 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 5/6] MIPS: Loongson: Introduce and use
 cpu_has_coherent_cache feature
Message-ID: <20160127111557.GA19682@jhogan-linux.le.imgtec.org>
References: <1453814784-14230-1-git-send-email-chenhc@lemote.com>
 <1453814784-14230-6-git-send-email-chenhc@lemote.com>
 <20160126134229.GA12365@jhogan-linux.le.imgtec.org>
 <CAAhV-H5zFb=rnESwHvgykNVe1FyAC1WX5zAHUXswYwu7a=VPKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5zFb=rnESwHvgykNVe1FyAC1WX5zAHUXswYwu7a=VPKw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51473
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

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Huacai,

On Wed, Jan 27, 2016 at 12:58:42PM +0800, Huacai Chen wrote:
> "cache coherency" here means the coherency across cores, not ic/dc
> coherency, could you please suggest a suitable name?

Data cache coherency across cores is pretty much a requirement for SMP.
It looks more like for various reasons you can skip the cache management
functions, e.g.

> >> @@ -503,6 +509,9 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
> >>  {
> >>       int exec = vma->vm_flags & VM_EXEC;
> >>
> >> +     if (cpu_has_coherent_cache)
> >> +             return;

This seems to suggest:
1) Your dcaches don't alias.
2) Your icache is coherent with your dcache, otherwise you would need to
   flush the icache here so that mprotect RW->RX makes code executable
   without risk of stale lines existing in icache.

So, is that the case?

If so, it would seem better to ensure that cpu_has_dc_aliases evaluates
to false, and add a similar one for icache coherency, hence my original
suggestion.


> >> +
> >>       if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
> >>               r4k_on_each_cpu(local_r4k_flush_cache_range, vma);

(Note, this cpu_has_ic_fills_f_dc check is wrong, it shouldn't prevent
icache flush, see http://patchwork.linux-mips.org/patch/12179/)

Cheers
James

> >>  }
> >> @@ -627,6 +636,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
> >>  {
> >>       struct flush_cache_page_args args;
> >>
> >> +     if (cpu_has_coherent_cache)
> >> +             return;
> >> +
> >>       args.vma = vma;
> >>       args.addr = addr;
> >>       args.pfn = pfn;
> >> @@ -636,11 +648,17 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
> >>
> >>  static inline void local_r4k_flush_data_cache_page(void * addr)
> >>  {
> >> +     if (cpu_has_coherent_cache)
> >> +             return;
> >> +
> >>       r4k_blast_dcache_page((unsigned long) addr);
> >>  }
> >>
> >>  static void r4k_flush_data_cache_page(unsigned long addr)
> >>  {
> >> +     if (cpu_has_coherent_cache)
> >> +             return;
> >> +
> >>       if (in_atomic())
> >>               local_r4k_flush_data_cache_page((void *)addr);
> >>       else
> >> @@ -825,6 +843,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
> >>
> >>  static void r4k_flush_cache_sigtramp(unsigned long addr)
> >>  {
> >> +     if (cpu_has_coherent_cache)
> >> +             return;
> >> +
> >>       r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
> >>  }
> >>
> >> --
> >> 2.4.6
> >>
> >>
> >>
> >>
> >>

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWqKbtAAoJEGwLaZPeOHZ6ALEP/Rtd4cu0HdivOIGzyGYVJYll
PpK4fDeiUkfpqx2NZyb2cnQhXbioMDfKvrRYZkpBMSld7cAkbLPJ8AhnvIfAoTuX
dXM9YgFjwOn3C0lErr7O5eOBG7oOKIiJuvoNBliTwv8SH2/enfoAecwdR4NhFO3Y
X/2+ZOaieVetGcq5/Y+Np6cbibSbigYm8RbLvOUKDMmm/Ls8adFRXLZdQeRijIdq
CiiNtqgFi/nBCxsc1L2iouJbCDHdKJKIi75bAwWbGIgHkRRt0pwrjdd0vS1Y8Qh1
+vgxc9Q9bEcXSvrmFwZrUJ8WSh9suLttPQrhb4bFOvbBBX5bwAWVcikWH+j04DdE
upwizBHw4v+Stp8BMxnK8FiLBf1ufcrjiUszx7c86blV0jMGKXz6u3QYxyCF6+Pu
ZkaCx7eAT/FXeFcyI80fsotpaLQSyVxabUeadStNxz3WDqveS5JWfRkCDZJJduLl
68vD0Z0JlD/eUWLUzKTQM0dVj1IoEB8KjuHY+o1fpe2d2Pcg4hzMgTQ/6Cy/u9oI
WBEblQW/nSFLjwAsbiD07uFiIl50BHb/ZsiHsVJzTfsc2bfBNn4aWTzGQCWvuSR1
HEn49kr/3W0cLc2kQi0Ip8Ck8AkBU2k8iFtwZzjHcqJ8fGVlBvhYoLs05e6Ybk8Q
81cE6qIP8N/5/+SxEmwy
=mo88
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
