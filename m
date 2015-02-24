Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 17:21:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33600 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007034AbbBXQVIHcZgm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 17:21:08 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C354BBF1566F0;
        Tue, 24 Feb 2015 16:20:59 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 24 Feb
 2015 16:21:02 +0000
Received: from [10.20.78.122] (10.20.78.122) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 24 Feb
 2015 08:20:54 -0800
Message-ID: <54ECA4EB.6010807@imgtec.com>
Date:   Tue, 24 Feb 2015 10:20:59 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Kevin Cernekee <cernekee@chromium.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with non-DMA
 I/O.
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com> <54EBCC38.7000702@imgtec.com> <alpine.LFD.2.11.1502240217360.17311@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1502240217360.17311@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.78.122]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45932
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

On 02/23/2015 08:24 PM, Maciej W. Rozycki wrote:
> On Mon, 23 Feb 2015, Leonid Yegoshin wrote:
> 
>> The same is basically for transfer D$ --> I$ because in MIPS it is done via L2
>> or memory.
> 
>  The original issue aside (I don't want to dive into it) this I believe is 
> left to an implementer's discretion and there are MIPS implementations 
> indeed that fill I$ directly from D$; IIRC Alchemy silicon and its 
> descendants.
> 
>   Maciej
> 
I am tracking down even more HIGHMEM bugs, so I will rework these
patches, clean-up commit messages and post again. Thanks for all the
feedback.

Steve
