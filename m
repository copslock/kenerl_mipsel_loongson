Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2015 13:26:09 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:32986 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010721AbbGVL0HIdNsh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jul 2015 13:26:07 +0200
Received: by wicmv11 with SMTP id mv11so77122022wic.0
        for <linux-mips@linux-mips.org>; Wed, 22 Jul 2015 04:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:dkim-signature:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/pwjWrgvWt3da2Ooi6Fgf1FRgPaty0dhMuVegOV9bPU=;
        b=ALKM+dgaIqvwDl1Y4dHnprOQPT+E4c392UXccgG5R06fVo2H47Plf+vtuxTOtrly/p
         +cUh3d0HIJhzO0VaWa+55WWGFLXskcLPnyM5JnUh9ESWBWAswtQgRdrMLuXpZVOwuQN8
         PMNllSy6HKKHKSc3OlDwQndsFfVMCpOLNLJvqmbYtISre4BVsBBzIz5h7k1VO08hTSiI
         cfQoakvDs25nBTFFmVgXih4qJcxHAeI8gB3Qak3xiS8M01XL2hjKdZEmFAilG0LSLsKy
         O2t9NI9ZL1Z3ixUHT9n4GC/F54klnZGsks7qhDJzZ6Rfo7ukhd/f819Zn2ldlBWD7v2r
         emww==
X-Gm-Message-State: ALoCoQkwwhn7c/lmWg6du9tsVgJSQFdiw5t0bE3ZvDMXQIxrm/PtEAOZH8nT7LVob6o//YQMYO63
X-Received: by 10.194.112.3 with SMTP id im3mr4171343wjb.54.1437564361712;
        Wed, 22 Jul 2015 04:26:01 -0700 (PDT)
Received: from node.shutemov.name (dsl-espbrasgw1-54f9d1-241.dhcp.inet.fi. [84.249.209.241])
        by smtp.gmail.com with ESMTPSA id y1sm21562809wib.7.2015.07.22.04.25.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 04:26:00 -0700 (PDT)
Received: by node.shutemov.name (Postfix, from userid 1000)
        id 6845F40EE2; Wed, 22 Jul 2015 14:25:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shutemov.name;
        s=default; t=1437564358;
        bh=T01qSVqpqXH9K8iB4w6nJOLmDAKq/BEJkuftpJ4INJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UGjqvocf9GiUgC1QHGl6V4T5QTAopnJCNNE+gKqXAvFYyodOlo4b1WF4j2rYrAGzw
         FLVVNH3vJv2T1yAe7yhQMJpLTE8kccP6LOUdH5QP5vhR8ApZdGPNJiuKswEDAF/0lr
         G6G8ax8lz13vPnT/KUEixvFTlj6O4sWqVsCsp9qw=
Date:   Wed, 22 Jul 2015 14:25:58 +0300
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
Message-ID: <20150722112558.GC8630@node.dhcp.inet.fi>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-6-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437508781-28655-6-git-send-email-emunson@akamai.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48379
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

On Tue, Jul 21, 2015 at 03:59:40PM -0400, Eric B Munson wrote:
> The cost of faulting in all memory to be locked can be very high when
> working with large mappings.  If only portions of the mapping will be
> used this can incur a high penalty for locking.
> 
> Now that we have the new VMA flag for the locked but not present state,
> expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.

What is advantage over mmap() + mlock(MLOCK_ONFAULT)?

-- 
 Kirill A. Shutemov
