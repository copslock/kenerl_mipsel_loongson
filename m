Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 09:31:39 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36472 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009718AbbG0HbhsxVfo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 09:31:37 +0200
Received: by wicgb10 with SMTP id gb10so98920910wic.1
        for <linux-mips@linux-mips.org>; Mon, 27 Jul 2015 00:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/ZVLsJd+e24bYYmDWQ0jv+LUP6pSo6DVfhU0bIJDDyc=;
        b=YJsYjmUiLALMRx0lipGkUuQhP8G3uzIEDbfHMAGikPnlpEAUFSRZ0ukWaeQugXgZ5F
         hRubDX4qtLQV+t7sETt0Th7T3wex48v0wi1P3QcM/AHcRaI7aR6LFjNMRHc1eObAPc9l
         ewiumOrebrvMzrTS5hQOmgkVgY33lf0ojZlc5UfxUKSYdsuyeH4M7jEJtwvADMqk3ET3
         PP6BdIfRYQYLCch3fjSadsN4kqyrfsIGxAsCTm8WrEMFh/l7rAn6Dln6TTtY4ckE6lAy
         dRD6s5pV8s2kJ/1GwV+jzlrg+AjFLunfJjMTJOfhhzLEQ0RqFa4pje0w69tqMncRbooS
         fBYA==
X-Gm-Message-State: ALoCoQlQPcu2iojgk0n4q3JzGKVjKEwF4zQu72bM1ZT0DMI5iX935xoIVHKsQ4Ljptt85afALENJ
X-Received: by 10.194.192.166 with SMTP id hh6mr49829401wjc.127.1437982292579;
        Mon, 27 Jul 2015 00:31:32 -0700 (PDT)
Received: from node.shutemov.name (dsl-espbrasgw1-54f9d4-72.dhcp.inet.fi. [84.249.212.72])
        by smtp.gmail.com with ESMTPSA id df1sm12042371wib.12.2015.07.27.00.31.30
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2015 00:31:31 -0700 (PDT)
Received: by node.shutemov.name (Postfix, from userid 1000)
        id C236564FA637; Mon, 27 Jul 2015 10:31:29 +0300 (EEST)
Date:   Mon, 27 Jul 2015 10:31:29 +0300
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
Message-ID: <20150727073129.GE11657@node.dhcp.inet.fi>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <1437773325-8623-6-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437773325-8623-6-git-send-email-emunson@akamai.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48426
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

On Fri, Jul 24, 2015 at 05:28:43PM -0400, Eric B Munson wrote:
> The cost of faulting in all memory to be locked can be very high when
> working with large mappings.  If only portions of the mapping will be
> used this can incur a high penalty for locking.
> 
> Now that we have the new VMA flag for the locked but not present state,
> expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.

As I mentioned before, I don't think this interface is justified.

MAP_LOCKED has known issues[1]. The MAP_LOCKED problem is not necessary
affects MAP_LOCKONFAULT, but still.

Let's not add new interface unless it's demonstrably useful.

[1] http://lkml.kernel.org/g/20150114095019.GC4706@dhcp22.suse.cz

-- 
 Kirill A. Shutemov
