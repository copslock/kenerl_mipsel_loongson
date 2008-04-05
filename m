Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Apr 2008 03:31:05 +0200 (CEST)
Received: from mu-out-0910.google.com ([209.85.134.186]:22434 "EHLO
	mu-out-0910.google.com") by lappi.linux-mips.net with ESMTP
	id S530157AbYDEBbA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Apr 2008 03:31:00 +0200
Received: by mu-out-0910.google.com with SMTP id w8so520264mue.1
        for <linux-mips@linux-mips.org>; Fri, 04 Apr 2008 18:30:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=mNT7ngrm7pW7uNfLdzVudrb2vv44lRkMTZmGI7fZG3c=;
        b=kDdBd3p3/tar/cAgRZcx3+cvN887wS3ClcF5tLLZT6plbS46JNRRI/KZR5kjcbACJtMsj1tLhcr/2yfJginVx87x9JzJUxuO8O+clAHgBHbFHAHu+TlCD4+jIgK0zksp5DGmdgOPrAHAhjc5J9GyNT7tvaeH4lOiRVzKRVo8WsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dVtnn6SNOcpXF7kZw6/FZDmECjSdW/It9fZZS2HG+muIpzpqNSljbRBFKhtKKN+lvkEN6FpBiToPQY/PPdwir4jnWqhyYhiiot7tX8nV2y3N2tQmvpaAVVnx7aHsFkkXIHl5C8cmpkeROG91MoAbEKMl1zMj4T8xS85kz+1zIJM=
Received: by 10.78.145.16 with SMTP id s16mr5959660hud.23.1207359037827;
        Fri, 04 Apr 2008 18:30:37 -0700 (PDT)
Received: from ?92.36.11.113? ( [92.36.11.113])
        by mx.google.com with ESMTPS id d25sm9022690nfh.33.2008.04.04.18.30.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Apr 2008 18:30:36 -0700 (PDT)
Message-ID: <47F6D611.5080402@gmail.com>
Date:	Sat, 05 Apr 2008 05:29:53 +0400
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14ubu (X11/20080306)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] [MIPS] unexport null_perf_irq() and make it static
References: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com> <1207094318-21748-6-git-send-email-dmitri.vorobiev@gmail.com> <20080404072048.GF12086@linux-mips.org>
In-Reply-To: <20080404072048.GF12086@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle пишет:
> On Wed, Apr 02, 2008 at 03:58:38AM +0400, Dmitri Vorobiev wrote:
> 
>> This patch unexports the null_perf_irq() symbol, and simultaneously
>> makes this function static.
>>
>> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
> 
> Queued for 2.6.26 with your static fix folded in.  Thanks,

Thanks for picking the patches up.

Dmitri

> 
>   Ralf
> 
