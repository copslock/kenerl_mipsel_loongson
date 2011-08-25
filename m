Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2011 01:45:28 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:45168 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493797Ab1HYXpY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2011 01:45:24 +0200
Received: by vws8 with SMTP id 8so2982305vws.36
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 16:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=ak6GK0p3IOK6/jG35LxfcuMlVTcC8cfYq3/ggFRHZxc=;
        b=VE+99aIfe5q/bbx9+hJ8C/WgZUJJ32hkWQflrNW01+xVwXuGon8a7AdJ1aClCxyFKD
         j7V7eEoZO6CdQxWvx8u6p6VbT7ASGJl7ujSJWtt/jwsL8eddm4LcsOEy7fzTs63Tawz0
         ekSSF869v5TpbGDlwwMDvPacRwHbZq0LxGe+g=
Received: by 10.52.71.41 with SMTP id r9mr403079vdu.289.1314315918194; Thu, 25
 Aug 2011 16:45:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.156.131 with HTTP; Thu, 25 Aug 2011 16:44:57 -0700 (PDT)
In-Reply-To: <20110825080054.GA10459@mails.so.argh.org>
References: <20110821010513.GZ2657@mails.so.argh.org> <20110825080054.GA10459@mails.so.argh.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 25 Aug 2011 19:44:57 -0400
Message-ID: <CAEdQ38Ft-okTSUxhXXkZPhr1z46b480CtBu+LtVRcyQLACS3tA@mail.gmail.com>
Subject: Re: [PATCH] mips/loongson: unify compiler flags and load location for
 Loongson 2E and 2F
To:     Andreas Barth <aba@not.so.argh.org>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
Content-Type: multipart/mixed; boundary=20cf307f32606d3a0304ab5d0593
X-archive-position: 30993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19494

--20cf307f32606d3a0304ab5d0593
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Aug 25, 2011 at 4:00 AM, Andreas Barth <aba@not.so.argh.org> wrote:
> This patch starts to merge the Loongson 2E and 2F code together with the
> goal to produce a binary kernel image that can run on both machines. As
> code compiled for 2E cannot run on 2F and vice versa, the usage of cpu
> dependend code is optionally now (and old behaviour is default).
>
> The load address is unified as well, and the 2F workarounds can be enabled
> while compiling on a 2E machine (disabled there by default).
>
> Signed-off-by: Andreas Barth <aba@not.so.argh.org>

