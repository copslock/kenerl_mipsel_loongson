Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 16:04:05 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35180 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011327AbbG0OEDvp1Td (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 16:04:03 +0200
Received: by wibxm9 with SMTP id xm9so114294750wib.0
        for <linux-mips@linux-mips.org>; Mon, 27 Jul 2015 07:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NVtlRwEH+9fXuOZWWkQAoqqSwJSMJwMXMF4EIN9MwiI=;
        b=aRF5Op7Nz54O6tcI8Qe2ScPuKUQPdN+bHjy8Uv6S9aNSkpBamkTm5aD3L+KxYmVG9e
         4Y1rlDobk/guzcbtLCZZtjqUHS4iBehR8SsUbPDuEwqaQa71Zv9ehkb3/W90hlvKrahp
         SjDARfKW0qorH/URZijCTJ5p4ASYohnAc0FWUYeGxTYX9VIvjvqTgGBx/Rkn24SlQOZB
         10i4ccgb3hAJP/tehXUtfcmWtwlyLeKBSf8XaaHY/zcMo+o17nsbRpdPcUgqtGFNwmQa
         ngSEdLEjTOQ671Ly7434BGhdB2V1/bYMTAOg5oTf8WGM2tDbElcCGX45oJN4QDXY9OYb
         whmQ==
X-Gm-Message-State: ALoCoQl32TpxY+PT2vbXqw5Vr1aQsQiBBE9iTuo8hxRcXPDFOddSpEU5v+lRTpjiRe/DxIUm2+nT
X-Received: by 10.194.60.131 with SMTP id h3mr54229573wjr.156.1438005838509;
        Mon, 27 Jul 2015 07:03:58 -0700 (PDT)
Received: from node.shutemov.name (dsl-espbrasgw1-54f9d4-72.dhcp.inet.fi. [84.249.212.72])
        by smtp.gmail.com with ESMTPSA id ib9sm28122090wjb.2.2015.07.27.07.03.56
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2015 07:03:57 -0700 (PDT)
Received: by node.shutemov.name (Postfix, from userid 1000)
        id 937B866C9FA3; Mon, 27 Jul 2015 17:03:55 +0300 (EEST)
Date:   Mon, 27 Jul 2015 17:03:55 +0300
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
Subject: Re: [PATCH V5 5/7] mm: mmap: Add mmap flag to request VM_LOCKONFAULT
Message-ID: <20150727140355.GA11360@node.dhcp.inet.fi>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <1437773325-8623-6-git-send-email-emunson@akamai.com>
 <20150727073129.GE11657@node.dhcp.inet.fi>
 <20150727134126.GB17133@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150727134126.GB17133@akamai.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48446
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

On Mon, Jul 27, 2015 at 09:41:26AM -0400, Eric B Munson wrote:
> On Mon, 27 Jul 2015, Kirill A. Shutemov wrote:
> 
> > On Fri, Jul 24, 2015 at 05:28:43PM -0400, Eric B Munson wrote:
> > > The cost of faulting in all memory to be locked can be very high when
> > > working with large mappings.  If only portions of the mapping will be
> > > used this can incur a high penalty for locking.
> > > 
> > > Now that we have the new VMA flag for the locked but not present state,
> > > expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.
> > 
> > As I mentioned before, I don't think this interface is justified.
> > 
> > MAP_LOCKED has known issues[1]. The MAP_LOCKED problem is not necessary
> > affects MAP_LOCKONFAULT, but still.
> > 
> > Let's not add new interface unless it's demonstrably useful.
> > 
> > [1] http://lkml.kernel.org/g/20150114095019.GC4706@dhcp22.suse.cz
> 
> I understand and should have been more explicit.  This patch is still
> included becuase I have an internal user that wants to see it added.
> The problem discussed in the thread you point out does not affect
> MAP_LOCKONFAULT because we do not attempt to populate the region with
> MAP_LOCKONFAULT.
> 
> As I told Vlastimil, if this is a hard NAK with the patch I can work
> with that.  Otherwise I prefer it stays.

That's not how it works.

Once an ABI added to the kernel it stays there practically forever.
Therefore it must be useful to justify maintenance cost. I don't see it
demonstrated.

So, NAK.

-- 
 Kirill A. Shutemov
