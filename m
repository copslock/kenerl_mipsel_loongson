Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 12:26:50 +0200 (CEST)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:34686
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992366AbdEVK0oCiv5j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 12:26:44 +0200
Received: by mail-lf0-x241.google.com with SMTP id q24so5063064lfb.1;
        Mon, 22 May 2017 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pZeMSZMt3Glk7ekUdedNuyZKfhLbxYt2nTClY9SEzG8=;
        b=dzN0YxD/CSBbi89c5VyQz6yF8wx7j4SQOhc2SqArQ4YJWmq/iNDEfxlMN+XWxHC3xz
         f5HCNHoYmrcwxMF1uo8vM2UZ3i2b/mQSdKZzaZPVGyv0rlFNlNJvSpEjgV0c2UQ7r5vq
         PMzBXdo0fjcM6UroslRMnBcQATuA0ZBtmmIc2/+X/XmMFHBC+rHcuesMJUOYEe3UMdUL
         eIP3hUBQeKkQFOrz5oJrgDIlW/7TkijlKjqxbn/qnIJe5riJNyVG7KYZaKxHuHa1KWt5
         RfgcUALbYf3O9caXh/+n1ulrs76C3Ohnc2EF4+n76t13BhCA98qo2aT9a2y6XkRM3VYN
         a0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pZeMSZMt3Glk7ekUdedNuyZKfhLbxYt2nTClY9SEzG8=;
        b=uRONXiY20OWsnGyq7FSsTWsfNONPAD2G9b7iIaD3meamAehLFtKOBPNkMpSzQ7hjqU
         3ADGdaqldcrC7taqqVQFHMtQL14/e2jGzRts/QtGeteIUjQyuu4DyEcPheLQ2KYXqzsI
         JEvjvpikuWc1W0ErEMNKIIkjtP2sBS/wqWvs2ZKLOokZDROYAqtWKIywXFpOxlvc5F7u
         +1/o9FqL1nv9tl33AZQ3hYga8g6TmtQgfoZ+Aun9ZiinfAHZ61KqJYkeHhficSXmtc8m
         i45wFTxvQgCZV2jV719vdLhk6iFsoUqZWRohIfikHH2Sj+HJySvGeuoukePEzmQm/fTi
         BtKw==
X-Gm-Message-State: AODbwcBTHjpNSTeesJTdjzQ2uSyCoAl4fATOwNWgmlz/BDjn1zvTH+ar
        xuF0dHw3o8tEpQ==
X-Received: by 10.46.20.76 with SMTP id 12mr5934000lju.11.1495448798607;
        Mon, 22 May 2017 03:26:38 -0700 (PDT)
Received: from mobilestation ([5.164.217.172])
        by smtp.gmail.com with ESMTPSA id w69sm2491593lff.45.2017.05.22.03.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 03:26:37 -0700 (PDT)
Date:   Mon, 22 May 2017 13:26:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/21] MIPS memblock: Remove bootmem code and switch to
 NO_BOOTMEM
Message-ID: <20170522102643.GA17763@mobilestation>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <be0b6614-708d-a32a-029d-7e606a673e5b@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be0b6614-708d-a32a-029d-7e606a673e5b@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

On Mon, May 22, 2017 at 11:48:36AM +0200, Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:

Hello Marcin,

> Hi Serge,
> 
> On 19.12.2016 03:07, Serge Semin wrote:
> >Most of the modern platforms supported by linux kernel have already
> >been cleaned up of old bootmem allocator by moving to nobootmem
> >interface wrapping up the memblock. This patchset is the first
> >attempt to do the similar improvement for MIPS for UMA systems
> >only.
> >
> >Even though the porting was performed as much careful as possible
> >there still might be problem with support of some platforms,
> >especially Loonson3 or SGI IP27, which perform early memory manager
> >initialization by their self.
> >
> >The patchset is split so individual patch being consistent in
> >functional and buildable ways. But the MIPS early memory manager
> >will work correctly only either with or without the whole set being
> >applied. For the same reason a reviewer should not pay much attention
> >to methods bootmem_init(), arch_mem_init(), paging_init() and
> >mem_init() until they are fully refactored.
> >
> >The patchset is applied on top of kernel v4.9.
> 
> Have you progressed any further with these patches?
> They would definitely be useful to include for MIPS arch, so can you let us
> know if you are planning to send any updated version?
> 
> thanks,
> Marcin

Sorry for such a long delay with response. I have been really busy
during last three months. Alas I'll still be busy for next 1-2
months as well. You know how it usually works with urgent projects.
One needs to do this thing, then that thing, and at some point I just
forgot about this thread.

Regarding the patchset. I'm still pretty much eager to make it being
part of kernel MIPS arch. But there was a problem I outlined
in the patchset header message, which I can't fix by myself.
Particulary It's connected with Loonson3 or SGI IP27 code alteration,
so to make it free of ancient boot_mem_map dependencies (see the
patchset header message). Without a help from someone, who has
Loonson64 and SGI IP27 hardware and strong desire to make it free of
old bootmem allocator, it is useless to make any progress from my
side. That's why Ralf moved this email-thread into RFC actually.
Anyway If either you or someone else has got such hardware and is
interested in the cooperation, I'll be more than happy to push
my efforts forward with this patchset contribution. But only after
I got a bit less busy with my work. As I said it will happen within
next 1-2 months. So do you have the hardware and desire to be part
of this?

Regards,
-Sergey