I think we can simplify this a bit. How about something like what I've
attached? (I didn't touch the load location stuff)

Thanks,
Matt

--20cf307f32606d3a0304ab5d0593
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-mips-loongson-unify-compiler-flags.patch"
Content-Disposition: attachment; 
	filename="0001-mips-loongson-unify-compiler-flags.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grsdpy4n0

RnJvbSA1ODcyOGFlOThhMDBkMDMyY2MzNjdjYWZiNzk0MDBmMDI0YTM2YmFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXR0IFR1cm5lciA8bWF0dHN0ODhAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDI1IEF1ZyAyMDExIDE5OjM5OjQzIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gbWlwcy9s
b29uZ3NvbjogdW5pZnkgY29tcGlsZXIgZmxhZ3MKClRoaXMgcGF0Y2ggc3RhcnRzIHRvIG1lcmdl
IHRoZSBMb29uZ3NvbiAyRSBhbmQgMkYgY29kZSB0b2dldGhlciB3aXRoIHRoZQpnb2FsIHRvIHBy
b2R1Y2UgYSBiaW5hcnkga2VybmVsIGltYWdlIHRoYXQgY2FuIHJ1biBvbiBib3RoIG1hY2hpbmVz
LiBBcwpjb2RlIGNvbXBpbGVkIGZvciAyRSBjYW5ub3QgcnVuIG9uIDJGIGFuZCB2aWNlIHZlcnNh
LCB0aGUgdXNhZ2Ugb2YgQ1BVCmRlcGVuZGVudCBjb2RlIGlzIG9wdGlvbmFsIG5vdyAoYW5kIG9s
ZCBiZWhhdmlvdXIgaXMgZGVmYXVsdCkuCgpTaWduZWQtb2ZmLWJ5OiBNYXR0IFR1cm5lciA8bWF0
dHN0ODhAZ21haWwuY29tPgotLS0KIGFyY2gvbWlwcy9LY29uZmlnICAgICAgICAgICB8ICAgMTIg
KysrKysrKysrKy0tCiBhcmNoL21pcHMvbG9vbmdzb24vUGxhdGZvcm0gfCAgIDE0ICsrKysrKysr
KysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL0tjb25maWcgYi9hcmNoL21pcHMvS2NvbmZpZwppbmRl
eCAxNzdjZGFmLi42ZmY2ODEzIDEwMDY0NAotLS0gYS9hcmNoL21pcHMvS2NvbmZpZworKysgYi9h
cmNoL21pcHMvS2NvbmZpZwpAQCAtMTE2Niw2ICsxMTY2LDE0IEBAIGNob2ljZQogCXByb21wdCAi
Q1BVIHR5cGUiCiAJZGVmYXVsdCBDUFVfUjRYMDAKIAorY29uZmlnIENQVV9MT09OR1NPTjJfR0VO
RVJJQworCWJvb2wgIkxvb25nc29uIDIgKGdlbmVyaWMpIgorCWRlcGVuZHMgb24gU1lTX0hBU19D
UFVfTE9PTkdTT04yRSB8fCBTWVNfSEFTX0xPT05HU09OMkYKKwlzZWxlY3QgQ1BVX0xPT05HU09O
MgorCWhlbHAKKwkgIFRoZSBMb29uZ3NvbiAyIHByb2Nlc3NvciBpbXBsZW1lbnRzIHRoZSBNSVBT
IElJSSBpbnN0cnVjdGlvbiBzZXQKKwkgIHdpdGggbWFueSBleHRlbnNpb25zLgorCiBjb25maWcg
Q1BVX0xPT05HU09OMkUKIAlib29sICJMb29uZ3NvbiAyRSIKIAlkZXBlbmRzIG9uIFNZU19IQVNf
Q1BVX0xPT05HU09OMkUKQEAgLTE0NzUsNyArMTQ4Myw3IEBAIGNvbmZpZyBDUFVfWExSCiAJICBO
ZXRsb2dpYyBNaWNyb3N5c3RlbXMgWExSL1hMUyBwcm9jZXNzb3JzLgogZW5kY2hvaWNlCiAKLWlm
IENQVV9MT09OR1NPTjJGCitpZiBDUFVfTE9PTkdTT04yCiBjb25maWcgQ1BVX05PUF9XT1JLQVJP
VU5EUwogCWJvb2wKIApAQCAtMTUwMCw3ICsxNTA4LDcgQEAgY29uZmlnIENQVV9MT09OR1NPTjJG
X1dPUktBUk9VTkRTCiAJICBzeXN0ZW1zLgogCiAJICBJZiB1bnN1cmUsIHBsZWFzZSBzYXkgWS4K
LWVuZGlmICMgQ1BVX0xPT05HU09OMkYKK2VuZGlmICMgQ1BVX0xPT05HU09OMgogCiBjb25maWcg
U1lTX1NVUFBPUlRTX1pCT09UCiAJYm9vbApkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2xvb25nc29u
L1BsYXRmb3JtIGIvYXJjaC9taXBzL2xvb25nc29uL1BsYXRmb3JtCmluZGV4IDI5NjkyZTUuLjRh
MTRlMzkgMTAwNjQ0Ci0tLSBhL2FyY2gvbWlwcy9sb29uZ3Nvbi9QbGF0Zm9ybQorKysgYi9hcmNo
L21pcHMvbG9vbmdzb24vUGxhdGZvcm0KQEAgLTQsMTAgKzQsMjAgQEAKIAogIyBPbmx5IGdjYyA+
PSA0LjQgaGF2ZSBMb29uZ3NvbiBzcGVjaWZpYyBzdXBwb3J0CiBjZmxhZ3MtJChDT05GSUdfQ1BV
X0xPT05HU09OMikJKz0gLVdhLC0tdHJhcAotY2ZsYWdzLSQoQ09ORklHX0NQVV9MT09OR1NPTjJF
KSArPSBcCitpZmRlZiBDT05GSUdfQ1BVX0xPT05HU09OMkUKKyAgY2ZsYWdzLSQoQ09ORklHX0NQ
VV9MT09OR1NPTjJFKSArPSBcCiAJJChjYWxsIGNjLW9wdGlvbiwtbWFyY2g9bG9vbmdzb24yZSwt
bWFyY2g9cjQ2MDApCi1jZmxhZ3MtJChDT05GSUdfQ1BVX0xPT05HU09OMkYpICs9IFwKK2Vsc2UK
KyAgaWZkZWYgQ09ORklHX0NQVV9MT09OR1NPTjJGCisgICAgY2ZsYWdzLSQoQ09ORklHX0NQVV9M
T09OR1NPTjJGKSArPSBcCiAJJChjYWxsIGNjLW9wdGlvbiwtbWFyY2g9bG9vbmdzb24yZiwtbWFy
Y2g9cjQ2MDApCisgIGVsc2UKKyAgICBpZmRlZiBDT05GSUdfQ1BVX0xPT05HU09OCisgICAgICBj
ZmxhZ3MtJChDT05GSUdfQ1BVX0xPT05HU09OMikgKz0gXAorCSQoY2FsbCBjYy1vcHRpb24sLW1h
cmNoPXI0NjAwKQorICAgIGVuZGlmCisgIGVuZGlmCitlbmRpZgogIyBFbmFibGUgdGhlIHdvcmth
cm91bmRzIGZvciBMb29uZ3NvbjJmCiBpZmRlZiBDT05GSUdfQ1BVX0xPT05HU09OMkZfV09SS0FS
T1VORFMKICAgaWZlcSAoJChjYWxsIGFzLW9wdGlvbiwtV2EkKGNvbW1hKS1tZml4LWxvb25nc29u
MmYtbm9wLCksKQotLSAKMS43LjMuNAoK
--20cf307f32606d3a0304ab5d0593--
