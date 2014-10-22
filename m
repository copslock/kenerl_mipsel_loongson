Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 19:56:15 +0200 (CEST)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64388 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012138AbaJVR4NtNk9t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 19:56:13 +0200
Received: by mail-ie0-f179.google.com with SMTP id ar1so3996166iec.38
        for <multiple recipients>; Wed, 22 Oct 2014 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Xf5+ZZjKRsZe+2Kk+E6GrIZHgo2P81iCRVIZFQGvno8=;
        b=g6DhgiX3qVNmNn5uCnOHAW3tNQBmhvqLifxdj8jBUezb+M1++wAshfuo1r9FqUnz+o
         5ujwzP5mSbXzh33KuOyWVvKcqjUSJa2aFSEBfowVRBjsm/clElfO36ExhPpYXzl9V/Dc
         1bIIS3GG6dqlXlyBAymM2D1WdpyCNyyT9FwBtcWu6Fha9ZTzOAgoHK5kea3E4sMBAaqL
         349xm4seCc1+SfIuvMYv22vHFi5Dwiz/sExb8c9ylSyX3rKabs2S8r6pG3OHJ1cfmyHm
         i/eiVq2vSdvrT2zvR2LYrM0IiydI0e3AqSdD1NRzfHi9MPUAZJNwZoVcDd1VEnaWK3w6
         vNQg==
X-Received: by 10.50.6.2 with SMTP id w2mr35631059igw.29.1414000567320;
        Wed, 22 Oct 2014 10:56:07 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id qo2sm1037161igb.21.2014.10.22.10.56.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 10:56:06 -0700 (PDT)
Message-ID: <5447EFB5.4090009@gmail.com>
Date:   Wed, 22 Oct 2014 10:56:05 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Single MIPS kernel
References: <20141022083437.GB18581@linux-mips.org>
In-Reply-To: <20141022083437.GB18581@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/22/2014 01:34 AM, Ralf Baechle wrote:
> This question comes up every once in a while and I've also been approached
> during ELCE in Düsseldorf why there is no single MIPS kernel for all
> platforms, so I thought I should post a writeup on the topic.
>
> The primary reason is that MIPS kernels are using non-PIC kernels.  This
> means code is linked to a particular absolute address.  The link address
> depends on the memory range available on a particular system's available
> memory range - there is no one size that fits all systems, not even a
> large fraction of supported systems.
>

Another reason is that the protocol between the bootloader and the 
kernel varies by platform.  So you would have to have several different 
entry points, one for each booting protocol.

I am not sure how the bootloaders would know which entry point to use.

David Daney
