Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 15:51:34 +0200 (CEST)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:33470
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993666AbeGKNv1yBHcp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 15:51:27 +0200
Received: by mail-lf0-x242.google.com with SMTP id u14-v6so21356633lfu.0;
        Wed, 11 Jul 2018 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BGmb/SK4/5gaIjzTrMswGNRfj/L4bEKNv64u9bMTbkc=;
        b=G6gd1mAcvwiyORuFP9mKxc3aKMgzJWtRuXJf3uKpWPVPEvfqhDmHdp0Lz/Z2pJi/Mk
         DP2XvJpelgnKTgsJc2sDYUbXYRbjcMfBJq1yOuVXxphdOznkfE2PQ0DEIoxvMbG2IG2X
         bwNddBpgLDrZFWXT9UAYR25bmWKAe0I5nOvu/TCaDiUBTWXm6Lu76h4IKd8iT5JNomTU
         fCVBQqrjWkwftbE2R3YLi/bsElNyZlboe0nJEcxHHoweK6pOfhKFhHdozHU1HSQJz1F+
         zedUGWvB8TxK/lDu1H4SkvVC7isN4OArFV9+orSSmA5bWceja5LnZAA8iPmrgUu1+RbA
         H9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGmb/SK4/5gaIjzTrMswGNRfj/L4bEKNv64u9bMTbkc=;
        b=pogW0kbHdc1z2hb0FXXuXu3XNWVD/aL8Z93moqie1/hhhtX7ia9gC6WWac+IIrx4oS
         jHPZQn7Qpz7LYx86WHzWAb6VKsu46+rBezXmmP+141c/Fn7tyIs6+EfcmJqYGc+pYuZw
         VqyTGviW2PyKcbRKglK7V7D8KrEuVzdf+jtzX4EZYRJdlaZd2nRhCUpLN45U/yETFRio
         XAa1YyGbkj3ZAmi5OXtrYNYYjTrQG1Xcz3uIfWnurmes/0o1CXevlgW5nEhnLHpAxb1/
         qgoWeG+5kx1GD/gsuBVWz/Gd/RRiP2+LhiZZehHQc2Ufve28Da9ZloVQzTusPTSikjHg
         AsTg==
X-Gm-Message-State: APt69E1Y1aKlEicUFx7IJ5kjvFx2nguvtE2SAj/iEPkhALySvWyflPBs
        WgyQkh1kSPeMcevhlfdJV68=
X-Google-Smtp-Source: AAOMgpfCBsr0mKj/PrEaQPjVZesxwh0/I2u76DRVyH97l+939ry3BBJgdyvvYIWJoCKA3o9tKYCWVg==
X-Received: by 2002:a19:1749:: with SMTP id n70-v6mr5851378lfi.54.1531317082298;
        Wed, 11 Jul 2018 06:51:22 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id t9-v6sm3047202ljt.21.2018.07.11.06.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:51:21 -0700 (PDT)
Date:   Wed, 11 Jul 2018 16:52:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180711135210.GA18730@mobilestation>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <20180711065631.GA21948@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711065631.GA21948@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64797
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

Hello Christoph,

On Tue, Jul 10, 2018 at 11:56:31PM -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > + * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
> > + * requests a cachable mapping with CWB attribute enabled.
> >   */
> >  #define ioremap_cacheable_cow(offset, size)				\
> >  	__ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
> 
> This isn't actually used anywhere in the kernel tree.  Please remove it
> as well.

I don't really know whether it is necessary at this point. We discarded the 
ioremap_uncached_accelerated() method, since the obvious alternative is now
available: ioremap_wc(). While ioremap_cacheable_cow() hasn't got one.
So if it was up to me, I'd leave it here. Anyway if the subsystem maintainers
think otherwise, I won't refuse to submit a patch with this method removal.

Regards,
-Sergey
