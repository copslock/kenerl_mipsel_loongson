Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 21:38:59 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:33068
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993913AbdBCUiw7dxe5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2017 21:38:52 +0100
Received: by mail-pf0-x243.google.com with SMTP id e4so2235647pfg.0;
        Fri, 03 Feb 2017 12:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=No/HjPTrVYq0xf38EmCiZjT0c37alOaAal/S4P/GVEE=;
        b=DPBCI4QARZwYQJFmwmDs06PwMj5yPCFkCl31ALCLs2slnEmTSPMEZ+GJ/A5wvc9mKd
         n2BgE7mQCmsbqePggYvFMOi0EKOwJpcR0SOdAgcapvLXmNGyPQ7PIfs9pOPgNntKLE8U
         ZuMftOPUV5lnUfRBWyRuvEKpaJIbEymjqKZ+y4OySGysIePSXMcJMqcowFr5iILIdb2U
         5oEafANLW9qvCFL92nhRagIy3ZRsIElgQytBNtvB76/odw3k+joy9VrS0OA/148MYw8V
         HwanUFQsNrcinVvZAsCu8RWVZiJ3WGHi4WNvngQ3C7mO8fivakO5uh/MfgWl01xSoeMP
         pRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=No/HjPTrVYq0xf38EmCiZjT0c37alOaAal/S4P/GVEE=;
        b=SYbPWR4C3TrV7hHCpE5FYdAr1DPJPLB3a2OU8+l9P+B7BMdHyzJKC67aWZVm3AAc2c
         RS7Gg/ij9K8l3Y07TbzgSm+5vJBbYnghDgXWKCdAIZDHLqdsNUbiXJEr8eZd3bOY9TVS
         O5XVz+TIHDaUzziBlZ/PTZu33Ib8hzzDVq3pJReiPASwrJ6bxVfPe3X0lIMOxP4Q23/I
         mZH2W7RjUVv/F4BBCAYlbgXUQ02qzha8ioO0W7GKXikNAJwAFzXiF2IFhWE04973hk36
         wIcW8aqp6zka+/eyW1eWZx8JEdg5z6UHdT138QITnz6fhRDJrUwoVyTuSkaOtwwBbeE3
         1DjQ==
X-Gm-Message-State: AIkVDXIWHJz2Z5isYFlHsG9e6DOQpLEYEtQtHalntmpFJw7CJOKF3WNqHSIxSiGwecLwzA==
X-Received: by 10.84.216.86 with SMTP id f22mr23779820plj.117.1486154327058;
        Fri, 03 Feb 2017 12:38:47 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id w2sm69287579pfi.65.2017.02.03.12.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2017 12:38:46 -0800 (PST)
Subject: Re: Is it time to move drivers/staging/netlogic/ out of staging?
To:     Greg KH <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>
References: <1486147623.22276.70.camel@perches.com>
 <e160890d-ed79-4e63-57af-1489064d49cb@gmail.com>
 <1486148236.22276.72.camel@perches.com> <20170203203609.GA14271@kroah.com>
Cc:     "Jayachandran C." <c.jayachandran@gmail.com>,
        devel@driverdev.osuosl.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <50640771-abc2-dd9a-7418-7393afe23cd5@gmail.com>
Date:   Fri, 3 Feb 2017 12:38:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170203203609.GA14271@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 02/03/2017 12:36 PM, Greg KH wrote:
> On Fri, Feb 03, 2017 at 10:57:16AM -0800, Joe Perches wrote:
>> On Fri, 2017-02-03 at 10:50 -0800, Florian Fainelli wrote:
>>> (with JC's other email)
>>
>> And now with Greg's proper email too
>>
>>> On 02/03/2017 10:47 AM, Joe Perches wrote:
>>>> 64 bit stats isn't implemented, but is that really necessary?
>>>> Anything else?
>>>
>>> Joe, do you have such hardware that you are interested in getting
>>> supported, or was that just to reduce the amount of drivers in staging?
>>> I am really not clear about what happened to that entire product line,
>>> and whether there is any interest in having anything supported these days...
>>
>> No hardware.  Just to reduce staging driver count.
> 
> Without hardware or a "real" maintainer, it shouldn't be moved.
> 
> Heck, if no one has the hardware, let's just delete the thing.

I do have one, and other colleagues have some too, but I am not heavily
using it, nor do I have many cycles to spend on that... sounds like we
could keep it in staging for another 6 months and see what happens then?
-- 
Florian
