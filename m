Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2015 14:34:02 +0200 (CEST)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35338 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010762AbbDWMd7koyQu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Apr 2015 14:33:59 +0200
Received: by igbyr2 with SMTP id yr2so22235057igb.0
        for <linux-mips@linux-mips.org>; Thu, 23 Apr 2015 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jxqlxuZh304VuENJr6Tf6iwgPbHkxFM/ctqOHbamWQE=;
        b=x0S10jJTBdlJ7KU6pDxr8QosiOjgxDdvJ2USZR+LgpwKqhQ0+dtZblounMbpZKaMzb
         MZqazxfMP65acvfmvBu715yto/NSRyIezMNd1Txv0LYr+mMeu4QDMRFNqsF3mqdHUO+I
         843E9x7TsP+b5lDfh235XvyG1oJCGjLxABtYvbS5nTgB59oQosgqOfOhALF1lWvxEC09
         HL2DWzAP1pZQq0T0nw3g6o5WSSuMa36xv22iau30s3vznBB+Zw4SBNQTVla8g3/s/qPw
         GcwNKU0AKk06gib4MQuc6JWsVGGuMSdP1rV+ry3QfESDNB06FPX31hTjWvJFbHFGMx6F
         GtCA==
MIME-Version: 1.0
X-Received: by 10.43.163.129 with SMTP id mo1mr3263440icc.61.1429792435433;
 Thu, 23 Apr 2015 05:33:55 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Thu, 23 Apr 2015 05:33:55 -0700 (PDT)
In-Reply-To: <1429792093-8160-1-git-send-email-markos.chandras@imgtec.com>
References: <1429792093-8160-1-git-send-email-markos.chandras@imgtec.com>
Date:   Thu, 23 Apr 2015 14:33:55 +0200
Message-ID: <CACna6rwvnWtD0T2hXju-YUFxt2iEqigj=fVkKxOC_19+=2_FzA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: bcm47xx: Move the BCM47XX board types under a
 choice symbol
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47015
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

On 23 April 2015 at 14:28, Markos Chandras <markos.chandras@imgtec.com> wrote:
> Since the build system expects one of the two types to be selected,
> it's better if we move these symbols under a new choice symbol.

Nack, it doesn't allow building kernel with *both* buses support.
