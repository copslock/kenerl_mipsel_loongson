Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2010 18:17:27 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:57053 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491947Ab0EMQRY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 May 2010 18:17:24 +0200
Received: by pwj6 with SMTP id 6so809736pwj.36
        for <multiple recipients>; Thu, 13 May 2010 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=JjWim9+v1ofwPtBhgBPwkynPiwC3QPhKXWSGM+N5fKQ=;
        b=h6jSIAbJrF+USEzY7VJuWFe8H0/MLX45qcxkC9GGctMO7fVZKhI2/ksjOoM+8A3CGX
         Z+EKkV33wiyLAfcT6rDJH+LYgIXHKdWEA8pT5mzRgxSfdY/Q8QzdoKFdqcUH0kUy0KCL
         62Pg+TuqE4HVxWsfDU75+N7KDgplOqdgJJMlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=RdAo5f350ldPQ+AB12aEuKVKqz99YHbkxmFf+d3WkqY4tEdtG4awxAG4Y2F/O/p6xk
         kjPCXNBXw5MwIbk+fkHEHQgGwjgW27GuK6IKed5rhMW2jBNI+jiQPSVidyLGBYk//l/L
         60TqDzeyskbpm/5ZyZMbcLPzBuq3eAqsB7hsw=
Received: by 10.142.248.22 with SMTP id v22mr6477865wfh.276.1273767436391;
        Thu, 13 May 2010 09:17:16 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id 22sm1026427pzk.1.2010.05.13.09.17.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 09:17:15 -0700 (PDT)
Message-ID: <4BEC2609.6040000@gmail.com>
Date:   Thu, 13 May 2010 09:17:13 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 9/9] tracing: MIPS: cleanup of the address space checking
References: <cover.1273669419.git.wuzhangjin@gmail.com> <86404e31ca5c4c33b785bad7f6223ac775f4f879.1273669419.git.wuzhangjin@gmail.com> <4BEAE19D.40502@gmail.com> <20100513161357.GA5810@linux-mips.org>
In-Reply-To: <20100513161357.GA5810@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/13/2010 09:13 AM, Ralf Baechle wrote:
> On Wed, May 12, 2010 at 10:13:01AM -0700, David Daney wrote:
>
>> The kernel is always compiled with -msym32, so the patch is a bit pointless.
>
> Not quite true.  Some systems only have enough memory for the exception
> vectors in the low 512MB of physical address space, so these can't use
> an -msym32 kernel.
>
> My general impression is that hardware designers "design" address maps by
> throwing darts over their shoulder after a few pints ;-)
>

Well it was mostly a rhetorical point.  Of course -msym32 is not 
universal, but it is more common than not I would say.  Because of that, 
we should take a few more minutes and figure out how to make ftrace work 
well with it.

David Daney
