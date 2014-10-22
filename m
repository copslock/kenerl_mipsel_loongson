Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 20:03:14 +0200 (CEST)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:45721 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012138AbaJVSDJabYY6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 20:03:09 +0200
Received: by mail-ig0-f180.google.com with SMTP id uq10so1409319igb.7
        for <multiple recipients>; Wed, 22 Oct 2014 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7L+zECzdkP0ZYyQ+gJy9ky2uNnRLt8pVUFIfLmGFuZ4=;
        b=OHkkIWREbd4lplPAJTQQ7TxCj5aZOa8Xzragap/X7igmBkNF4ZF17mYFh0U3zTAgat
         8XRRjAsF85ilpyKzeQpXRwviD4CYVaw0hjMDTW6l9iC38U47ljARTGwLwG+my/cak0pC
         QGtSAGb+lgv29kKNvy4qosVct5aeJR38k8HS7yTAUG915vo+xRtsbXW238LU9/DivvPo
         ZeVQ4yphYAy2W7fLEr2totMyGJOqKItoDg57rZzdFgZpibiHxOP7FWTWDNxE8l3LX0eh
         4AJuL3mcoOR6cJ5i9p+mMZWeyZPx1ybXTcWTkwHcsFdBExHPd1KiR3xM733LkNAUIPSl
         Vqug==
X-Received: by 10.42.20.195 with SMTP id h3mr4004982icb.59.1414000983105;
        Wed, 22 Oct 2014 11:03:03 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id qo8sm1057457igb.7.2014.10.22.11.03.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 11:03:02 -0700 (PDT)
Message-ID: <5447F155.60106@gmail.com>
Date:   Wed, 22 Oct 2014 11:03:01 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Single MIPS kernel
References: <20141022083437.GB18581@linux-mips.org>
In-Reply-To: <20141022083437.GB18581@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/22/2014 01:34 AM, Ralf Baechle wrote:
> This question comes up every once in a while and I've also been approached
> during ELCE in Düsseldorf why there is no single MIPS kernel for all
> platforms, so I thought I should post a writeup on the topic.
>
> The primary reason is that MIPS kernels are using non-PIC kernels.  This
> means code is linked to a particular absolute address.  The link address
> depends on the memory range available on a particular system's available
> memory range - there is no one size that fits all systems, not even a
> large fraction of supported systems.

There is another reason to have a relocatable kernel:  The security 
people are starting to demand it so that they can randomize the load 
address.

>
> What does it take to make kernels relocatable?  A current kernel is not
> relocatable.  One might do something along the lines of userland where
> the dynamic linker is in a similar situation and needs to first relocate
> itself before it can perform its actual job.
>
> Two approaches.  First keeping the non-PIC code.  That requires keeping
> the entire relocation.  A lasat_defconfig vmlinux is 5733098 bytes but
> built with --emit-relocs to keep the reloc information in the final
> binary the vmlinux file grows to 7217342 bytes!  A quick look at the
> reloc sections:
>
> Section Headers:
>    [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>    [ 2] .rel.text         REL             00000000 461538 0eedf8 08     34   1  4
>    [ 4] .rel__ex_table    REL             00000000 550330 0040e0 08     34   3  4
>    [ 8] .rel.rodata       REL             00000000 554410 0310e0 08     34   7  4
>    [10] .rel.pci_fixup    REL             00000000 5854f0 000998 08     34   9  4
>    [12] .rel__ksymtab     REL             00000000 585e88 00b3b0 08     34  11  4
>    [14] .rel__ksymtab_gpl REL             00000000 591238 007180 08     34  13  4
>    [17] .rel__param       REL             00000000 5983b8 000858 08     34  16  4
>    [19] .rel__modver      REL             00000000 598c10 000038 08     34  18  4
>    [21] .rel.data         REL             00000000 598c48 00a130 08     34  20  4
>    [23] .rel.init.text    REL             00000000 5a2d78 00f008 08     34  22  4
>    [25] .rel.init.data    REL             00000000 5b1d80 001d08 08     34  24  4
>    [27] .rel.exit.text    REL             00000000 5b3a88 000b78 08     34  26  4
>
> The approach could probably be optimized but as a first order approximation
> this demonstrates there would be plenty of bloat to the binary.  Positive
> side of this approach: no runtime penalty.
>

This is the approach I was thinking of taking.  There would be a small 
PIC wrapper that applied the relocations, and then passed control to the 
real entry point.

We would have to be careful of the ex_table, as that is now sorted at 
build time.  For that, we could go to the scheme used by x86, and have 
that addresses in the ex_table be relative, build time sorting is 
already working for x86 relocatable kernels.

David Daney.
