Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 14:22:16 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:34423 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491130Ab1C3MWN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2011 14:22:13 +0200
Received: by fxm14 with SMTP id 14so1207813fxm.36
        for <linux-mips@linux-mips.org>; Wed, 30 Mar 2011 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=32Pv8wCDOXGrC/RcZP2ef8gALbTcE7EzdvCEBDXcBWI=;
        b=KRW51AujrZsvxNmbWDGVgy24UjI17g83g5fXWlc0jX0/LCp6jKTz6+IGk/qJ9j4Qng
         /3gh7YQ/aFzVutYvmMnFxdy8NRmz0lo63hoWkY0mAxPs/ydguM2YziVH7ktn8QDtvSql
         NLI8Iso72dtNKh9a2o2C74lY5gh6ApQXS4cKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=KZDSgMuf7SGJm0O86qU8OtMp9xeOwcqrQfnYfiSNUCrRVPezFGstXWWeWg8r3WcrcA
         H9AOp2Ol+E+0R7P/0aLEa0n9FcOprwnMKwO20ejk72Qn+Uthr/Q8zj2/t2Joa1PXcERZ
         gI68pO/pK0WQly5tUFL21taqzccsr5Oo40MJM=
Received: by 10.223.101.69 with SMTP id b5mr1208483fao.23.1301487727058;
        Wed, 30 Mar 2011 05:22:07 -0700 (PDT)
Received: from [10.150.51.212] (gw0.net.jmsp.net [212.23.165.14])
        by mx.google.com with ESMTPS id p16sm14528fax.45.2011.03.30.05.22.04
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 05:22:05 -0700 (PDT)
Subject: Re: kmemleak for MIPS
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Daniel Baluta <dbaluta@ixiacom.com>
Cc:     Maxin John <maxin.john@gmail.com>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <AANLkTi=vcn5jHpk0O8XS9XJ8s5k-mCnzUwu70mFTx4=g@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 30 Mar 2011 14:22:00 +0200
Message-ID: <1301487720.3283.32.camel@edumazet-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 8bit
Return-Path: <eric.dumazet@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.dumazet@gmail.com
Precedence: bulk
X-list: linux-mips

Le mercredi 30 mars 2011 à 14:24 +0300, Daniel Baluta a écrit :
> We have:
> 
> > UDP hash table entries: 128 (order: 0, 4096 bytes)
> > CONFIG_BASE_SMALL=0
> 
> udp_table_init looks like:
> 
>         if (!CONFIG_BASE_SMALL)
>                 table->hash = alloc_large_system_hash(name, .. &table->mask);
>         /*
>          * Make sure hash table has the minimum size
>          */
> 
> Since CONFIG_BASE_SMALL is 0, we are allocating the hash using
> alloc_large_system
> Then:
>         if (CONFIG_BASE_SMALL || table->mask < UDP_HTABLE_SIZE_MIN - 1) {
>                 table->hash = kmalloc();
> 
> table->mask is 127, and UDP_HTABLE_SIZE_MIN is 256, so we are allocating again
> table->hash without freeing already allocated memory.
> 
> We could free table->hash, before allocating the memory with kmalloc.
> I don't fully understand the condition table->mask < UDP_HTABLE_SIZE_MIN - 1.
> 
> Eric?

There is nothing special. UDP algo needs a minimum hash table that
alloc_large_system_hash() was not able to provide (???)

As you spotted, there is no free_large-system_hash(), so we 'leak' the
small hash table.

If machine has not enough memory to provide such a small hash table, I
suggest using CONFIG_BASE_SMALL, since :

#define UDP_HTABLE_SIZE_MIN (CONFIG_BASE_SMALL ? 128 : 256)
