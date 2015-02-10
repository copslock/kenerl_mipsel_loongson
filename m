Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2015 09:01:18 +0100 (CET)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34734 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012464AbbBJIBRS0ccZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Feb 2015 09:01:17 +0100
Received: by mail-wg0-f42.google.com with SMTP id x13so31676705wgg.1;
        Tue, 10 Feb 2015 00:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ggb11xLJvAZpNngcuK1oouyw6QSC1E5/yuVlYtBswk8=;
        b=DnZjvJMppNE93hzUQBHNQHxEDWUELPmRHhF1DDdnDj1nBeAJE7s51RrNVcrtKuiaty
         /ITKqNOfTQsZFSNI9B8bZC3n0gwogPVX76UcpdfGrB6Huelm0uEBI3SxLB7CXTimcJ+F
         4DlAxAYHizpkAS+lPq20bgzfoqjjlyR740Ze7Fq/sHHYMTHEJ0FotSY7M/0J+U7a0d+V
         RxrrEi3XSDuqvNCffiKdNGlGM7c2B/8/E8KlBGiRsYA2qB2VeO3Dzmep5glVzGOBjN2f
         LOj60KYkQf3v2DQxAuhFc3wJHsxEagp/9VnHjAjT6cMF0D6DM9bgS46IZoa57dyAiJ6m
         ZmAw==
X-Received: by 10.180.99.137 with SMTP id eq9mr43761133wib.34.1423555272270;
        Tue, 10 Feb 2015 00:01:12 -0800 (PST)
Received: from [192.168.10.165] (net-93-66-105-136.cust.vodafonedsl.it. [93.66.105.136])
        by mx.google.com with ESMTPSA id ax10sm19598369wjc.26.2015.02.10.00.01.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2015 00:01:10 -0800 (PST)
Message-ID: <54D9BAC3.9080300@redhat.com>
Date:   Tue, 10 Feb 2015 09:01:07 +0100
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Sanjay Lal <sanjayl@kymasys.com>, Gleb Natapov <gleb@kernel.org>,
        kvm@vger.kernel.org, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] KVM: MIPS: Don't leak FPU/DSP to guest
References: <1423069597-8376-1-git-send-email-james.hogan@imgtec.com> <20150209225816.GH30459@jhogan-linux.le.imgtec.org>
In-Reply-To: <20150209225816.GH30459@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 09/02/2015 23:58, James Hogan wrote:
>> First lets save and disable the FPU (and MSA) state with
>> lose_fpu(1)
> 
> Please don't apply this patch yet. lose_fpu() uses function
> symbols which aren't exported for modules to use yet, so that'll
> need fixing first or KVM won't build as a module.

Well, too late. :)

James/Ralf, should I revert, or can that be fixed during the RC period?

Paolo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU2brAAAoJEL/70l94x66DdXIIAImur1pdSKYWw1+FzZH+H8Xo
86j9EfptORk554o0a62LG9dOTY+5sJfAV9CoB7Q+8IfdLDKxpk1sLjMkiS0E0EWU
2ilQfjYEXLTgCW38p03ype4m6g4uSfT16dnizrwnUviFk/EvVgCWHy88tA3+Vfn/
WgoxcXkd+hguyNaLR2oAVqyNhAETLTo4kQQqKwGbXFXf0GLno44pj7bJprCR/jlO
4+sUzuV5dno/GI6z8dyMmASo0QEy+IoXJ+aSw+IoRED9nlBMAS4+7uD4XfocGpca
En5KmXVnyJoazgV3Y6w2ymS606S0JNGRcOzqr8ZbOHtjJmAsZxjuVxP6PVzZqQg=
=ozzu
-----END PGP SIGNATURE-----
