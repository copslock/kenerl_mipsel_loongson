Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 10:03:13 +0200 (CEST)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:59118 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011282AbaJVIDLp4P-g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 10:03:11 +0200
Received: by mail-wi0-f173.google.com with SMTP id fb4so591558wid.0
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZsQCcdX3SOtytywiYkbE4Iyk49ZGjC0Ffu9/aABHwZc=;
        b=n5minXOVBcyFztHPEUDm6tpO3yZvWSWIRig1F0a3z+/daykJ1vX2b7Rpf+8FZDqZ0s
         g9ht2y8gOLOhkClTm9Q4w/7rKZK74ZzjKBgeSbWEclKE7AJyW03X6eOtqXNUIA7AQvx2
         G0FkOec8J4+jLzva0OoqFW2pxeXEBl9j57LTfasll3kFcp54ku4qUnMcVykSB8HO7Njo
         J89ZwbKJeC9I8u3RyWBigiS6s8BE1t8hFzImegMa6VwzCbge49IsXzNRoa8xIXIpKoVe
         T6KYIQJUJ9ig9YwMpBub2Ze1RYbLEoiXN9zB9xE4iroAbqzLxEwWZTgYVDTijeAHlrGy
         JlCw==
X-Received: by 10.180.75.116 with SMTP id b20mr34706352wiw.49.1413964986367;
        Wed, 22 Oct 2014 01:03:06 -0700 (PDT)
Received: from localhost.localdomain (193-81-107-224.adsl.highway.telekom.at. [193.81.107.224])
        by mx.google.com with ESMTPSA id u2sm17962374wjz.11.2014.10.22.01.03.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 01:03:05 -0700 (PDT)
Date:   Wed, 22 Oct 2014 10:03:02 +0200
From:   Richard Cochran <richardcochran@gmail.com>
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        David Miller <davem@davemloft.net>, markos.chandras@imgtec.com,
        linux-mips@linux-mips.org, corbet@lwn.net, netdev@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: ptp: Fix build failure on MIPS cross
 builds
Message-ID: <20141022080302.GA4037@localhost.localdomain>
References: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com>
 <20141021110724.GA16479@netboy>
 <20141021.123544.9516812519754063.davem@davemloft.net>
 <544690CB.4030307@gmail.com>
 <20141021182757.GA3960@localhost.localdomain>
 <CAOFdcFNYHgupvMChb4NedMsUMAOmE8k0D_F5eRjL-8H8ft=eRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFdcFNYHgupvMChb4NedMsUMAOmE8k0D_F5eRjL-8H8ft=eRw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <richardcochran@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richardcochran@gmail.com
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

On Tue, Oct 21, 2014 at 06:04:51PM -0400, Peter Foley wrote:
> The intention of these changes was to generate more compiliation
> coverage for code in Documentation/

Sounds good.

> The underlying issue is that this doesn't work for cross-compiling
> because kbuild doesn't have cross-compile support for userspace code.

Well, my testptp does cross compile just fine. All it needs is the glibc
library bundled with the tool chain and the kernel headers.

> I submitted a patch to disable building Documentation when
> cross-compiling, as the consensus in the thread that resulted in that
> patch (https://lkml.org/lkml/2014/10/8/510) was that implementing
> targetprogs in kbuild was not currently worth it.

So this patch did not make it in, right?

Otherwise people wouldn't be disabling cross compilation ad hoc, like
in the patch that started this thread.

> I can try to take a crack at adding targetprogs support, but I'm
> rather busy right now, so it may take a little while.

No rush, please do.

In the mean time, I would like to restore the testptp.mk that *does*
cross compile, so that people may use the test program if they
want. In fact I use this all the time, and so I am a bit annoyed that
something working was deleted and replaced with something broken.

Thanks,
Richard
