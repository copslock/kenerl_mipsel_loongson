Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 13:25:08 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:47621 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491079Ab1C3LZF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2011 13:25:05 +0200
Received: by qwi2 with SMTP id 2so823331qwi.36
        for <linux-mips@linux-mips.org>; Wed, 30 Mar 2011 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=4J3IfhYrkvlBCTVDoap6TlN1uskT6rNYNAuC2un1ckQ=;
        b=KYcKfh8ox9KGZV79TuPGb8ONqEtUdXQoU5smqbl7eBLAH012S0ISDxXUCx6c92u9vF
         pMbwZeip5DxULdt/c30e+Iw3dfQcJVmH2Tjvfc2UWi6Yr7Ass8zdGyS7uXE5lnRm+dOb
         RoJINGg7cOvx3yZ97A8+P9HqDUt3Ka0A6IvW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=njPFbiRNGMz636OF67g0+2gYNeqGnRbZ7G98CRdQCMGMTEfn2Xq/328T529/bC1DQ6
         Z8BU9XE5vpcrpMXQevjeWEjsF928YMxhG894Pxx5Wm2afcd+nQgAzF/DIfsk5NWgc/UT
         AJ/IAdL1ffJyzYlmfboOxa7+43Kxu3s4FoIbA=
MIME-Version: 1.0
Received: by 10.224.217.8 with SMTP id hk8mr898810qab.181.1301484300053; Wed,
 30 Mar 2011 04:25:00 -0700 (PDT)
Received: by 10.224.2.146 with HTTP; Wed, 30 Mar 2011 04:24:59 -0700 (PDT)
In-Reply-To: <AANLkTi=L0zqwQ869khH1efFUghGeJjoyTaBXs-O2icaM@mail.gmail.com>
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
Date:   Wed, 30 Mar 2011 14:24:59 +0300
X-Google-Sender-Auth: KvC7MfIQxgX5fOuinasIvjaV3t0
Message-ID: <AANLkTi=vcn5jHpk0O8XS9XJ8s5k-mCnzUwu70mFTx4=g@mail.gmail.com>
Subject: Re: kmemleak for MIPS
From:   Daniel Baluta <dbaluta@ixiacom.com>
To:     Maxin John <maxin.john@gmail.com>
Cc:     naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <daniel.baluta@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dbaluta@ixiacom.com
Precedence: bulk
X-list: linux-mips

We have:

> UDP hash table entries: 128 (order: 0, 4096 bytes)
> CONFIG_BASE_SMALL=0

udp_table_init looks like:

        if (!CONFIG_BASE_SMALL)
                table->hash = alloc_large_system_hash(name, .. &table->mask);
        /*
         * Make sure hash table has the minimum size
         */

Since CONFIG_BASE_SMALL is 0, we are allocating the hash using
alloc_large_system
Then:
        if (CONFIG_BASE_SMALL || table->mask < UDP_HTABLE_SIZE_MIN - 1) {
                table->hash = kmalloc();

table->mask is 127, and UDP_HTABLE_SIZE_MIN is 256, so we are allocating again
table->hash without freeing already allocated memory.

We could free table->hash, before allocating the memory with kmalloc.
I don't fully understand the condition table->mask < UDP_HTABLE_SIZE_MIN - 1.

Eric?

thanks,
Daniel.
