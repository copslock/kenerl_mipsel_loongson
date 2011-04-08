Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2011 17:10:52 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:65341 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491095Ab1DHPKt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Apr 2011 17:10:49 +0200
Received: by pzk5 with SMTP id 5so1518131pzk.36
        for <multiple recipients>; Fri, 08 Apr 2011 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=SvcLItcwgQhKPUixHhjwSOBE/05jxgMRgS9VIM1kJjE=;
        b=DgGja2xZu7obZh6qR4GbMhE5sv96iP+ezy4VXTEXW5QKLiWe5neQt8BmnJAA3h5N1Q
         2O9dGn3MQKiJrS0jAi0YLNWqrD4hKsEFN2yKoFlYqDnRhfwG7KSbbAtqZiITI6EPoTuL
         PU4IVSGJW9Gn2vlmnk15EifxQlTGxelKeHl5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=cdOSltA1C1jTO7FlNp/um0V23AWnoTzTCovoAqzU2Bcz7Pbr2KU1w/JhwCb/ZoSWx1
         hdzXdRVKzPfx/W0S5vzdigD9euPgY0BCPvZdDjzMbpzMhIctk3N8jtloguuvVv6XzNgU
         OUQfsNdTdibimLHFAiKMo0WMRSeuVYkJ36Z9U=
Received: by 10.142.144.15 with SMTP id r15mr1979939wfd.439.1302275441533;
        Fri, 08 Apr 2011 08:10:41 -0700 (PDT)
Received: from [172.16.1.89] (74-206-12-204.static-ip.m.telepacific.net [74.206.12.204])
        by mx.google.com with ESMTPS id w32sm3753253wfh.19.2011.04.08.08.10.40
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 08:10:40 -0700 (PDT)
Message-ID: <4D9F2568.50204@gmail.com>
Date:   Fri, 08 Apr 2011 08:10:32 -0700
From:   "Justin P. Mattock" <justinmattock@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110403 Fedora/3.1.9-6.fc15 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     trivial@kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [RFC 3/5]arch:mips:pmc-sierra:msp71xx:Makefile Remove unused
 config in the Makefile.
References: <1302022702-24541-1-git-send-email-justinmattock@gmail.com> <1302022702-24541-3-git-send-email-justinmattock@gmail.com> <20110408130811.GA17431@linux-mips.org>
In-Reply-To: <20110408130811.GA17431@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <justinmattock@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinmattock@gmail.com
Precedence: bulk
X-list: linux-mips

On 04/08/2011 06:08 AM, Ralf Baechle wrote:
> On Tue, Apr 05, 2011 at 09:58:20AM -0700, Justin P. Mattock wrote:
>
>> The patch below removes an unused config variable found by using a kernel
>> cleanup script.
>> Note: I did try to cross compile these but hit erros while doing so..
>> (gcc is not setup to cross compile) and am unsure if anymore needs to be done.
>> Please have a look if/when anybody has free time.
>
> NACK.
>
> This need a rewrite, not just chainsawing.  Your code was only touching
> the makefile anyway, not the two referenced C files.
>
>   Ralf
>
>    Ralf
>

alright!!

Justin P. Mattock
