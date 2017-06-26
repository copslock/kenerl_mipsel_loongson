Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 23:32:39 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:36641
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993879AbdFZVcdYkRqK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jun 2017 23:32:33 +0200
Received: by mail-wr0-x241.google.com with SMTP id 77so30345477wrb.3;
        Mon, 26 Jun 2017 14:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xfBE1tO+nlQWzhNtCT1xixFm6uxmXE9bM8ga7ok7zAg=;
        b=kE/r4TfQh7ia8k8tg3mx17fCx0Et7+c1CTwbB3cIoeXF2LiTRl1yY7VV5t5K8THWXA
         7+EHBvuSMq6tsj/xIYZ48PPFfwYRclfsC87NuoXJp7N++ar4xYEx1ItU65XLQR3N5XzG
         R8AHSuONG2+llC31lF0ltJ/VNuYJe3ysznhNqkgYx0hhtwhBd+/mh8IUNQob6ClvT+xk
         e8Tz7TrA3pUXjcYs0qU7fWg4UKJFVHbw/Jz670NlrjFtCWxlJLuBimRAxV/GHUD1158a
         U4ZMAyKljjgYpajE7ID+uHKxxBI4J55DB3YNDNrB3j+ikMMoPYwy21edu77tOi62lZjM
         uyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfBE1tO+nlQWzhNtCT1xixFm6uxmXE9bM8ga7ok7zAg=;
        b=C0FSFPlHggQitnCgkju3wjyjLesU8wQrPiXgTSYCvv6xZG45bLbQk6SwrXKz0zntEa
         Mn/aRtFPeZe/Ioev4cw4B5TJHzzMK0VglNk2pnqaVL6x/vUAoW6bkkqRTDD40PFLO8b3
         172ONCq48ImU8YRS+/Vx+QW4NvYcstn3MUH3dRQS83CEdpZ7vJrFD9FuIyvEfznDRvl9
         g4ZIx6VRsGfQxnuIofKSzZErCl6ahbpvAp2yOQ70GRB7JlD/KnQyJ158F84xTVEx6uHm
         6XVjMjzny4fVVXSjOgSW1S28fvcjcstK8OY22m4MGUvHMN3RbozHA9FN9evBbK5fmTCU
         Ub2g==
X-Gm-Message-State: AKS2vOxdWoyIDOq7yE5ddSgOwgZWGoxUTGx1DdukfDZWA33TO03axL9p
        LkEV8waoTDWJ5Q==
X-Received: by 10.223.169.145 with SMTP id b17mr1629891wrd.179.1498512746209;
        Mon, 26 Jun 2017 14:32:26 -0700 (PDT)
Received: from sudip-laptop (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id 2sm7803031wrn.24.2017.06.26.14.32.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 14:32:25 -0700 (PDT)
Date:   Mon, 26 Jun 2017 22:32:18 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: perf: fix build failure
Message-ID: <20170626213218.GA5991@sudip-laptop>
References: <1498254731-5248-1-git-send-email-sudipm.mukherjee@gmail.com>
 <2816265a-d5be-60eb-1428-4dd93e2aeb72@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2816265a-d5be-60eb-1428-4dd93e2aeb72@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

On Mon, Jun 26, 2017 at 08:44:48AM +0200, Marcin Nowakowski wrote:
> Hi Sudip,
> 
> This patch fixes the build error, but leaves the I6500 handling incorrect.

I am failing to understand why I6500 handling is incorrect. I am seeing
that after applying my patch the I6500 handling is same as introduced
by dd71e57bacb5.

> I had explained to Ralf how the build should be fixed a while ago so
> hopefully he will fix it up in his -next branch (dd71e57bacb5 should
> have been applied on top of f7a31b5e7874, but in Ralf's tree
> f7a31b5e7874 is applied on v4.12-rc4 while dd71e57bacb5 is applied
> on v4.12-rc2).

Ohh. ok. that explains. But then it should not have applied cleanly.

--
Regards
Sudip
