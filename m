Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 19:34:45 +0200 (CEST)
Received: from mail-da0-f49.google.com ([209.85.210.49]:40990 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6872764Ab2JJReaGQPK4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 19:34:30 +0200
Received: by mail-da0-f49.google.com with SMTP id q27so296749daj.36
        for <multiple recipients>; Wed, 10 Oct 2012 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=C96EoR6b6N34tszVp0EAHW+yGX3lmXTDY6Nl9YLawQQ=;
        b=Edpg9qLpuZgEsqVfUNaKj2LylSj98IEq9za33CwcSm10Tk7QNSPb0DecapbC61RCeq
         q9TXgBCmMWGu9H3xBbY0+IV1Sf2bGAxRQGzuiNlSHG2O4sWMrqUbs/dDIFZt8bCjOXqX
         OuMzXRieJSOHW9ipYngIgdZz40VVanGqflDl53RlONMDPB5DIbtcQuMf5Dr9VAMdvDrH
         bdrjC/LDz56Kv9XRWcIa4uQaUuc0l2t81xpQ+3COkgDFfHK6lj1pJrZsTFZEdGf9cbM+
         PlqmksWsVh48ZsVppCHti2waEHwwfwnh3cidyJnw4z0ojoXb0QcG5xW29TLI5YjU7MdO
         kmEw==
Received: by 10.68.195.195 with SMTP id ig3mr76809851pbc.108.1349890463464;
        Wed, 10 Oct 2012 10:34:23 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id nu8sm1315741pbc.45.2012.10.10.10.34.22
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 10:34:22 -0700 (PDT)
Message-ID: <5075B19D.4080701@gmail.com>
Date:   Wed, 10 Oct 2012 10:34:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Rich Felker <dalias@aerifal.cx>, linux-mips@linux-mips.org,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
Subject: Re: 2GB userspace limitation in ABI N32
References: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com> <20121010080756.GC6740@linux-mips.org> <20121010125700.GR254@brightrain.aerifal.cx> <5075A8D8.2080704@gmail.com> <alpine.LFD.2.02.1210101805410.21287@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.02.1210101805410.21287@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34677
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/10/2012 10:10 AM, Maciej W. Rozycki wrote:
> On Wed, 10 Oct 2012, David Daney wrote:
>
>> The only disadvantage of doing this is that the code will be slightly
>> larger/slower as it takes three instructions to load a zero extended 32-bit
>> pointer verses two for n32-2GB.
>
>   And of course such code will only run on 64-bit processors that not only
> support 64-bit data, but 64-bit addressing as well.

That's right.  All of this assumes a fully 64-bit operating system 
kernel (Linux).

It is not really very interesting on 'small' systems that have less than 
about 1GB of RAM.  And obviously impossible if 64-bit addressing is not 
supported.

So the interesting use cases are 'modern' systems with 4GB or more of 
ram installed.  And only then for the subset of applications that need 
more than 2GB of virtual address space but will never need to consider 
more than 4GB.



>  That is implement the
> CP0.Status.UX bit rather than CP0.Status.PX only -- the latters are still
> compatible with the true n32 ABI.  See also CP0.Config.AT.
>
>    Maciej
>
>
