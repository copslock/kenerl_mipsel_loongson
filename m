Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2011 08:04:32 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:52786 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab1C0GE2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Mar 2011 08:04:28 +0200
Received: by iyb39 with SMTP id 39so2211926iyb.36
        for <linux-mips@linux-mips.org>; Sat, 26 Mar 2011 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mdr8Dd4AftXsBiJ+4FWkaN+DQHLQf/U3l0QqOC06FFc=;
        b=vweRZay9eo3Ny7ZU6wYjzS/l28Gw+y1uU00hy/bn/I6azxr2wX0LYxMtBYcK7cxm+e
         /DkxBHyXI7I9ljWiHpOk8L091jf/Ar6If7dJtxxRqK/xIcvB1HqeQ6FhwO6zpIjBRg8v
         RsYtG75ruGCyfka6+TDsNmRUiNwuby4B8cVOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PKXvtv+pjPYjliJHn5wOkPloTR8fla3wCdwWwa1ulG+2I1tZ7IkTGSBuJGmBVVcQsc
         UcciYL8YbzCql9PtVNf4ORW1Q+Y8fMnZWf5XWbuItJGuh1XaAP2/5BtHLZpvEz3HrrWG
         9ZR/PHkMoYOVCHNb4TkLGKV7ptOQPhMVIlzo8=
Received: by 10.42.239.74 with SMTP id kv10mr4018472icb.402.1301205862552;
        Sat, 26 Mar 2011 23:04:22 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-127-59-9.dsl.pltn13.pacbell.net [67.127.59.9])
        by mx.google.com with ESMTPS id g16sm1961933ibb.20.2011.03.26.23.04.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Mar 2011 23:04:21 -0700 (PDT)
Message-ID: <4D8ED363.9050001@gmail.com>
Date:   Sat, 26 Mar 2011 23:04:19 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.38.b3pre.fc13 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Gergely Kis <gergely@homejinni.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Oprofile callgraph support on the MIPS architecture
References: <AANLkTinDFQFLiHZoKw2kPpVov80xc08FFxLjYsORKyKd@mail.gmail.com>
In-Reply-To: <AANLkTinDFQFLiHZoKw2kPpVov80xc08FFxLjYsORKyKd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 03/26/2011 07:02 PM, Gergely Kis wrote:
> Dear List Members,
>
> We would like to announce the initial version of oprofile callgraph
> support on the MIPS architecture.
>
[...]

> You may download the code and access the documentation on the following URL:
> http://oss.homejinni.com/redmine/projects/mips-oprofile
>

Instructions for submitting patches may be found here:

http://git.linux-mips.org/?p=linux.git;a=tree;f=Documentation/development-process;hb=f70c04ff7ad61bca1ed06390558568c6c8074139

That said, how do you handle the case of getting a fault while reading 
code/data while unwinding?

Also I don't see how you handle these cases:

o Leaf functions where neither the $ra is saved to the stack, nor the 
stack pointer adjusted.

o Functions where $sp is adjusted several times (use of alloca() or VLAs).

o Functions with multiple return points (i.e. 'jr $ra' in the middle of 
a function).

o Functions with more than 1024 instructions.


Thanks,
David Daney
