Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2015 13:17:36 +0200 (CEST)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35607 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009734AbbG1LRdSuAot (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Jul 2015 13:17:33 +0200
Received: by wibxm9 with SMTP id xm9so152158896wib.0;
        Tue, 28 Jul 2015 04:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nRUhGz/krU7Dw8DdEKVPOa3R9btHwBIf/Z6Daov4LHc=;
        b=Tdisu3xlQkh4T8Jd/WQuG9hobQYcaCxcEabK9PJIr1av1ywlYl1IGwisRK8hJiYzwT
         ufDKpPEzNCcz/k92xkd1aWStriwdetGhWR3nxKc7fzpLQBNX+m0bk0hWKD1qQy452vxN
         obXP9E3/A07TC4jV46foevL8psEde6j9nnHKW47+pP8yh7hZ6O+x/Vfi6APZcAGbl/m/
         krRLtsI1OG6VtMZEvAJc102Ml21K0q9lt5QJ76m4hNnd3l9j0oQpqp5pPG949QPZitgP
         dsed3OUKPMDb7nomI7AuTuC080rsC09Rtp3ZM8GGOiBq4u00zacrh1NI7syHX/zQF7gr
         EtsA==
X-Received: by 10.180.104.8 with SMTP id ga8mr33973857wib.5.1438082248047;
        Tue, 28 Jul 2015 04:17:28 -0700 (PDT)
Received: from localhost (bband-dyn181.95-103-48.t-com.sk. [95.103.48.181])
        by smtp.gmail.com with ESMTPSA id pd7sm32733949wjb.27.2015.07.28.04.17.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 04:17:27 -0700 (PDT)
Date:   Tue, 28 Jul 2015 13:17:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V5 0/7] Allow user to request memory to be locked on page
 fault
Message-ID: <20150728111725.GG24972@dhcp22.suse.cz>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <55B5F4FF.9070604@suse.cz>
 <20150727133555.GA17133@akamai.com>
 <55B63D37.20303@suse.cz>
 <20150727145409.GB21664@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150727145409.GB21664@akamai.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mstsxfx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

[I am sorry but I didn't get to this sooner.]

On Mon 27-07-15 10:54:09, Eric B Munson wrote:
> Now that VM_LOCKONFAULT is a modifier to VM_LOCKED and
> cannot be specified independentally, it might make more sense to mirror
> that relationship to userspace.  Which would lead to soemthing like the
> following:

A modifier makes more sense.
 
> To lock and populate a region:
> mlock2(start, len, 0);
> 
> To lock on fault a region:
> mlock2(start, len, MLOCK_ONFAULT);
> 
> If LOCKONFAULT is seen as a modifier to mlock, then having the flags
> argument as 0 mean do mlock classic makes more sense to me.
> 
> To mlock current on fault only:
> mlockall(MCL_CURRENT | MCL_ONFAULT);
> 
> To mlock future on fault only:
> mlockall(MCL_FUTURE | MCL_ONFAULT);
> 
> To lock everything on fault:
> mlockall(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT);

Makes sense to me. The only remaining and still tricky part would be
the munlock{all}(flags) behavior. What should munlock(MLOCK_ONFAULT)
do? Keep locked and poppulate the range or simply ignore the flag an
just unlock?

I can see some sense to allow munlockall(MCL_FUTURE[|MLOCK_ONFAULT]),
munlockall(MCL_CURRENT) resp. munlockall(MCL_CURRENT|MCL_FUTURE) but
other combinations sound weird to me.

Anyway munlock with flags opens new doors of trickiness.
-- 
Michal Hocko
SUSE Labs
