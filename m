Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 16:07:20 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:63974 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491144Ab1C3OHR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2011 16:07:17 +0200
Received: by qwi2 with SMTP id 2so924026qwi.36
        for <linux-mips@linux-mips.org>; Wed, 30 Mar 2011 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IDPx/t1b1WQYGyufQVE5Xwtv23xv57/sC03CSO/9Lq8=;
        b=fAT0PcNPygj+m+9TKtm0MxSn1G66Zsr/wpA3Sn/iSKFW7WMCdPkemnFVp1p0pwo0VC
         eKsF+QX9y9ScWj/LkXt89UJLdMi5fGON1DF0f/mwzmAzQytBAdJcyD5HXYTj7lIMCqQw
         gnUJolkCNlSxlTvVcP1mvXr8clQlEY2zAyZFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dLLWp91hc0DC0EDB1Pu9fuSyGBYJJAf/K4885nyeAstfbvLpo7h2kSmBqiYXBIAUP9
         xiuxAEJW+hjyd8STo1EezxuzamWdLv1H5I1vt8jDM2QBIenFU6gthTyDiUIin3bp56u5
         QDTGgP+K3N/5cTfdip7LAL74LIaiKogJmcfho=
MIME-Version: 1.0
Received: by 10.229.35.1 with SMTP id n1mr1050632qcd.84.1301494029924; Wed, 30
 Mar 2011 07:07:09 -0700 (PDT)
Received: by 10.229.6.200 with HTTP; Wed, 30 Mar 2011 07:07:09 -0700 (PDT)
In-Reply-To: <1301491622.3283.46.camel@edumazet-laptop>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
        <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
        <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim139fpJsMJFLiyUYvFgGMz-Ljgd_yDrks-tqhE@mail.gmail.com>
        <1301395206.583.53.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim-4v5Cbp6+wHoXjgKXoS0axk1cgQ5AHF_zot80@mail.gmail.com>
        <1301399454.583.66.camel@e102109-lin.cambridge.arm.com>
        <AANLkTin0_gT0E3=oGyfMwk+1quqonYBExeN9a3=v=Lob@mail.gmail.com>
        <AANLkTi=gMP6jQuQFovfsOX=7p-SSnwXoVLO_DVEpV63h@mail.gmail.com>
        <1301476505.29074.47.camel@e102109-lin.cambridge.arm.com>
        <AANLkTi=YB+nBG7BYuuU+rB9TC-BbWcJ6mVfkxq0iUype@mail.gmail.com>
        <AANLkTi=L0zqwQ869khH1efFUghGeJjoyTaBXs-O2icaM@mail.gmail.com>
        <AANLkTi=vcn5jHpk0O8XS9XJ8s5k-mCnzUwu70mFTx4=g@mail.gmail.com>
        <1301485085.29074.61.camel@e102109-lin.cambridge.arm.com>
        <AANLkTikXfVNkyFE2MpW9ZtfX2G=QKvT7kvEuDE-YE5xO@mail.gmail.com>
        <1301488032.3283.42.camel@edumazet-laptop>
        <AANLkTikX0jxdkyYgPoqjvC5HzY8VydTbFh_gFDzM8zJ7@mail.gmail.com>
        <AANLkTi=RXoEOVmTPiL=dfO97aOVKWOJWE7hoQduPPsCZ@mail.gmail.com>
        <1301491622.3283.46.camel@edumazet-laptop>
Date:   Wed, 30 Mar 2011 15:07:09 +0100
Message-ID: <AANLkTi=tyhbb54iHPpPjK4+jM09SQv4giOTjpsjvD33E@mail.gmail.com>
Subject: Re: kmemleak for MIPS
From:   Maxin John <maxin.john@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <maxin.john@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxin.john@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Eric,

> Hmm, then MIPS kmemleak port might have a problem with percpu data ?
>
> fcp->hash_table = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
>
> fcp is a per cpu "struct flow_cache_percpu"

Thank you very much for the inputs. I will definitely investigate this.
However, I think, the "basic" kmemleak support for MIPS is working as
expected with the present patch.
The kmemleak test case is also working as expected in MIPS target.

So, as Daniel mentioned, shall we go ahead with integrating the
kmemleak support for MIPS ?

Please let me know your comments.

Cheers,
Maxin
