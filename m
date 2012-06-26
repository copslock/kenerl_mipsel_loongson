Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 17:12:07 +0200 (CEST)
Received: from mail-qc0-f169.google.com ([209.85.216.169]:37974 "EHLO
        mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903850Ab2FZPL7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 17:11:59 +0200
Received: by qcsd16 with SMTP id d16so8934qcs.28
        for <multiple recipients>; Tue, 26 Jun 2012 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h6MOQLk5o01mRcBFHBb5VJHNGeZRyMftUxMbpMjZNOI=;
        b=ksKgIDxqG6B0C+ZKp58n+rSoJm2SbRUSqifjX7AQbhlrx7UnYQzu6OiEZk1cKNJxe1
         XA1bxTmMLgdFKj9tXTznlwD1RiuHO/DmSXBo6dFsedGMYR8Ry0OhvruW9K0bVoalWHAY
         EBPJtTok98nj+U2rvHJcLbm+peV6PLkQkuOZ00CjfAjSvSpu3k/nVU9f5M8iNGRaMSXq
         5PfXwBh66XokVEFOdY5KF1Huoz29+DiALCtAx5RtH2wCvkgm9oDqPPTMMww2cEakHGuE
         UvYFy0NdgYc1Ta9Yfmch/h11AgyrTacChHDx7o3+YbPSyXB46lqvJ4ngI4d4fjkrwvXN
         qF7A==
Received: by 10.60.14.68 with SMTP id n4mr16580914oec.24.1340723513275; Tue,
 26 Jun 2012 08:11:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.98.195 with HTTP; Tue, 26 Jun 2012 08:11:32 -0700 (PDT)
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 26 Jun 2012 17:11:32 +0200
Message-ID: <CAOiHx=kKxZZzJZkRe+SRjFj0JD7yq4=3CmRFbqc6hW_Dhnbz3g@mail.gmail.com>
Subject: Re: [PATCH 00/33] Cleanup firmware support across multiple platforms.
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Hi Steven,

On 26 June 2012 06:41, Steven J. Hill <sjhill@mips.com> wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> This is actually the second version of the firmware cleanup.

Maybe name it V2 then? Or V3, if you send another one ;-)

> It is two
> patches less than first after incorporating all the review comments
> and changes requested. The original patch set is now rejected.

You are changing licenses from GPLv2+ to GPLv2 for many files - "any
later" gives me hits for 13 of your patches (but I didn't verify them
all).

Regards
Jonas
