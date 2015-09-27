Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Sep 2015 18:05:23 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34020 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006890AbbI0QFV5fVI8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Sep 2015 18:05:21 +0200
Received: by wicfx3 with SMTP id fx3so75305357wic.1;
        Sun, 27 Sep 2015 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jkO/EcYb/NZ23L8WgotgAquT2csSdqPTY+ZAbz3EuoA=;
        b=aPakecM018S2kgjyDKPO4tcsLWpbRpwK0zCgpu9bjncHqJNlW1uUIfmF9QSG6P/F9Z
         LKrg95c1uYEd12+gCl+E+GNMBK7SS0Vydt9/ZetUjgMWsyKZ2myJqJKPnzkgBKdxpGcJ
         HG14aUXLHAXDILZPR0/7acHt6FeB2KyOBmx+18rvWJ43NCjKvVZsyuxBL7QHmF9XbfTB
         bLb/DjmWnqj56RROqrDm95W36qaSpMbPaaiN6LHAj4vnGXZlTShPscSaZYC4SogSA4Mm
         gGbdsxPRCdUUAiBISBFeziO+ipck9hdE02Jr7hwiX2gfo+U6oHFemofy2ORriZM+iVLR
         uJ5g==
X-Received: by 10.194.190.75 with SMTP id go11mr16370870wjc.80.1443369914787;
        Sun, 27 Sep 2015 09:05:14 -0700 (PDT)
Received: from debian (h249n21-ld-c-a31.ias.bredband.telia.com. [78.70.84.249])
        by smtp.gmail.com with ESMTPSA id wn10sm13715989wjc.46.2015.09.27.09.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2015 09:05:13 -0700 (PDT)
Date:   Sun, 27 Sep 2015 18:05:08 +0200
From:   Rabin Vincent <rabin@rab.in>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 0/2] perf tools: Add MIPS userspace DWARF callchains.
Message-ID: <20150927160419.GA8529@debian>
References: <cover.1428450297.git.ralf@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1428450297.git.ralf@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <rabin.vincent@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin@rab.in
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

On Wed, Apr 08, 2015 at 01:58:45AM +0200, Ralf Baechle wrote:
> This is a refresh of a David Daney's patch set to implement MIPS support
> for perf.  It has been posted before but not received any comments or
> (N)Acks.
> 
> This series depends on
> 
>   http://patchwork.linux-mips.org/patch/5246/
> 
> which currently is pending for 4.1 in the MIPS tree so I'd like to upstream
> these two patches through the MIPS tree as well.

Looks like this "MIPS: Add user stack and registers to perf" patch
didn't get merged in 4.1?  Could it please be queued now?

> 
> David's original patches are archived at:
> 
>   http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1368817238-11548-1-git-send-email-ddaney.cavm%40gmail.com
>   http://patchwork.linux-mips.org/patch/5249/
>   http://patchwork.linux-mips.org/patch/5250/

I've taken these tools/perf patches and made them work with the latest
mainline (this addresses the comments Jiri had) and can send them out if
you'd like, but they need the arch/mips patch to build.
