Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 19:25:26 +0200 (CEST)
Received: from mail-oa0-f52.google.com ([209.85.219.52]:63493 "EHLO
        mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6839078Ab3HURZUA2UBL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 19:25:20 +0200
Received: by mail-oa0-f52.google.com with SMTP id f4so446169oah.11
        for <linux-mips@linux-mips.org>; Wed, 21 Aug 2013 10:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:subject:to:cc:in-reply-to:message-id
         :mime-version:content-type:content-disposition
         :content-transfer-encoding;
        bh=QulNOcRG6Za/u+GCtDAKnv4kBROtu5oZ9sY9UCnqw+k=;
        b=mswzZb67/p7rukYS3NQTO+vJWsO9QV4RNO/Qt1IFSXDa7alJUmf/TNiJT+mgMFvjv6
         y6dROlxQnN3IvDwTraesPxsTdaw78jtdBv39IWOMWJFZ38CVLqRBVb+4E8HaeyLp7Nke
         J7sxBR3EjCHJWaygrae/8Lttm3aMTo3ryfhVWlctmFbvwxZCqYZtin10yXAdh0kfgUNQ
         OlD2fk5v682qjLYM059NLTVsSMvneglSrDZPtbZo0S569unUpXFYJ1+Rj9pKvIgkYEM/
         7l9GSB91hrb6olyN9aTamhuTBYdHV99SfXgS3iSHWjGCEdZtPZ0aVqlGfb9OqPAGqW7P
         gZXA==
X-Gm-Message-State: ALoCoQmxJ8+wGiQopY1VomNaLhJoRvaFU4yaJSWXlrhvi7uGag9A/IAW178shLN1yhbKKERvKGFC
X-Received: by 10.60.39.169 with SMTP id q9mr3736891oek.79.1377105913559;
        Wed, 21 Aug 2013 10:25:13 -0700 (PDT)
Received: from driftwood (cpe-173-174-120-163.austin.res.rr.com. [173.174.120.163])
        by mx.google.com with ESMTPSA id a18sm11740577obf.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 10:25:12 -0700 (PDT)
Date:   Wed, 21 Aug 2013 12:25:11 -0500
From:   Rob Landley <rob@landley.net>
Subject: Re: [RFC] Get rid of SUBARCH
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Michal Marek <mmarek@suse.cz>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
In-Reply-To: <CAMuHMdWk-EPTNmPB1O1+F7YVQLjhQsFJznYwA3t6UCGUU1T9PQ@mail.gmail.com>
        (from geert@linux-m68k.org on Wed Aug 21 07:07:33 2013)
X-Mailer: Balsa 2.4.11
Message-Id: <1377105911.2737.94@driftwood>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 08/21/2013 07:07:33 AM, Geert Uytterhoeven wrote:
> On Wed, Aug 21, 2013 at 10:19 AM, Richard Weinberger <richard@nod.at>  
> wrote:
> > This series is an attempt to remove the SUBARCH make parameter.
> > It as introduced at the times of Linux 2.5 for UML to tell the UML
> > build system what the real architecture is.
> >
> > But we actually don't need SUBARCH, we can store this information
> > in the .config file.
> 
> Haha, now you have OS_ARCH (shouldn't that be called HOST_ARCH?)  
> instead,
> which is available only for UM?
> 
> > The series touches also m68k, sh, mips and unicore32.
> > These architectures magically select a cross compiler if ARCH !=  
> SUBARCH.
> > Do really need that behavior?
> 
> This does remove functionality.
> It allows to build a kernel using e.g. "make ARCH=m68k".

   make ARCH=m68k CROSS_COMPILE=m68k-
   make ARCH=arm CROSS_COMPILE=armv5l-
   make ARCH=sparc CROSS_COMPILE=sparc-
   make ARCH=ppc CROSS_COMPILE=powerpc-
   make ARCH=sh CROSS_COMPILE=sh4-
   make ARCH=mips CROSS_COMPILE=mipsel-
   make ARCH=x86 CROSS_COMPILE=i686-
   make ARCH=alpha CROSS_COMPILE=alpha-

Works the same way on all the targets I've tried so far. You specify  
the architecture, you specify the cross compiler prefix, you feed it a  
config file, you build.

(If a target supplies its own default cross compiler prefix I just have  
to override it with what mine's called anyway...)

> Perhaps this can be moved to generic code? Most (not all!)  
> cross-toolchains
> are called $ARCH-{unknown-,}linux{,-gnu}.
> Exceptions are e.g. am33_2.0-linux and bfin-uclinux.

The linaro toolchain is arm-linux-gnueabihf- and the one on kernel.org  
is arm-unknown-linux-gnueabi- and the one I build is armv5l- (because  
the FSF's  
$ARCH-unknown-gnu-format-tuple-all-hail-stallman-gnu-gnu-gnu-dammit-gcc  
is just nuts: why would I say -linux- in a linux-to-linux toolchain? Do  
windows toolchains say -windows-?)

Other toolchain sources use other prefixes (-unknown- is often  
-$VENDORNAME-), and then of course there's llvm... which is why you  
specify CROSS_COMPILE= on the make command line.

Rob
From swarren@wwwdotorg.org Wed Aug 21 20:24:41 2013
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 20:24:43 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:38199 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6839074Ab3HUSYlLM8yj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Aug 2013 20:24:41 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 06F106351;
        Wed, 21 Aug 2013 12:24:39 -0600 (MDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id E26BAE461B;
        Wed, 21 Aug 2013 12:24:35 -0600 (MDT)
Message-ID: <521505E2.3050308@wwwdotorg.org>
Date:   Wed, 21 Aug 2013 12:24:34 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Stephen Warren <swarren@nvidia.com>,
        Michal Marek <mmarek@suse.cz>,
        Shawn Guo <shawn.guo@linaro.org>,
        Ian Campbell <ian.campbell@citrix.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] MIPS: add <dt-bindings/> symlink
References: <1377095762-18926-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1377095762-18926-1-git-send-email-james.hogan@imgtec.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.97.8 at avon.wwwdotorg.org
X-Virus-Status: Clean
Return-Path: <swarren@wwwdotorg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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
Content-Length: 699
Lines: 14

On 08/21/2013 08:36 AM, James Hogan wrote:
> Add symlink to include/dt-bindings from arch/mips/boot/dts/include/ to
> match the ones in ARM and Meta architectures so that preprocessed device
> tree files can include various useful constant definitions.
> 
> See commit c58299a (kbuild: create an "include chroot" for DT bindings)
> merged in v3.10-rc1 for details.
> 
> MIPS structures it's dts files a little differently to other
> architectures, having a separate dts directory for each SoC/platform,
> but most of the definitions in the dt-bindings/ directory are common so
> for now lets just have a single "include chroot" for all MIPS platforms.

Acked-by: Stephen Warren <swarren@nvidia.com>
