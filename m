Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 21:08:22 +0100 (CET)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57232 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833408Ab3AWUIUy7sZe convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jan 2013 21:08:20 +0100
Received: by mail-wi0-f170.google.com with SMTP id hq7so4770441wib.3
        for <multiple recipients>; Wed, 23 Jan 2013 12:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=6IMbL/jknWsyPOgXnPphZsjk1YPYRK7xBqCbMbdkJdQ=;
        b=S0DO5H81mPT+OKoD98nYYLwuP0ZlNKONFPfkNq97Rs3I5Dnj2oFNXPtQ5gHEwUdkEI
         6KKEOAkyRQirijKwhOH6GjxNDOB1yTYNvTC+MzWBQXLFne71inN+O8n2YUifAGdjnw47
         upF8X3GrkZvVOldcxvc7OoKbSNPpg+FGapcEPrCljghSVRPMzFSweofIarjF0PtZ9WEt
         8HP1wcp+Sg5yI2Q9CKyBrxLYBZu2GLjpRGA4co1yDbiYxbWFUzLVp85Tbl5OjpJcQLVD
         QECquWAAcPN39cx6I9iFM53r/6G0lwBfjIeFZImBt986ZcXMGpvzCrbug1UilokURJqX
         U9Xg==
MIME-Version: 1.0
X-Received: by 10.194.88.98 with SMTP id bf2mr4834534wjb.49.1358971695520;
 Wed, 23 Jan 2013 12:08:15 -0800 (PST)
Received: by 10.216.72.134 with HTTP; Wed, 23 Jan 2013 12:08:15 -0800 (PST)
In-Reply-To: <20130123191549.GB7294@linux-mips.org>
References: <CACna6rz2mpRUZsXqDr7wDjgTSz0bunq9wZ9PumyR5gO_cRhS1Q@mail.gmail.com>
        <20130123191549.GB7294@linux-mips.org>
Date:   Wed, 23 Jan 2013 21:08:15 +0100
Message-ID: <CACna6rwGGWa3+Fbj1fntJh2UKsriWH55ejeWo1cVPAY3aOJZmg@mail.gmail.com>
Subject: Re: git (linux-queue.git) not available: access denied or repository
 not exported
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2013/1/23 Ralf Baechle <ralf@linux-mips.org>:
> On Wed, Jan 23, 2013 at 11:45:16AM +0100, Rafał Miłecki wrote:
>
>> # git clone git://git.linux-mips.org/pub/scm/ralf/linux-queue.git
>> Cloning into 'linux-queue'...
>> fatal: remote error: access denied or repository not exported:
>> /pub/scm/ralf/linux-queue.git
>>
>> I've tried this on two machines. Is there some mirror?
>
> The repository has been superseeded by upstream-sfr.git.  linux-queue.git
> used to serve almost the same purpose and has been dropped.
>
> Is there a stale reference to linux-queue.git somewhere?

Yes: http://www.linux-mips.org/wiki/Git

Would be nice to update that page and probably include also web access
URLs. Quick task for someone with wiki account :)

-- 
Rafał
