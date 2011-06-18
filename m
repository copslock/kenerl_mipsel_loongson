Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Jun 2011 12:51:58 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:41493 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490969Ab1FRKvw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Jun 2011 12:51:52 +0200
Received: by bwz1 with SMTP id 1so2205801bwz.36
        for <multiple recipients>; Sat, 18 Jun 2011 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2ieEcTLwqIDKvwHNwO0Zzj3x1KMY9MgMS9rCOZhZV/I=;
        b=lz+ZiZvwN13zw+3GYn3bTI+8v0SuG8mpyplu4InNWRK5jJQc27xcGkzafso+kHhVkd
         gkoUhW8odoB56Kx5YER3FQuSM8iIsvOFhoTDspeX6EEeri1iB/Jxezw8E7+fQtW4K5tJ
         ceAwZ4UnJr6GjPUShIpJQszjVhjTqBvK1yftY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jGa2xv0kJ3r8U5AtZ6X4Dyw+mOL4Yl3epGrZcYT/EgnqVUoky/L16ljb5r7Tf0eH66
         3ceUczcVu9MmLLWzTDhCzAxsgyNKB+niBIhXKdP7Df//deCPuJij/Kv0ivb/dZuEv9QE
         ul2bJrcFwtdTRVY7ys1pjPkIbvkxj3UqJOUMU=
MIME-Version: 1.0
Received: by 10.204.20.134 with SMTP id f6mr2357693bkb.165.1308394306636; Sat,
 18 Jun 2011 03:51:46 -0700 (PDT)
Received: by 10.204.64.68 with HTTP; Sat, 18 Jun 2011 03:51:46 -0700 (PDT)
In-Reply-To: <20110617152028.GA14107@linux-mips.org>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
        <20110325172709.GC8483@linux-mips.org>
        <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com>
        <20110616180250.GA13025@lst.de>
        <20110617152028.GA14107@linux-mips.org>
Date:   Sat, 18 Jun 2011 16:21:46 +0530
Message-ID: <BANLkTimvOaCHHuFr_dS7egYQgC0WhwEuWA@mail.gmail.com>
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
Content-Type: multipart/mixed; boundary=000325559986df8c9d04a5fa490b
X-archive-position: 30433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15128

--000325559986df8c9d04a5fa490b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks Ralf for your patch,

My target is MIPS 34Kc, and I check your patch , Since my target
machine is on 2.6.35, so I need to do small modification, I am
attaching my patch for reference.

Modification done.
1.  r4k_on_each_cpu(local_r4k_flush_kernel_vmap_range, &args); ->
r4k_on_each_cpu(local_r4k_flush_kernel_vmap_range, &args,1);
2. My target is enabled with High mem, so I modify like below, if
there is any problem with below code pls let me know.

static inline void flush_kernel_dcache_page(struct page *page)
{
       /* BUG_ON(cpu_has_dc_aliases && PageHighMem(page)); */
       if(cpu_has_dc_aliases && !PageHighMem(page))
                 __flush_kernel_vmap_range((unsigned
long)page_address(page), PAGE_SIZE);
}


with above modification this works fine for me.

Regards
Naveen

