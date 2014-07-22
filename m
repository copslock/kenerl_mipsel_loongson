Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 03:20:20 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:57035 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820496AbaGVBUQeRIvC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 03:20:16 +0200
Received: by mail-ig0-f175.google.com with SMTP id uq10so3478741igb.8
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 18:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type;
        bh=fhb0ykA5HEmbpkGikMHZM8/CsGF+HBidCvrG2nzWVws=;
        b=KNZ7pmnPQzUf68XGGbUaYxZxDyLPn8eimwNP/v9TFc28ha63SlPeL1o7L9Gv+J4N9Z
         Dp3Wr0tyveAlTC5oqmdMd17mtt8R610QBlaS+HGtRDigsdRKXSUTd2aeSxczHSkAHg0w
         wb0A4cUU3romLRZYZoldrVWQKTYFLGGwjs5J84mdcP0x2SBrNGL1PZW0ec8H2f9StZqw
         CdSE99qa3NfUIJK4ub3Mxg9B1Nby3t+eR/IoK0qiqCN3HQ+PuaejAMwLSawYvL8UmauM
         KLur7sOvaqmNsZtZDJMnXpUjKvOjEQjmRnfQaBDwqICh4cb4ZaDDjCTxbrlXuKMVDdTZ
         6Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=fhb0ykA5HEmbpkGikMHZM8/CsGF+HBidCvrG2nzWVws=;
        b=chsBuMGNPR8ur6zUGKt2n+JwD0ml9BexLprHhsZ8GfYiQOXoCZeLCCABV4hoYCDL31
         dIzcNlnR9vhw6+M4zQRkkcu9E5JsX8VVQdjlS8fTxKzoxlGKRxMzLl7u1KvM1tFmSkqY
         CcTbvh1Gx5slawnjjjplHycKvX/nkag0Og7gOAvyJBIRXyJpWFWQq4H+Kiks006lbi1l
         BGLZ3gAk3v3/qlF6n6ff/EGNtXeEleRv3nxIRilsS9v0vRdPC6pCQQ97MNoC4lJzsmP7
         GqgbRI4RfyUzbrQ5zsEs8yRSJTJbcuEwa/67wdqIm4Ve1TSSRru4RIa+rZq5uGiXTWVz
         5J2Q==
X-Gm-Message-State: ALoCoQlTate9lrUoNyv8prbvBH+VRFG/FKQfKhetuZMpt5e/i6r4g2F0cpjOjktCMrVUTHKEYJ3D
X-Received: by 10.43.6.195 with SMTP id ol3mr17844080icb.86.1405992009551;
        Mon, 21 Jul 2014 18:20:09 -0700 (PDT)
Received: from [2620:0:1008:1101:e427:f43b:221b:a15c] ([2620:0:1008:1101:e427:f43b:221b:a15c])
        by mx.google.com with ESMTPSA id kk10sm43892756igb.19.2014.07.21.18.20.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 18:20:09 -0700 (PDT)
Date:   Mon, 21 Jul 2014 18:20:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
cc:     Max Filippov <jcmvbkbc@gmail.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/highmem: make kmap cache coloring aware
In-Reply-To: <53CDBB01.7040007@imgtec.com>
Message-ID: <alpine.DEB.2.02.1407211819340.9778@chino.kir.corp.google.com>
References: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com> <alpine.DEB.2.02.1407211754350.7042@chino.kir.corp.google.com> <53CDBB01.7040007@imgtec.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rientjes@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
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

On Mon, 21 Jul 2014, Leonid Yegoshin wrote:

> Yes, there is one, at least for MIPS. This stuff can be a common ground for
> both platforms (MIPS and XTENSA)
> 

Needs the mips patch as a followup as justification for the change.
