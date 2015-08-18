Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Aug 2015 09:51:18 +0200 (CEST)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37668 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010128AbbHRHvQ2pD8K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Aug 2015 09:51:16 +0200
Received: by wibhh20 with SMTP id hh20so100606868wib.0
        for <linux-mips@linux-mips.org>; Tue, 18 Aug 2015 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zEcE1oyr7eYmJsQqsmDiwjveCNuDSsBcc+oiZxEFqt0=;
        b=zeR5M9w0p9kONJg6a4+x/gwjZe7ncbkdsvW+qtUvycczuCInTNR4HZWR5XjHhIomFh
         DZF3dY+2xBej1S403uSyZi1rKK3t6jpheMhE9N50wqU/rFAvxiPFxQ5USEwBDQ7PLPIm
         ZbhU1f1lSru6YVhOA5Uwg2DgTp0zqIONLyIfGubQ2WtCARcxrByDv3grDns/MTqHRGJC
         MpVttKtaRuM9Yre9tRM39QiRXZNJa2WrJdihrvhQK8QeG0iPYG9eQtfBADGfffvpM/dN
         q8ILoVCzkBE7H5xaOpDoecdnWyd0BMy5iIXTsaqVpDNq/BLAjuU2ok5ela5349PPkZNT
         Lh5Q==
X-Received: by 10.180.37.7 with SMTP id u7mr40136464wij.79.1439884271220;
        Tue, 18 Aug 2015 00:51:11 -0700 (PDT)
Received: from gmail.com (54033495.catv.pool.telekom.hu. [84.3.52.149])
        by smtp.gmail.com with ESMTPSA id cd16sm20127147wib.19.2015.08.18.00.51.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2015 00:51:10 -0700 (PDT)
Date:   Tue, 18 Aug 2015 09:51:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, arnd@arndb.de,
        linux@arm.linux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
        jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: provide more common DMA API functions V2
Message-ID: <20150818075107.GA31884@gmail.com>
References: <1439795216-32189-1-git-send-email-hch@lst.de>
 <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org>
 <20150818053825.GA20771@lst.de>
 <20150817224552.43d7267d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150817224552.43d7267d.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 18 Aug 2015 07:38:25 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Mon, Aug 17, 2015 at 02:24:29PM -0700, Andrew Morton wrote:
> > > 110254 bytes saved, shrinking the kernel by a whopping 0.17%. 
> > > Thoughts?
> > 
> > Sounds fine to me.
> 
> OK, I'll clean it up a bit, check that each uninlining actually makes
> sense and then I'll see how it goes.
> 
> > > 
> > > I'll merge these 5 patches for 4.3.  That means I'll release them into
> > > linux-next after 4.2 is released.
> > 
> > So you only add for-4.3 code to -next after 4.2 is odd?  Isn't thast the
> > wrong way around?
> 
> Linus will be releasing 4.2 in 1-2 weeks and until then, linux-next is
> supposed to contain only 4.2 material.  Once 4.2 is released,
> linux-next is open for 4.3 material.

Isn't that off by one?

I.e. shouldn't this be:

> I'll merge these 5 patches for 4.4.  That means I'll release them into 
> linux-next after 4.2 is released.
>
> [...]
> 
> Linus will be releasing 4.2 in 1-2 weeks and until then, linux-next is supposed 
> to contain only 4.3 material.  Once 4.2 is released and the 4.3 merge window 
> opens, linux-next is open for 4.4 material.

?

Thanks,

	Ingo
