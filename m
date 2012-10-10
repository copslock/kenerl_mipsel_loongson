Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 19:50:00 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:64797 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822664Ab2JJRtwfS53Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 19:49:52 +0200
Received: by mail-ob0-f177.google.com with SMTP id wd20so823805obb.36
        for <multiple recipients>; Wed, 10 Oct 2012 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m7Gv1uJesFRcMNqXw1dQ9QCNlx7vSSETnIFFfccv0bU=;
        b=OBka28AB3BP8hnL1NkHfV8vHQedlQJ3Wdi4IUj7iErwS1lz+H+BXDyg3Q6ByCknmOo
         5T3hX66TtXG6LxgL3DZkLAPqyBDt+HBOjZAsUwKyDUyfzJDCAZ5Ab+uDJd7fzj8cDoZm
         LZU6R4mKwhAGTuPYBWNViwkTW5vNUOOfhmk9xFBmr2GX1VwNJyNVbG1eSxoAX5sH0179
         vupe+hlybmp7qmtw8q+WO7DtuNx2Xbc/wWcF/CKuv+N07yZfgQ+XLfB1+WRyZciSPaHY
         r4NOBl/O5uXi92xLFf+sBkyR4Q61nfYTbmcEJCilD70/HqnLgTcS8IdVll2OkGayY/GP
         0LVw==
MIME-Version: 1.0
Received: by 10.182.221.7 with SMTP id qa7mr6297075obc.5.1349891386076; Wed,
 10 Oct 2012 10:49:46 -0700 (PDT)
Received: by 10.60.66.4 with HTTP; Wed, 10 Oct 2012 10:49:46 -0700 (PDT)
In-Reply-To: <5075B19D.4080701@gmail.com>
References: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com>
        <20121010080756.GC6740@linux-mips.org>
        <20121010125700.GR254@brightrain.aerifal.cx>
        <5075A8D8.2080704@gmail.com>
        <alpine.LFD.2.02.1210101805410.21287@eddie.linux-mips.org>
        <5075B19D.4080701@gmail.com>
Date:   Wed, 10 Oct 2012 19:49:46 +0200
Message-ID: <CAMJ=MEf2LFcWLo8f061-WiM9dMt-hQJUmoRCCs6agZvc2VQrNQ@mail.gmail.com>
Subject: Re: 2GB userspace limitation in ABI N32
From:   Ronny Meeus <ronny.meeus@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Rich Felker <dalias@aerifal.cx>, linux-mips@linux-mips.org,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ronny.meeus@gmail.com
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

This is exactly the platform we are targeting:
- a Cavium processor
- running 64bit Linux
- 4Gb of ram of which almost 3Gb will be used by 1 process (consisting
of multiple threads)

It would be really great that we could get help from you guys here.
Many thanks for the effort you are putting into this.

On Wed, Oct 10, 2012 at 7:34 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 10/10/2012 10:10 AM, Maciej W. Rozycki wrote:
>>
>> On Wed, 10 Oct 2012, David Daney wrote:
>>
>>> The only disadvantage of doing this is that the code will be slightly
>>> larger/slower as it takes three instructions to load a zero extended
>>> 32-bit
>>> pointer verses two for n32-2GB.
>>
>>
>>   And of course such code will only run on 64-bit processors that not only
>> support 64-bit data, but 64-bit addressing as well.
>
>
> That's right.  All of this assumes a fully 64-bit operating system kernel
> (Linux).
>
> It is not really very interesting on 'small' systems that have less than
> about 1GB of RAM.  And obviously impossible if 64-bit addressing is not
> supported.
>
> So the interesting use cases are 'modern' systems with 4GB or more of ram
> installed.  And only then for the subset of applications that need more than
> 2GB of virtual address space but will never need to consider more than 4GB.
>
>
>
>
>>  That is implement the
>> CP0.Status.UX bit rather than CP0.Status.PX only -- the latters are still
>> compatible with the true n32 ABI.  See also CP0.Config.AT.
>>
>>    Maciej
>>
>>
>
>
