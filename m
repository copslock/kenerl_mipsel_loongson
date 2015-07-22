Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2015 17:45:41 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36468 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010910AbbGVPpjZQF-z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jul 2015 17:45:39 +0200
Received: by wicgb10 with SMTP id gb10so104223621wic.1
        for <linux-mips@linux-mips.org>; Wed, 22 Jul 2015 08:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:dkim-signature:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WLHDMHnJdQkSrrpd1QnXE09wE6ziRH15y/IHBOOlPv4=;
        b=dPlPrporY1hdLBRS/LFS1IuQ0Vqa8RMf8V3C1w9fLLKdQwqRWn/SM8GP9wcU+sw0/E
         6HTt3FhQKlV4O6F2OGZDxQghPmoMZ3lxQ0Ysb+FfPYIlUkL/rGB50UAzNdtEiN/hzW57
         vBg0lI0ZD+pIxVCpUpq7lvbTV6/BWBkpnZOrqrIq4Lo77icXYswPOXVzWrlonroJj8Xs
         p35ehqM/2ngP9zlElEqMDwCvbLAYRnIMYxiK4EiboGedkMDu76+bx7tedaQIqSFPE5XZ
         sEJvkPJr4wVHWGN0JF1MIaH+cm7rwyzpVCe9/NFZ+RWuhScAoDg01Tbr92VEgvvzHLNR
         gs6w==
X-Gm-Message-State: ALoCoQlzLhyZ5/OpVW7YE15H8f7HFus12EnNRzyHsHv/Ndts8Qp0mez0cZ2sOG/o94lgGuqP/zkv
X-Received: by 10.194.89.5 with SMTP id bk5mr6579089wjb.144.1437579933189;
        Wed, 22 Jul 2015 08:45:33 -0700 (PDT)
Received: from node.shutemov.name (dsl-espbrasgw1-54f9d1-241.dhcp.inet.fi. [84.249.209.241])
        by smtp.gmail.com with ESMTPSA id n6sm4016496wix.1.2015.07.22.08.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 08:45:31 -0700 (PDT)
Received: by node.shutemov.name (Postfix, from userid 1000)
        id DCBDB40EE2; Wed, 22 Jul 2015 18:45:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shutemov.name;
        s=default; t=1437579929;
        bh=nVHXx2A6wv91qBop3I2Jkkbxog+2TiZ8V9uPkJJZ2Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=C64G6hbBs5TCJ1oESVgJFc75h/H9e6tggqJUXn9iP0juzWT54t2kBuqj4SRvSd/zP
         D2V0/om2RDpmq6j2bbT4Ic2Co9XR2wfnIU24biSm1yskbFMR/wrjquYEIQhqz02RcF
         2TknQgOa5oH3SNwsRp8NgFxvDhxKm4w/K/D64TWA=
Date:   Wed, 22 Jul 2015 18:45:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V4 5/6] mm: mmap: Add mmap flag to request VM_LOCKONFAULT
Message-ID: <20150722154529.GA9107@node.dhcp.inet.fi>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-6-git-send-email-emunson@akamai.com>
 <20150722112558.GC8630@node.dhcp.inet.fi>
 <20150722143220.GB3203@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150722143220.GB3203@akamai.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill@shutemov.name
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

On Wed, Jul 22, 2015 at 10:32:20AM -0400, Eric B Munson wrote:
> On Wed, 22 Jul 2015, Kirill A. Shutemov wrote:
> 
> > On Tue, Jul 21, 2015 at 03:59:40PM -0400, Eric B Munson wrote:
> > > The cost of faulting in all memory to be locked can be very high when
> > > working with large mappings.  If only portions of the mapping will be
> > > used this can incur a high penalty for locking.
> > > 
> > > Now that we have the new VMA flag for the locked but not present state,
> > > expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.
> > 
> > What is advantage over mmap() + mlock(MLOCK_ONFAULT)?
> 
> There isn't one, it was added to maintain parity with the
> mlock(MLOCK_LOCK) -> mmap(MAP_LOCKED) set.  I think not having will lead
> to confusion because we have MAP_LOCKED so why don't we support
> LOCKONFAULT from mmap as well.

I don't think it's ia good idea to spend bits in flags unless we have a
reason for that.

BTW, you have typo on sparc: s/0x8000/0x80000/.


-- 
 Kirill A. Shutemov