On Fri, Jun 17, 2011 at 8:50 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jun 16, 2011 at 08:02:50PM +0200, Christoph Hellwig wrote:
>
>> Ralf,
>>
>> I'll second that request. =A0We'll really need this, right now embedded =
XFS
>> users are hacking around it in horrible ways.
>
> Here's my shot at the problem. =A0I don't have the time to setup a XFS
> filesystem and tools for testing before the weekend so all I claim is thi=
s
> patch builds for R4000-class CPUs but it should be pretty close to the
> real thing.
>
> Naveen, can you give this patch a spin? =A0Thanks!
>
> =A0Ralf
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
> =A0arch/mips/include/asm/cacheflush.h | =A0 24 ++++++++++++++++++++++++
> =A0arch/mips/mm/c-octeon.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 ++++++
> =A0arch/mips/mm/c-r3k.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A07 +++++++
> =A0arch/mips/mm/c-r4k.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 35 ++++++++++++=
+++++++++++++++++++++++
> =A0arch/mips/mm/c-tx39.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 +++++++
> =A0arch/mips/mm/cache.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +++++
> =A06 files changed, 84 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/c=
acheflush.h
> index 40bb9fd..69468de 100644
> --- a/arch/mips/include/asm/cacheflush.h
> +++ b/arch/mips/include/asm/cacheflush.h
> @@ -114,4 +114,28 @@ unsigned long run_uncached(void *func);
> =A0extern void *kmap_coherent(struct page *page, unsigned long addr);
> =A0extern void kunmap_coherent(void);
>
> +#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
> +static inline void flush_kernel_dcache_page(struct page *page)
> +{
> + =A0 =A0 =A0 BUG_ON(cpu_has_dc_aliases && PageHighMem(page));
> +}
> +
> +/*
> + * For now flush_kernel_vmap_range and invalidate_kernel_vmap_range both=
 do a
> + * cache writeback and invalidate operation.
> + */
> +extern void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
> +
> +static inline void flush_kernel_vmap_range(void *vaddr, int size)
> +{
> + =A0 =A0 =A0 if (cpu_has_dc_aliases)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __flush_kernel_vmap_range((unsigned long) v=
addr, size);
> +}
> +
> +static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> +{
> + =A0 =A0 =A0 if (cpu_has_dc_aliases)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __flush_kernel_vmap_range((unsigned long) v=
addr, size);
> +}
> +
> =A0#endif /* _ASM_CACHEFLUSH_H */
> diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
> index 16c4d25..daa81f7 100644
> --- a/arch/mips/mm/c-octeon.c
> +++ b/arch/mips/mm/c-octeon.c
> @@ -169,6 +169,10 @@ static void octeon_flush_cache_page(struct vm_area_s=
truct *vma,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0octeon_flush_icache_all_cores(vma);
> =A0}
>
> +static void octeon_flush_kernel_vmap_range(unsigned long vaddr, int size=
)
> +{
> + =A0 =A0 =A0 BUG();
> +}
>
> =A0/**
> =A0* Probe Octeon's caches
> @@ -273,6 +277,8 @@ void __cpuinit octeon_cache_init(void)
> =A0 =A0 =A0 =A0flush_icache_range =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D octeon_f=
lush_icache_range;
> =A0 =A0 =A0 =A0local_flush_icache_range =A0 =A0 =A0 =A0=3D local_octeon_f=
lush_icache_range;
>
> + =A0 =A0 =A0 __flush_kernel_vmap_range =A0 =A0 =A0 =3D octeon_flush_kern=
el_vmap_range;
> +
> =A0 =A0 =A0 =A0build_clear_page();
> =A0 =A0 =A0 =A0build_copy_page();
> =A0}
> diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
> index e6b0efd..0765583 100644
> --- a/arch/mips/mm/c-r3k.c
> +++ b/arch/mips/mm/c-r3k.c
> @@ -299,6 +299,11 @@ static void r3k_flush_cache_sigtramp(unsigned long a=
ddr)
> =A0 =A0 =A0 =A0write_c0_status(flags);
> =A0}
>
> +static void r3k_flush_kernel_vmap_range(unsigned long vaddr, int size)
> +{
> + =A0 =A0 =A0 BUG();
> +}
> +
> =A0static void r3k_dma_cache_wback_inv(unsigned long start, unsigned long=
 size)
> =A0{
> =A0 =A0 =A0 =A0/* Catch bad driver code */
> @@ -323,6 +328,8 @@ void __cpuinit r3k_cache_init(void)
> =A0 =A0 =A0 =A0flush_icache_range =3D r3k_flush_icache_range;
> =A0 =A0 =A0 =A0local_flush_icache_range =3D r3k_flush_icache_range;
>
> + =A0 =A0 =A0 __flush_kernel_vmap_range =3D r3k_flush_kernel_vmap_range;
> +
> =A0 =A0 =A0 =A0flush_cache_sigtramp =3D r3k_flush_cache_sigtramp;
> =A0 =A0 =A0 =A0local_flush_data_cache_page =3D local_r3k_flush_data_cache=
_page;
> =A0 =A0 =A0 =A0flush_data_cache_page =3D r3k_flush_data_cache_page;
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index eeb642e..38a593e 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -718,6 +718,39 @@ static void r4k_flush_icache_all(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r4k_blast_icache();
> =A0}
>
> +struct flush_kernel_vmap_range_args {
> + =A0 =A0 =A0 unsigned long =A0 vaddr;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 size;
> +};
> +
> +static inline void local_r4k_flush_kernel_vmap_range(void *args)
> +{
> + =A0 =A0 =A0 struct flush_kernel_vmap_range_args *vmra =3D args;
> + =A0 =A0 =A0 unsigned long vaddr =3D vmra->vaddr;
> + =A0 =A0 =A0 int size =3D vmra->size;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Aliases only affect the primary caches so don't bother=
 with
> + =A0 =A0 =A0 =A0* S-caches or T-caches.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (cpu_has_safe_index_cacheops && size >=3D dcache_size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_dcache();
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 R4600_HIT_CACHEOP_WAR_IMPL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blast_dcache_range(vaddr, vaddr + size);
> + =A0 =A0 =A0 }
> +}
> +
> +static void r4k_flush_kernel_vmap_range(unsigned long vaddr, int size)
> +{
> + =A0 =A0 =A0 struct flush_kernel_vmap_range_args args;
> +
> + =A0 =A0 =A0 args.vaddr =3D (unsigned long) vaddr;
> + =A0 =A0 =A0 args.size =3D size;
> +
> + =A0 =A0 =A0 r4k_on_each_cpu(local_r4k_flush_kernel_vmap_range, &args);
> +}
> +
> =A0static inline void rm7k_erratum31(void)
> =A0{
> =A0 =A0 =A0 =A0const unsigned long ic_lsize =3D 32;
> @@ -1399,6 +1432,8 @@ void __cpuinit r4k_cache_init(void)
> =A0 =A0 =A0 =A0flush_cache_page =A0 =A0 =A0 =A0=3D r4k_flush_cache_page;
> =A0 =A0 =A0 =A0flush_cache_range =A0 =A0 =A0 =3D r4k_flush_cache_range;
>
> + =A0 =A0 =A0 __flush_kernel_vmap_range =3D r4k_flush_kernel_vmap_range;
> +
> =A0 =A0 =A0 =A0flush_cache_sigtramp =A0 =A0=3D r4k_flush_cache_sigtramp;
> =A0 =A0 =A0 =A0flush_icache_all =A0 =A0 =A0 =A0=3D r4k_flush_icache_all;
> =A0 =A0 =A0 =A0local_flush_data_cache_page =A0 =A0 =3D local_r4k_flush_da=
ta_cache_page;
> diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
> index d352fad..a43c197c 100644
> --- a/arch/mips/mm/c-tx39.c
> +++ b/arch/mips/mm/c-tx39.c
> @@ -253,6 +253,11 @@ static void tx39_flush_icache_range(unsigned long st=
art, unsigned long end)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static void tx39_flush_kernel_vmap_range(unsigned long vaddr, int size)
> +{
> + =A0 =A0 =A0 BUG();
> +}
> +
> =A0static void tx39_dma_cache_wback_inv(unsigned long addr, unsigned long=
 size)
> =A0{
> =A0 =A0 =A0 =A0unsigned long end;
> @@ -394,6 +399,8 @@ void __cpuinit tx39_cache_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flush_icache_range =3D tx39_flush_icache_r=
ange;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local_flush_icache_range =3D tx39_flush_ic=
ache_range;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __flush_kernel_vmap_range =3D tx39_flush_ke=
rnel_vmap_range;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flush_cache_sigtramp =3D tx39_flush_cache_=
sigtramp;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local_flush_data_cache_page =3D local_tx39=
_flush_data_cache_page;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flush_data_cache_page =3D tx39_flush_data_=
cache_page;
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 12af739..829320c 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -35,6 +35,11 @@ void (*local_flush_icache_range)(unsigned long start, =
unsigned long end);
> =A0void (*__flush_cache_vmap)(void);
> =A0void (*__flush_cache_vunmap)(void);
>
> +void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
> +void (*__invalidate_kernel_vmap_range)(unsigned long vaddr, int size);
> +
> +EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
> +
> =A0/* MIPS specific cache operations */
> =A0void (*flush_cache_sigtramp)(unsigned long addr);
> =A0void (*local_flush_data_cache_page)(void * addr);
>

--000325559986df8c9d04a5fa490b
Content-Type: application/octet-stream; name="vmap_range.patch"
Content-Disposition: attachment; filename="vmap_range.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gp2g58qt0

ZGlmZiAtTnVycCBsaW51eC0yLjYuMzUuMTNfb3JnL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9jYWNo
ZWZsdXNoLmggbGludXgtMi42LjM1LjEzL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9jYWNoZWZsdXNo
LmgKLS0tIGxpbnV4LTIuNi4zNS4xM19vcmcvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2NhY2hlZmx1
c2guaAkyMDEwLTExLTIzIDA0OjAxOjI2LjAwMDAwMDAwMCArMDkwMAorKysgbGludXgtMi42LjM1
LjEzL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9jYWNoZWZsdXNoLmgJMjAxMS0wNi0xNyAxMzo1MTo0
OC4wMDAwMDAwMDAgKzA5MDAKQEAgLTExMyw1ICsxMTMsMzMgQEAgdW5zaWduZWQgbG9uZyBydW5f
dW5jYWNoZWQodm9pZCAqZnVuYyk7CiAKIGV4dGVybiB2b2lkICprbWFwX2NvaGVyZW50KHN0cnVj
dCBwYWdlICpwYWdlLCB1bnNpZ25lZCBsb25nIGFkZHIpOwogZXh0ZXJuIHZvaWQga3VubWFwX2Nv
aGVyZW50KHZvaWQpOworI2RlZmluZSBBUkNIX0hBU19GTFVTSF9LRVJORUxfRENBQ0hFX1BBR0UK
KworLyoKKyAqIEZvciBub3cgZmx1c2hfa2VybmVsX3ZtYXBfcmFuZ2UgYW5kIGludmFsaWRhdGVf
a2VybmVsX3ZtYXBfcmFuZ2UgYm90aCBkbyBhCisgKiBjYWNoZSB3cml0ZWJhY2sgYW5kIGludmFs
aWRhdGUgb3BlcmF0aW9uLgorICovCitleHRlcm4gdm9pZCAoKl9fZmx1c2hfa2VybmVsX3ZtYXBf
cmFuZ2UpKHVuc2lnbmVkIGxvbmcgdmFkZHIsIGludCBzaXplKTsKKworc3RhdGljIGlubGluZSB2
b2lkIGZsdXNoX2tlcm5lbF9kY2FjaGVfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkKK3sKKyAgICAg
ICAvL0JVR19PTihjcHVfaGFzX2RjX2FsaWFzZXMgJiYgUGFnZUhpZ2hNZW0ocGFnZSkpOworICAg
ICAgIGlmKGNwdV9oYXNfZGNfYWxpYXNlcyAmJiAhUGFnZUhpZ2hNZW0ocGFnZSkpCisJICAgCSAg
X19mbHVzaF9rZXJuZWxfdm1hcF9yYW5nZSgodW5zaWduZWQgbG9uZylwYWdlX2FkZHJlc3MocGFn
ZSksIFBBR0VfU0laRSk7Cit9CisKKworCitzdGF0aWMgaW5saW5lIHZvaWQgZmx1c2hfa2VybmVs
X3ZtYXBfcmFuZ2Uodm9pZCAqdmFkZHIsIGludCBzaXplKQoreworICAgICAgIGlmIChjcHVfaGFz
X2RjX2FsaWFzZXMpCisgICAgICAgICAgICAgICBfX2ZsdXNoX2tlcm5lbF92bWFwX3JhbmdlKCh1
bnNpZ25lZCBsb25nKSB2YWRkciwgc2l6ZSk7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBpbnZh
bGlkYXRlX2tlcm5lbF92bWFwX3JhbmdlKHZvaWQgKnZhZGRyLCBpbnQgc2l6ZSkKK3sKKyAgICAg
ICBpZiAoY3B1X2hhc19kY19hbGlhc2VzKQorICAgICAgICAgICAgICAgX19mbHVzaF9rZXJuZWxf
dm1hcF9yYW5nZSgodW5zaWduZWQgbG9uZykgdmFkZHIsIHNpemUpOworfQogCiAjZW5kaWYgLyog
X0FTTV9DQUNIRUZMVVNIX0ggKi8KZGlmZiAtTnVycCBsaW51eC0yLjYuMzUuMTNfb3JnL2FyY2gv
bWlwcy9tbS9jYWNoZS5jIGxpbnV4LTIuNi4zNS4xMy9hcmNoL21pcHMvbW0vY2FjaGUuYwotLS0g
bGludXgtMi42LjM1LjEzX29yZy9hcmNoL21pcHMvbW0vY2FjaGUuYwkyMDExLTAzLTMwIDE0OjA5
OjExLjAwMDAwMDAwMCArMDkwMAorKysgbGludXgtMi42LjM1LjEzL2FyY2gvbWlwcy9tbS9jYWNo
ZS5jCTIwMTEtMDYtMTcgMTM6MDc6MzcuMDAwMDAwMDAwICswOTAwCkBAIC0zMiw2ICszMiwxMSBA
QCB2b2lkICgqZmx1c2hfY2FjaGVfcGFnZSkoc3RydWN0IHZtX2FyZWFfCiB2b2lkICgqZmx1c2hf
aWNhY2hlX3JhbmdlKSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCk7CiB2
b2lkICgqbG9jYWxfZmx1c2hfaWNhY2hlX3JhbmdlKSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNp
Z25lZCBsb25nIGVuZCk7CiAKK3ZvaWQgKCpfX2ZsdXNoX2tlcm5lbF92bWFwX3JhbmdlKSh1bnNp
Z25lZCBsb25nIHZhZGRyLCBpbnQgc2l6ZSk7Cit2b2lkICgqX19pbnZhbGlkYXRlX2tlcm5lbF92
bWFwX3JhbmdlKSh1bnNpZ25lZCBsb25nIHZhZGRyLCBpbnQgc2l6ZSk7CisKK0VYUE9SVF9TWU1C
T0xfR1BMKF9fZmx1c2hfa2VybmVsX3ZtYXBfcmFuZ2UpOworCiB2b2lkICgqX19mbHVzaF9jYWNo
ZV92bWFwKSh2b2lkKTsKIHZvaWQgKCpfX2ZsdXNoX2NhY2hlX3Z1bm1hcCkodm9pZCk7CiAKZGlm
ZiAtTnVycCBsaW51eC0yLjYuMzUuMTNfb3JnL2FyY2gvbWlwcy9tbS9jLW9jdGVvbi5jIGxpbnV4
LTIuNi4zNS4xMy9hcmNoL21pcHMvbW0vYy1vY3Rlb24uYwotLS0gbGludXgtMi42LjM1LjEzX29y
Zy9hcmNoL21pcHMvbW0vYy1vY3Rlb24uYwkyMDEwLTExLTIzIDA0OjAxOjI2LjAwMDAwMDAwMCAr
MDkwMAorKysgbGludXgtMi42LjM1LjEzL2FyY2gvbWlwcy9tbS9jLW9jdGVvbi5jCTIwMTEtMDYt
MTcgMTM6MDE6MzYuMDAwMDAwMDAwICswOTAwCkBAIC0xNjksNiArMTY5LDExIEBAIHN0YXRpYyB2
b2lkIG9jdGVvbl9mbHVzaF9jYWNoZV9wYWdlKHN0cnUKIAkJb2N0ZW9uX2ZsdXNoX2ljYWNoZV9h
bGxfY29yZXModm1hKTsKIH0KIAorc3RhdGljIHZvaWQgb2N0ZW9uX2ZsdXNoX2tlcm5lbF92bWFw
X3JhbmdlKHVuc2lnbmVkIGxvbmcgdmFkZHIsIGludCBzaXplKQoreworICAgICAgIEJVRygpOwor
fQorCiAKIC8qKgogICogUHJvYmUgT2N0ZW9uJ3MgY2FjaGVzCkBAIC0yNTgsNiArMjYzLDcgQEAg
dm9pZCBfX2NwdWluaXQgb2N0ZW9uX2NhY2hlX2luaXQodm9pZCkKIAlmbHVzaF9kYXRhX2NhY2hl
X3BhZ2UJCT0gb2N0ZW9uX2ZsdXNoX2RhdGFfY2FjaGVfcGFnZTsKIAlmbHVzaF9pY2FjaGVfcmFu
Z2UJCT0gb2N0ZW9uX2ZsdXNoX2ljYWNoZV9yYW5nZTsKIAlsb2NhbF9mbHVzaF9pY2FjaGVfcmFu
Z2UJPSBsb2NhbF9vY3Rlb25fZmx1c2hfaWNhY2hlX3JhbmdlOworCV9fZmx1c2hfa2VybmVsX3Zt
YXBfcmFuZ2UgICAgICAgPSBvY3Rlb25fZmx1c2hfa2VybmVsX3ZtYXBfcmFuZ2U7CiAKIAlidWls
ZF9jbGVhcl9wYWdlKCk7CiAJYnVpbGRfY29weV9wYWdlKCk7CmRpZmYgLU51cnAgbGludXgtMi42
LjM1LjEzX29yZy9hcmNoL21pcHMvbW0vYy1yM2suYyBsaW51eC0yLjYuMzUuMTMvYXJjaC9taXBz
L21tL2MtcjNrLmMKLS0tIGxpbnV4LTIuNi4zNS4xM19vcmcvYXJjaC9taXBzL21tL2MtcjNrLmMJ
MjAxMC0xMS0yMyAwNDowMToyNi4wMDAwMDAwMDAgKzA5MDAKKysrIGxpbnV4LTIuNi4zNS4xMy9h
cmNoL21pcHMvbW0vYy1yM2suYwkyMDExLTA2LTE3IDEzOjAzOjI2LjAwMDAwMDAwMCArMDkwMApA
QCAtMjk5LDYgKzI5OSwxMiBAQCBzdGF0aWMgdm9pZCByM2tfZmx1c2hfY2FjaGVfc2lndHJhbXAo
dW5zCiAJd3JpdGVfYzBfc3RhdHVzKGZsYWdzKTsKIH0KIAorc3RhdGljIHZvaWQgcjNrX2ZsdXNo
X2tlcm5lbF92bWFwX3JhbmdlKHVuc2lnbmVkIGxvbmcgdmFkZHIsIGludCBzaXplKQoreworICAg
ICAgIEJVRygpOworfQorCisKIHN0YXRpYyB2b2lkIHIza19kbWFfY2FjaGVfd2JhY2tfaW52KHVu
c2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxvbmcgc2l6ZSkKIHsKIAkvKiBDYXRjaCBiYWQg
ZHJpdmVyIGNvZGUgKi8KQEAgLTMyMiw3ICszMjgsNyBAQCB2b2lkIF9fY3B1aW5pdCByM2tfY2Fj
aGVfaW5pdCh2b2lkKQogCWZsdXNoX2NhY2hlX3BhZ2UgPSByM2tfZmx1c2hfY2FjaGVfcGFnZTsK
IAlmbHVzaF9pY2FjaGVfcmFuZ2UgPSByM2tfZmx1c2hfaWNhY2hlX3JhbmdlOwogCWxvY2FsX2Zs
dXNoX2ljYWNoZV9yYW5nZSA9IHIza19mbHVzaF9pY2FjaGVfcmFuZ2U7Ci0KKwlfX2ZsdXNoX2tl
cm5lbF92bWFwX3JhbmdlID0gcjNrX2ZsdXNoX2tlcm5lbF92bWFwX3JhbmdlOwogCWZsdXNoX2Nh
Y2hlX3NpZ3RyYW1wID0gcjNrX2ZsdXNoX2NhY2hlX3NpZ3RyYW1wOwogCWxvY2FsX2ZsdXNoX2Rh
dGFfY2FjaGVfcGFnZSA9IGxvY2FsX3Iza19mbHVzaF9kYXRhX2NhY2hlX3BhZ2U7CiAJZmx1c2hf
ZGF0YV9jYWNoZV9wYWdlID0gcjNrX2ZsdXNoX2RhdGFfY2FjaGVfcGFnZTsKZGlmZiAtTnVycCBs
aW51eC0yLjYuMzUuMTNfb3JnL2FyY2gvbWlwcy9tbS9jLXI0ay5jIGxpbnV4LTIuNi4zNS4xMy9h
cmNoL21pcHMvbW0vYy1yNGsuYwotLS0gbGludXgtMi42LjM1LjEzX29yZy9hcmNoL21pcHMvbW0v
Yy1yNGsuYwkyMDExLTAzLTMwIDE0OjA5OjExLjAwMDAwMDAwMCArMDkwMAorKysgbGludXgtMi42
LjM1LjEzL2FyY2gvbWlwcy9tbS9jLXI0ay5jCTIwMTEtMDYtMTcgMTM6MTc6MDAuMDAwMDAwMDAw
ICswOTAwCkBAIC03MTksNiArNzE5LDM5IEBAIHN0YXRpYyB2b2lkIHI0a19mbHVzaF9pY2FjaGVf
YWxsKHZvaWQpCiAJCXI0a19ibGFzdF9pY2FjaGUoKTsKIH0KIAorc3RydWN0IGZsdXNoX2tlcm5l
bF92bWFwX3JhbmdlX2FyZ3MgeworICAgICAgIHVuc2lnbmVkIGxvbmcgICB2YWRkcjsKKyAgICAg
ICBpbnQgICAgICAgICAgICAgc2l6ZTsKK307CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBsb2NhbF9y
NGtfZmx1c2hfa2VybmVsX3ZtYXBfcmFuZ2Uodm9pZCAqYXJncykKK3sKKyAgICAgICBzdHJ1Y3Qg
Zmx1c2hfa2VybmVsX3ZtYXBfcmFuZ2VfYXJncyAqdm1yYSA9IGFyZ3M7CisgICAgICAgdW5zaWdu
ZWQgbG9uZyB2YWRkciA9IHZtcmEtPnZhZGRyOworICAgICAgIGludCBzaXplID0gdm1yYS0+c2l6
ZTsKKworICAgICAgIC8qCisgICAgICAgICogQWxpYXNlcyBvbmx5IGFmZmVjdCB0aGUgcHJpbWFy
eSBjYWNoZXMgc28gZG9uJ3QgYm90aGVyIHdpdGgKKyAgICAgICAgKiBTLWNhY2hlcyBvciBULWNh
Y2hlcy4KKyAgICAgICAgKi8KKyAgICAgICBpZiAoY3B1X2hhc19zYWZlX2luZGV4X2NhY2hlb3Bz
ICYmIHNpemUgPj0gZGNhY2hlX3NpemUpCisgICAgICAgICAgICAgICByNGtfYmxhc3RfZGNhY2hl
KCk7CisgICAgICAgZWxzZSB7CisgICAgICAgICAgICAgICBSNDYwMF9ISVRfQ0FDSEVPUF9XQVJf
SU1QTDsKKyAgICAgICAgICAgICAgIGJsYXN0X2RjYWNoZV9yYW5nZSh2YWRkciwgdmFkZHIgKyBz
aXplKTsKKyAgICAgICB9Cit9CisKK3N0YXRpYyB2b2lkIHI0a19mbHVzaF9rZXJuZWxfdm1hcF9y
YW5nZSh1bnNpZ25lZCBsb25nIHZhZGRyLCBpbnQgc2l6ZSkKK3sKKyAgICAgICBzdHJ1Y3QgZmx1
c2hfa2VybmVsX3ZtYXBfcmFuZ2VfYXJncyBhcmdzOworCisgICAgICAgYXJncy52YWRkciA9ICh1
bnNpZ25lZCBsb25nKSB2YWRkcjsKKyAgICAgICBhcmdzLnNpemUgPSBzaXplOworCisgICAgICAg
cjRrX29uX2VhY2hfY3B1KGxvY2FsX3I0a19mbHVzaF9rZXJuZWxfdm1hcF9yYW5nZSwgJmFyZ3Ms
MSk7Cit9CisKIHN0YXRpYyBpbmxpbmUgdm9pZCBybTdrX2VycmF0dW0zMSh2b2lkKQogewogCWNv
bnN0IHVuc2lnbmVkIGxvbmcgaWNfbHNpemUgPSAzMjsKQEAgLTE0MDAsNyArMTQwMCw3IEBAIHZv
aWQgX19jcHVpbml0IHI0a19jYWNoZV9pbml0KHZvaWQpCiAJZmx1c2hfY2FjaGVfbW0JCT0gcjRr
X2ZsdXNoX2NhY2hlX21tOwogCWZsdXNoX2NhY2hlX3BhZ2UJPSByNGtfZmx1c2hfY2FjaGVfcGFn
ZTsKIAlmbHVzaF9jYWNoZV9yYW5nZQk9IHI0a19mbHVzaF9jYWNoZV9yYW5nZTsKLQorCV9fZmx1
c2hfa2VybmVsX3ZtYXBfcmFuZ2UgPSByNGtfZmx1c2hfa2VybmVsX3ZtYXBfcmFuZ2U7CiAJZmx1
c2hfY2FjaGVfc2lndHJhbXAJPSByNGtfZmx1c2hfY2FjaGVfc2lndHJhbXA7CiAJZmx1c2hfaWNh
Y2hlX2FsbAk9IHI0a19mbHVzaF9pY2FjaGVfYWxsOwogCWxvY2FsX2ZsdXNoX2RhdGFfY2FjaGVf
cGFnZQk9IGxvY2FsX3I0a19mbHVzaF9kYXRhX2NhY2hlX3BhZ2U7CmRpZmYgLU51cnAgbGludXgt
Mi42LjM1LjEzX29yZy9hcmNoL21pcHMvbW0vYy10eDM5LmMgbGludXgtMi42LjM1LjEzL2FyY2gv
bWlwcy9tbS9jLXR4MzkuYwotLS0gbGludXgtMi42LjM1LjEzX29yZy9hcmNoL21pcHMvbW0vYy10
eDM5LmMJMjAxMC0xMS0yMyAwNDowMToyNi4wMDAwMDAwMDAgKzA5MDAKKysrIGxpbnV4LTIuNi4z
NS4xMy9hcmNoL21pcHMvbW0vYy10eDM5LmMJMjAxMS0wNi0xNyAxMzowNjo1My4wMDAwMDAwMDAg
KzA5MDAKQEAgLTI1Myw2ICsyNTMsMTEgQEAgc3RhdGljIHZvaWQgdHgzOV9mbHVzaF9pY2FjaGVf
cmFuZ2UodW5zaQogCX0KIH0KIAorc3RhdGljIHZvaWQgdHgzOV9mbHVzaF9rZXJuZWxfdm1hcF9y
YW5nZSh1bnNpZ25lZCBsb25nIHZhZGRyLCBpbnQgc2l6ZSkKK3sKKyAgICAgICBCVUcoKTsKK30K
Kwogc3RhdGljIHZvaWQgdHgzOV9kbWFfY2FjaGVfd2JhY2tfaW52KHVuc2lnbmVkIGxvbmcgYWRk
ciwgdW5zaWduZWQgbG9uZyBzaXplKQogewogCXVuc2lnbmVkIGxvbmcgZW5kOwpAQCAtMzY0LDcg
KzM2OSw3IEBAIHZvaWQgX19jcHVpbml0IHR4MzlfY2FjaGVfaW5pdCh2b2lkKQogCQlmbHVzaF9j
YWNoZV9wYWdlCT0gKHZvaWQgKikgdHgzOWhfZmx1c2hfaWNhY2hlX2FsbDsKIAkJZmx1c2hfaWNh
Y2hlX3JhbmdlCT0gKHZvaWQgKikgdHgzOWhfZmx1c2hfaWNhY2hlX2FsbDsKIAkJbG9jYWxfZmx1
c2hfaWNhY2hlX3JhbmdlID0gKHZvaWQgKikgdHgzOWhfZmx1c2hfaWNhY2hlX2FsbDsKLQorCQlf
X2ZsdXNoX2tlcm5lbF92bWFwX3JhbmdlID0gdHgzOV9mbHVzaF9rZXJuZWxfdm1hcF9yYW5nZTsK
IAkJZmx1c2hfY2FjaGVfc2lndHJhbXAJPSAodm9pZCAqKSB0eDM5aF9mbHVzaF9pY2FjaGVfYWxs
OwogCQlsb2NhbF9mbHVzaF9kYXRhX2NhY2hlX3BhZ2UJPSAodm9pZCAqKSB0eDM5aF9mbHVzaF9p
Y2FjaGVfYWxsOwogCQlmbHVzaF9kYXRhX2NhY2hlX3BhZ2UJPSAodm9pZCAqKSB0eDM5aF9mbHVz
aF9pY2FjaGVfYWxsOwo=
--000325559986df8c9d04a5fa490b--
