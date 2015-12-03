Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 23:23:39 +0100 (CET)
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:45449 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007545AbbLCWXhvvZy0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 23:23:37 +0100
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-06v.sys.comcast.net with comcast
        id pAMM1r0034xDoy801APaHC; Thu, 03 Dec 2015 22:23:34 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-po-05v.sys.comcast.net with comcast
        id pAPY1r00J0w5D3801APZQg; Thu, 03 Dec 2015 22:23:34 +0000
Subject: Re: [PATCH 0/9] MIPS Relocatable kernel & KASLR
To:     Matt Redfearn <matt.redfearn@imgtec.com>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <5660C0D5.208@gentoo.org>
Date:   Thu, 3 Dec 2015 17:23:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1449181414;
        bh=wgVMO9rYT0bmOvneexsuHNhModhOPId7RZ8iUTgLnQM=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=IPtKhYY/xriEh/VvzMU5OjANjXCvtTdpaDF3l68R4AnA0nrifXnmwfRfjEZO/LCXu
         0XnljxuHrwjpqXsSlG94e0jmg0aL74Kgpx5ZBsv1XHXOg3fxwcLQa3sxEcpvLoWDT8
         PSe+Mf4i7MHX19M2DZsOfAJGdVUH3KsYjhDaZ1Fn87/V5Dn2lJuzT71lInNJxD6WEm
         va2qfsBf6YwcRvjNkozZOzX26vvC/Sonx36P8GOpyZfNWx5Rj7WqSMYA8VQfkRQ1OG
         q7Yaj/9NABVAyTOIx2Jup14MOnKsYqOkRTorJdRmufOapO5wZVJHCWWWRf6PbEA0Jp
         HwJi3u1QDGWIw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 12/03/2015 05:08, Matt Redfearn wrote:
> This series adds the ability for the MIPS kernel to relocate itself at
> runtime, optionally to an address determined at random each boot. This
> series is based on v4.3 and has been tested on the Malta platform.

[snip]

> * Relocation is currently supported on R2 of the MIPS architecture,
>   32bit and 64bit.

Out of curiosity, why is this capability restricted to MIPS R2 and higher?
IRIX kernels and the 'sash' tool were both relocatable on the older SGI
platforms.  Does the feature, as implemented, rely on R2-specific
instructions/capabilities, or only due to lack of testing on pre-R2 hardware?

--J
