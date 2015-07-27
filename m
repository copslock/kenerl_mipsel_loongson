Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 09:15:28 +0200 (CEST)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35840 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009603AbbG0HP0lKomA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 09:15:26 +0200
Received: by wicgb10 with SMTP id gb10so98379818wic.1
        for <linux-mips@linux-mips.org>; Mon, 27 Jul 2015 00:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lFugvN3zqdD5/wMdGW3hjqcVOa5LRM6ktkvxUmBQgeY=;
        b=Xr2UKvgZ9s0yFNyqyg7HHIQt3CU7rJIxaGclNdVCWmY30v++oIhkrHneb7k12mG2bp
         azWyAF9pObGNHkGbg02bVLhm/YZ4lklExTq9zxxeKfQSdkZ72fFIKIbpmDFX07z2LIG1
         9UYo932/2JdPpsNdvGO/LhLI2/1/KhFvvYicAnD8ZK5SUhFJcRR0XYwsidrgK8MRWiHk
         awZc/hQXmLWin5YOROxPj6aO1/d0tdXh/5cFa/I8tv1yS6/aka1JXaX85ACHGhnKpb6y
         i771fmPWsgcTyIxNJbd9VFwCuFncrBq9WJVqUrAqkVEoAxnz9fzvW3GAp4wwSCgrwR+M
         yV1Q==
X-Gm-Message-State: ALoCoQkXGOupMIqdU4jjSiayKSc1V/NTMjyM3qzxySw+bHa+4SpLwy8yM+UeSNAE1TrcL1r4ZY4k
X-Received: by 10.194.187.51 with SMTP id fp19mr49424181wjc.67.1437981321464;
        Mon, 27 Jul 2015 00:15:21 -0700 (PDT)
Received: from node.shutemov.name (dsl-espbrasgw1-54f9d4-72.dhcp.inet.fi. [84.249.212.72])
        by smtp.gmail.com with ESMTPSA id dl10sm26225096wjb.42.2015.07.27.00.15.19
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2015 00:15:20 -0700 (PDT)
Received: by node.shutemov.name (Postfix, from userid 1000)
        id BD85B64FA637; Mon, 27 Jul 2015 10:15:18 +0300 (EEST)
Date:   Mon, 27 Jul 2015 10:15:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH V5 4/7] mm: mlock: Add mlock flags to enable
 VM_LOCKONFAULT usage
Message-ID: <20150727071518.GD11657@node.dhcp.inet.fi>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <1437773325-8623-5-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437773325-8623-5-git-send-email-emunson@akamai.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48425
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

On Fri, Jul 24, 2015 at 05:28:42PM -0400, Eric B Munson wrote:
> The previous patch introduced a flag that specified pages in a VMA
> should be placed on the unevictable LRU, but they should not be made
> present when the area is created.  This patch adds the ability to set
> this state via the new mlock system calls.
> 
> We add MLOCK_ONFAULT for mlock2 and MCL_ONFAULT for mlockall.
> MLOCK_ONFAULT will set the VM_LOCKONFAULT flag as well as the VM_LOCKED
> flag for the target region.  MCL_CURRENT and MCL_ONFAULT are used to
> lock current mappings.  With MCL_CURRENT all pages are made present and
> with MCL_ONFAULT they are locked when faulted in.  When specified with
> MCL_FUTURE all new mappings will be marked with VM_LOCKONFAULT.
> 
> Currently, mlockall() clears all VMA lock flags and then sets the
> requested flags.  For instance, if a process has MCL_FUTURE and
> MCL_CURRENT set, but they want to clear MCL_FUTURE this would be
> accomplished by calling mlockall(MCL_CURRENT).  This still holds with
> the introduction of MCL_ONFAULT.  Each call to mlockall() resets all
> VMA flags to the values specified in the current call.  The new mlock2
> system call behaves in the same way.  If a region is locked with
> MLOCK_ONFAULT and a user wants to force it to be populated now, a second
> call to mlock2(MLOCK_LOCKED) will accomplish this.
> 
> munlock() will unconditionally clear both vma flags.  munlockall()
> unconditionally clears for VMA flags on all VMAs and in the
> mm->def_flags field.
> 
> Signed-off-by: Eric B Munson <emunson@akamai.com>
> Cc: Michal Hocko <mhocko@suse.cz>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
> Changes from V4:
> * Split addition of VMA flag
> 
> Changes from V3:
> * Do extensive search for VM_LOCKED and ensure that VM_LOCKONFAULT is also handled
>  where appropriate
>  arch/alpha/include/uapi/asm/mman.h   |  2 ++
>  arch/mips/include/uapi/asm/mman.h    |  2 ++
>  arch/parisc/include/uapi/asm/mman.h  |  2 ++
>  arch/powerpc/include/uapi/asm/mman.h |  2 ++
>  arch/sparc/include/uapi/asm/mman.h   |  2 ++
>  arch/tile/include/uapi/asm/mman.h    |  3 +++
>  arch/xtensa/include/uapi/asm/mman.h  |  2 ++

Again, you can save few lines by moving some code into mman-common.h.

Otherwise looks good.

-- 
 Kirill A. Shutemov
