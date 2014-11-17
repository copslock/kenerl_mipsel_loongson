Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 17:38:17 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46480 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013838AbaKQQiPJ0zul (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 17:38:15 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F356DEC32608E;
        Mon, 17 Nov 2014 16:38:05 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 17 Nov
 2014 16:38:08 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 17 Nov
 2014 16:38:08 +0000
Received: from [192.168.159.30] (192.168.159.30) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 17 Nov
 2014 08:38:06 -0800
Message-ID: <546A2465.4030103@imgtec.com>
Date:   Mon, 17 Nov 2014 10:37:57 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/7] MIPS: Assorted microMIPS fixes
References: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.30]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 11/15/2014 04:06 PM, Maciej W. Rozycki wrote:
> Hi,
> 
>  In an attempt to build a kernel that supports microMIPS userland and 
> runs on QEMU I came across the problem that, due to apparently arbitrary 
> decisions made sometime in the past, there is no such combination 
> possible.
> 
>  I went ahead and fixed our configuration to support that, but in the 
> course of doing that I came across numerous problems that I decided to 
> address at the same time.  This mini patch series the result.  Most of 
> the changes are actually independent of one another, although there is a 
> syntactical overlap between 5/7 and 7/7, so these have to be applied in 
> order.
> 
>  Of course I had to draw a line somewhere so as not to get distracted 
> too much from the actual purpose I have the need to run such a 
> configuration, so I left some further bugs I spotted for the next 
> occasion.
> 
>  Ralf, please backport these fixes to stable branches as applicable; I 
> can supply you with a 3.17 equivalent of 5/7 as this piece has changed 
> significantly recently and I actually had to forward-port the original 
> change that I made to address the issue.
> 
>   Maciej
> 
Maciej,

This whole patchset looks really good. I went through all of them and
just made a few comments during review.

Steve


Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
