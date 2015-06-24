Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 11:47:45 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:36627 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006156AbbFXJrnhcmRl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jun 2015 11:47:43 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1B47BAC6B;
        Wed, 24 Jun 2015 09:47:43 +0000 (UTC)
Date:   Wed, 24 Jun 2015 11:47:42 +0200
From:   Michal Hocko <mhocko@suse.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Eric B Munson <emunson@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH V2 1/3] Add mmap flag to request pages are locked
 after page fault
Message-ID: <20150624094742.GD32756@dhcp22.suse.cz>
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>
 <1433942810-7852-2-git-send-email-emunson@akamai.com>
 <20150618152907.GG5858@dhcp22.suse.cz>
 <20150618203048.GB2329@akamai.com>
 <20150619145708.GG4913@dhcp22.suse.cz>
 <20150619164333.GD2329@akamai.com>
 <20150622123826.GF4430@dhcp22.suse.cz>
 <20150622141806.GE2329@akamai.com>
 <558954DD.4060405@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558954DD.4060405@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mhocko@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@suse.cz
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

On Tue 23-06-15 14:45:17, Vlastimil Babka wrote:
> On 06/22/2015 04:18 PM, Eric B Munson wrote:
> >On Mon, 22 Jun 2015, Michal Hocko wrote:
> >
> >>On Fri 19-06-15 12:43:33, Eric B Munson wrote:
[...]
> >>>My thought on detecting was that someone might want to know if they had
> >>>a VMA that was VM_LOCKED but had not been made present becuase of a
> >>>failure in mmap.  We don't have a way today, but adding VM_LOCKONFAULT
> >>>is at least explicit about what is happening which would make detecting
> >>>the VM_LOCKED but not present state easier.
> >>
> >>One could use /proc/<pid>/pagemap to query the residency.
> 
> I think that's all too much complex scenario for a little gain. If someone
> knows that mmap(MAP_LOCKED|MAP_POPULATE) is not perfect, he should either
> mlock() separately from mmap(), or fault the range manually with a for loop.
> Why try to detect if the corner case was hit?

No idea. I have just offered a way to do that. I do not think it is
anyhow useful but who knows... I do agree that the mlock should be used
for the full mlock semantic.

> >>>This assumes that
> >>>MAP_FAULTPOPULATE does not translate to a VMA flag, but it sounds like
> >>>it would have to.
> >>
> >>Yes, it would have to have a VM flag for the vma.
> 
> So with your approach, VM_LOCKED flag is enough, right? The new MAP_ /
> MLOCK_ flags just cause setting VM_LOCKED to not fault the whole vma, but
> otherwise nothing changes.

VM_FAULTPOPULATE would have to be sticky to prevent from other
speculative poppulation of the mapping. I mean, is it OK to have a new
mlock semantic (on fault) which might still populate&lock memory which
hasn't been faulted directly? Who knows what kind of speculative things
we will do in the future and then find out that the semantic of
lock-on-fault is not usable anymore.

[...]

-- 
Michal Hocko
SUSE Labs
