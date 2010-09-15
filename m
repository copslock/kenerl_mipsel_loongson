Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Sep 2010 22:56:19 +0200 (CEST)
Received: from gateway01.websitewelcome.com ([69.93.106.19]:47653 "HELO
        gateway01.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491132Ab0IOU4Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Sep 2010 22:56:16 +0200
Received: (qmail 32379 invoked from network); 15 Sep 2010 20:56:09 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway01.websitewelcome.com with SMTP; 15 Sep 2010 20:56:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=dDLtasOHIwCZdb+ZaVoWZSXu0g7HwJP+MXeIVgAA2M7Dv6FGZ2VO4FfhnXqwIydC8m7Uu5mqw8JApH7g4CKYJIjH7PuyOh+iXbKk4F3VPx8851590k0r62ewOlPPMGdc;
Received: from [216.239.45.4] (port=57636 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1Ovz1S-0008W2-Mb; Wed, 15 Sep 2010 15:56:06 -0500
Message-ID: <4C9132E9.6060807@paralogos.com>
Date:   Wed, 15 Sep 2010 13:56:09 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100826 Thunderbird/3.0.7
MIME-Version: 1.0
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
CC:     linux-mips@linux-mips.org
Subject: Re: What is CONFIG_MIPS_MT_SMTC configuration and when is this recommended
 to be used?
References: <AEA634773855ED4CAD999FBB1A66D076010CFA3B@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D076010CFA3B@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-archive-position: 27757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12202

SMTC is a kernel for the 34K (and, just maybe, with some mods, 1004K) 
that turns TC microthreads into virtual SMP CPUs.  See
http://tree.celinuxforum.org/CelfPubWiki/ELC2006Presentations?action=AttachFile&do=view&target=CELF_SMTC_April_2006_v0.3.pdf

/K.

On 09/15/10 12:46, Ardelean, Andrei wrote:
> Hi,
>
> I use Linux on MALTA board. My final goal is to port Linux on new board
> based on MIPS. What is CONFIG_MIPS_MT_SMTC configuration and when is
> this recommended to be used?
>
> Thanks,
> Andrei
>
>
>    
