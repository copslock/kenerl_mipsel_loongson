Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 04:38:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62386 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006150AbbB0Dit7UtKB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 04:38:49 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C3569636B128B;
        Fri, 27 Feb 2015 03:38:43 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 27 Feb
 2015 03:38:44 +0000
Received: from [10.20.78.174] (10.20.78.174) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 26 Feb
 2015 19:38:35 -0800
Message-ID: <54EFE6B9.1050109@imgtec.com>
Date:   Thu, 26 Feb 2015 21:38:33 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH V7 1/3] MIPS: Rearrange PTE bits into fixed positions.
References: <1424996199-21366-1-git-send-email-Steven.Hill@imgtec.com> <1424996199-21366-2-git-send-email-Steven.Hill@imgtec.com> <54EFBF9D.4020004@gmail.com>
In-Reply-To: <54EFBF9D.4020004@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.78.174]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46038
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

On 02/26/2015 06:51 PM, David Daney wrote:
> 
> That's not really what I meant in my previous response on the subject.
> When I said:
> 
>     Why not just use RI for everything, instead of taking up two bits
>     to represent a single binary concept?
> 
>     For the case where there is no RI hardware active, it is a purely
>     software bit and you can easily invert the meaning and just have a
>     _PAGE_NO_READ bit.
> 
> I envisioned something like:
> 
>     64-bit, all revisions:    CCC D V G RI XI [S H] M A W P
>     32-bit, all revisions:    CCC D V G RI XI M A W P
> 
Which is what I implemented. I now only use one bit that functions
either as _PAGE_READ or _PAGE_READ_ONLY depending on the RI/XI
functionality present. Did you bother to read the code and understand
it, or just look at the commit message?

Steve
