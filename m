Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2010 10:09:22 +0200 (CEST)
Received: from gateway09.websitewelcome.com ([69.93.243.4]:39451 "HELO
        gateway09.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492887Ab0HDIJR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Aug 2010 10:09:17 +0200
Received: (qmail 16589 invoked from network); 4 Aug 2010 08:17:25 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway09.websitewelcome.com with SMTP; 4 Aug 2010 08:17:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=C0iklcMrKFFQnDLzIkSVf8c1xyL63Gk62KhDUGRNEFhvr18bemBb8EHWyHd5pCu3qBrSTKquj/Orikc1ciJHU3ZNxNX2b4FWSj+RUj8UDnzIHOgiszIqCfopAzTggisg;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:1576 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1OgZ2A-00067a-Oi; Wed, 04 Aug 2010 03:09:07 -0500
Message-ID: <4C592027.8010902@paralogos.com>
Date:   Wed, 04 Aug 2010 01:09:11 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [Q] enabling FPU for vpe1
References: <AANLkTinCjSTE7sYa7JdqwAEe-4nZJKAvVfg5q4YVVqC7@mail.gmail.com>
In-Reply-To: <AANLkTinCjSTE7sYa7JdqwAEe-4nZJKAvVfg5q4YVVqC7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Check the MIPS MT spec.  If I recall correctly, it's possible to enable
access to the FPU by either VPE by setting the right bits while the
processor is in the MT configuration mode.

Deng-Cheng Zhu wrote:
> Hi,
>
>
> I'm working on a 34Kf CPU. I understand that only one TC can use the
> FPU at any given time.
>
> My question is: If a TC is attached to the 2nd VPE (i.e. VPE1), can I
> enable FPU for it?
>
> I experimented on this, but failed to do it. Am I missing something?
>
>
> Thanks
>
> Deng-Cheng
>
>   
