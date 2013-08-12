Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Aug 2013 19:16:57 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:49479 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825118Ab3HLRQTfn6tl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Aug 2013 19:16:19 +0200
Message-ID: <52091861.4040707@openwrt.org>
Date:   Mon, 12 Aug 2013 19:16:17 +0200
From:   Felix Fietkau <nbd@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: remove unnecessary platform dma helper functions
References: <1376306569-83278-1-git-send-email-nbd@openwrt.org> <5209159D.7040301@gmail.com>
In-Reply-To: <5209159D.7040301@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <nbd@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
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

On 2013-08-12 7:04 PM, David Daney wrote:
> That's a mighty thin changelog there.
I thought it was obvious that the lines I removed contain no useful code
at all :)

> You are changing the semantics in the 
> asm/mach-cavium-octeon/dma-coherence.h case.
I'm just removing a fallback BUG() that could never be reached before my
change either. As for the other platforms, I verified that there's no
useful code in these functions anywhere in the tree.

> Have you verified that all in-tree cases really are NOPs?
Yes.

- Felix
