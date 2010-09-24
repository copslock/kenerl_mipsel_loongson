Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Sep 2010 01:16:42 +0200 (CEST)
Received: from gateway16.websitewelcome.com ([69.93.82.10]:43630 "HELO
        gateway16.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491206Ab0IXXQj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Sep 2010 01:16:39 +0200
Received: (qmail 9254 invoked from network); 24 Sep 2010 23:16:35 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway16.websitewelcome.com with SMTP; 24 Sep 2010 23:16:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=bY7+aiRDkdxA+9DGpQsLHa1wRkg0r7oePtrOD4GzO4YbRtSNQCdZUEa/xOLjLzkbeV9ncitkbyTpH9DaxuFCt9rME5bXmfKYUy750J3Lvc0ex6gRMfPnqM6D52gAxmMJ;
Received: from [216.239.45.4] (port=2037 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1OzHVG-0000Vk-Mi; Fri, 24 Sep 2010 18:16:30 -0500
Message-ID: <4C9D3153.8020901@paralogos.com>
Date:   Fri, 24 Sep 2010 16:16:35 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
MIME-Version: 1.0
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Does Linux MIPS use scratch pad ram?
References: <AEA634773855ED4CAD999FBB1A66D07601159CB4@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D07601159CB4@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-archive-position: 27825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19946

I find it hard to believe that you've got Flash responding in place of 
the CP0 cache tag registers.

On 09/24/10 14:45, Ardelean, Andrei wrote:
> Hi,
>
> I am using MALTA platform and try to port Linux on a new platform.
> It seems to me that in spram.c the sprams are probed  if they are
> available or not but I cannot see Linux really using those afterwards.
> My platform has no spram so I am trying to avoid this probing. The
> problem is that spram.c is not MALTA specific but as the comment says in
> spram.c there are some MALTA specific addresses. Unfortunately I have
> some Flash at those addresses.
> How to fix this issue?
>
> Thanks,
> Andrei
>
>
>    
