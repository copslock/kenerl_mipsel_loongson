Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 08:28:35 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:48969 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491043Ab1FOG23 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 08:28:29 +0200
Received: by bwz1 with SMTP id 1so272513bwz.36
        for <multiple recipients>; Tue, 14 Jun 2011 23:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OZtB9ScxFq5XmiiB1X/kLCd7iQyNmw1ZXFiNzlUERUo=;
        b=Y3/o3rswiy14ohffXl+DfFkwoSQ8oL2plqFqFH25y6rSSsyr+E30uNuNzVdkLqID03
         BjXWsxoMT1+ssrRuHL6qAj0Nm3d7mEqng+cZlRsJa4n+33RfiZtwc+LwOOd1hn+OwpUi
         MlzRiJbRJLDfHM/vJMde/Izut664GUhkj1dfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hABKP2JwdDYzqyie6IoGn2F5GU2bWrqQJNdelzTr99t3YNvLMW4xsGe2lFc+qyuuVv
         W1lWWapI59yG/Q9GVK8jNfQGX7n2grzcevhB1jWxrqDRSS3qzwOfgFOJyatOU4O1Sg3u
         sC2aXy7xB5Kmyb+jPKljygR/X6oJ/Nt/HMhAY=
MIME-Version: 1.0
Received: by 10.204.84.166 with SMTP id j38mr125672bkl.84.1308119304208; Tue,
 14 Jun 2011 23:28:24 -0700 (PDT)
Received: by 10.204.64.68 with HTTP; Tue, 14 Jun 2011 23:28:24 -0700 (PDT)
In-Reply-To: <20110325172709.GC8483@linux-mips.org>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
        <20110325172709.GC8483@linux-mips.org>
Date:   Wed, 15 Jun 2011 11:58:24 +0530
Message-ID: <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com>
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Christoph Hellwig <hch@lst.de>
Content-Type: multipart/mixed; boundary=0016e6d9a16e73800e04a5ba427f
X-archive-position: 30396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12126

--0016e6d9a16e73800e04a5ba427f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Ralf Baechle,

I have made one patch for below API's for 2.6.35.9 kernel. Pls provide
me your feedback about this .

Regards

On Fri, Mar 25, 2011 at 10:57 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Mar 25, 2011 at 02:38:13PM +0530, naveen yadav wrote:
>
>> We are working on 2.6.35.9 linux kernel on MIPS 34kce core and our
>> cache is VIVT having cache aliasing .
>
> No, they're VIPT unless you successfully modified your 34K core to
> change it from a less than perfect cache design to the most lunatic
> cache policy known to man kind ...
>
>> When I check the implementation on ARM I can check the implemenation
>> exists , but there is not similar implementation exists on MIPS.
>> These API's are used by XFS module:
>>
>> static inline void flush_kernel_vmap_range(void *vaddr, int size)
>> static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
>> static inline void flush_kernel_dcache_page(struct page *page)
>
> A known problem for (too ...) long. =A0I'll finally take care of it.
>
> =A0Ralf
>

--0016e6d9a16e73800e04a5ba427f
Content-Type: application/octet-stream; name="mips_dma_api.patch"
Content-Disposition: attachment; filename="mips_dma_api.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_goxwf9ly0

ZGlmZiAtTnJ1cCBjbGVhbi9saW51eC0yLjYuMzUuOS9hcmNoL21pcHMvaW5jbHVkZS9hc20vY2Fj
aGVmbHVzaC5oIGxpbnV4LTIuNi4zNS45L2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9jYWNoZWZsdXNo
LmgKLS0tIGNsZWFuL2xpbnV4LTIuNi4zNS45L2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9jYWNoZWZs
dXNoLmgJMjAxMC0xMS0yMyAwNDowMToyNi4wMDAwMDAwMDAgKzA5MDAKKysrIGxpbnV4LTIuNi4z
NS45L2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9jYWNoZWZsdXNoLmgJMjAxMS0wNi0xNCAxMTowODox
Ni4wMDAwMDAwMDAgKzA5MDAKQEAgLTExNCw0ICsxMTQsMzEgQEAgdW5zaWduZWQgbG9uZyBydW5f
dW5jYWNoZWQodm9pZCAqZnVuYyk7CiBleHRlcm4gdm9pZCAqa21hcF9jb2hlcmVudChzdHJ1Y3Qg
cGFnZSAqcGFnZSwgdW5zaWduZWQgbG9uZyBhZGRyKTsKIGV4dGVybiB2b2lkIGt1bm1hcF9jb2hl
cmVudCh2b2lkKTsKIAorLyogTmV3IGZ1bmN0aW9uIGFkZGVkIHdoaWNoIGFyZSBtaXNzZWQgaW4g
IE1JUFMgKi8KKyNkZWZpbmUgQVJDSF9IQVNfRkxVU0hfS0VSTkVMX0RDQUNIRV9QQUdFCitzdGF0
aWMgaW5saW5lIHZvaWQgZmx1c2hfa2VybmVsX3ZtYXBfcmFuZ2Uodm9pZCAqYWRkciwgaW50IHNp
emUpCit7CisvKglpZiAoKGNhY2hlX2lzX3ZpdnQoKSB8fCBjYWNoZV9pc192aXB0X2FsaWFzaW5n
KCkpKSovCisJaWYgKChjLT5pY2FjaGUuZmxhZ3MgJiBNSVBTX0NBQ0hFX1ZUQUcpIHx8CVwKKwkJ
CShjLT5kY2FjaGUuZmxhZ3MgJiBNSVBTX0NBQ0hFX0FMSUFTRVMpKSB7CisJCQl1bnNpZ25lZCBs
b25nIHN0YXJ0ID0gKHVuc2lnbmVkIGxvbmcpYWRkcjsKKwkJCWRtYV9jYWNoZV93YmFja19pbnYo
c3RhcnQsIChzaXplX3Qpc2l6ZSk7CisJfQorfQorc3RhdGljIGlubGluZSB2b2lkIGludmFsaWRh
dGVfa2VybmVsX3ZtYXBfcmFuZ2Uodm9pZCAqYWRkciwgaW50IHNpemUpCit7CisvKglpZiAoKGNh
Y2hlX2lzX3ZpdnQoKSB8fCBjYWNoZV9pc192aXB0X2FsaWFzaW5nKCkpKSovCisJaWYgKChjLT5p
Y2FjaGUuZmxhZ3MgJiBNSVBTX0NBQ0hFX1ZUQUcpIHx8CVwKKwkJKGMtPmRjYWNoZS5mbGFncyAm
IE1JUFNfQ0FDSEVfQUxJQVNFUykpIHsKKwkJCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSAodW5zaWdu
ZWQgbG9uZylhZGRyOworCQkJZG1hX2NhY2hlX2ludihzdGFydCwgKHNpemVfdClzaXplKTsKK30K
K30KK3N0YXRpYyBpbmxpbmUgdm9pZCBmbHVzaF9rZXJuZWxfZGNhY2hlX3BhZ2Uoc3RydWN0IHBh
Z2UgKnBhZ2UpCit7CisKK30KKworCisKICNlbmRpZiAvKiBfQVNNX0NBQ0hFRkxVU0hfSCAqLwo=
--0016e6d9a16e73800e04a5ba427f--
