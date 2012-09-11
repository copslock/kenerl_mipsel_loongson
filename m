Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 03:04:48 +0200 (CEST)
Received: from gateway09.websitewelcome.com ([67.18.39.12]:50216 "EHLO
        gateway09.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903487Ab2IKBEo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2012 03:04:44 +0200
Received: by gateway09.websitewelcome.com (Postfix, from userid 507)
        id 8EEC9D6ECAB5; Mon, 10 Sep 2012 20:04:41 -0500 (CDT)
Received: from gator750.hostgator.com (gator750.hostgator.com [174.132.194.2])
        by gateway09.websitewelcome.com (Postfix) with ESMTP id 81F26D6ECA94
        for <linux-mips@linux-mips.org>; Mon, 10 Sep 2012 20:04:41 -0500 (CDT)
Received: from [216.239.45.4] (port=7415 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.77)
        (envelope-from <kevink@paralogos.com>)
        id 1TBEu9-0002Oh-6l
        for linux-mips@linux-mips.org; Mon, 10 Sep 2012 20:04:41 -0500
Message-ID: <504E8E27.5030904@paralogos.com>
Date:   Mon, 10 Sep 2012 18:04:39 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
References: <20120909193008.GA15157@brightrain.aerifal.cx> <20120910170830.GB24448@linux-mips.org> <20120910172248.GN27715@brightrain.aerifal.cx> <alpine.LFD.2.00.1209110059580.8926@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1209110059580.8926@eddie.linux-mips.org>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-BWhitelist: no
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (kkissell.mtv.corp.google.com) [216.239.45.4]:7415
X-Source-Auth: kevink@kevink.net
X-Email-Count: 1
X-Source-Cap: a2tpc3NlbGw7a2tpc3NlbGw7Z2F0b3I3NTAuaG9zdGdhdG9yLmNvbQ==
X-archive-position: 34460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
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

On 09/10/2012 05:29 PM, Maciej W. Rozycki wrote:
> I do wonder however why we have these instructions to save/restore $25
> in SAVE_SOME/RESTORE_SOME. This dates back to 2.4 at the very least.
> Ralf, any insights?
Hi, guys.  Maybe the fact that it's used for dispatching PIC calls has
something to do with it?

/K.
