Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 19:21:39 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:41037
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990483AbdLUSVb4MiW3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2017 19:21:31 +0100
Received: by mail-lf0-x242.google.com with SMTP id f18so28908134lfg.8;
        Thu, 21 Dec 2017 10:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ebK9lAbAXYMHVPdPFGIaOGNl4O82DsV9HQtAbJ7mGsc=;
        b=Qg3q+lvMLlGpoNHnkzTDebIHYiEJZ2r4aN7vxY/1HtFnTlwLIRP0IoBGgo5amfXqvd
         yKvVVLAj4ChKFRL1UJv/vNaZYwePRO88eXp62IvMs3guJc+WZ+9cQEVmZHylwRJJuMTs
         E0oYOmE+eX8hGI0a5q/7lzSrgV3oRvQWwoE7OxruWLe0Ewq4zGWFBk/dNtsAkUiuRTIl
         f7kfL2oB72XZaYMz6qZsorKIxhInXNGu0Yf4niiHgQm9gelXdcsQ1C5jheFK6xrZjJ/e
         7lWXQwztL8BM17iNxGcw4cKPIFbBHSqlxFQMV9lORIRQb866mfq1dCsNsyICtzPu2YF/
         0Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ebK9lAbAXYMHVPdPFGIaOGNl4O82DsV9HQtAbJ7mGsc=;
        b=rnofGo+2tkrVjcSaeZ6QH/jwEOx5Q9dbYyOrQ/2LW3YiS2tYOV7jhgUOw3a/8/jhaZ
         iT4HQLlKpeomyFC6Sa4nnIZsBdYPqPxif+bbC1sWpUx9g3dd6bDok3O+vEyN61kokKqK
         TMtbVQQpQOFCtaYtn6n1RZjzH9tYR+YogB+lRAIn9xVhIrgbg6PljjQ8QksDtISUfoBp
         6MAVttlzS5hLT4ioSUrd3rG6FZeQ5dN0jyBOUBx6vm/qvD074CD55jY6mDzH7cti0LGs
         tYqVyWY7nUWRBEO5xJjgk1PV7L23pQqUY3ntTAYbmzTjgU4yTtJLhZfyALYQzdouJme1
         CQiQ==
X-Gm-Message-State: AKGB3mL6mwAj4Nfgn8wYcZeT1uWTX6MsgxmDDv2sd9ZSzjetq2FnF8JA
        m/MNiM40YIdsrIs4EN2NYSk=
X-Google-Smtp-Source: ACJfBoth0304svb/PzlWWjlv5j0hK23c2Oinr2LkSMsHc5aMfQNmZis57J1bh56EsNsEHtjCc8usSw==
X-Received: by 10.46.93.91 with SMTP id r88mr7450500ljb.39.1513880485402;
        Thu, 21 Dec 2017 10:21:25 -0800 (PST)
Received: from mobilestation ([176.59.45.45])
        by smtp.gmail.com with ESMTPSA id b75sm4499319lfe.47.2017.12.21.10.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2017 10:21:24 -0800 (PST)
Date:   Thu, 21 Dec 2017 21:21:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Matt Redfearn <matt.redfearn@mips.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Peter Wotton <Peter.Wotton@mips.com>
Cc:     ralf@linux-mips.org, rabinv@axis.com, james.hogan@mips.com,
        Marcin.Nowakowski@mips.com, f.fainelli@gmail.com, kumba@gentoo.org,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Paul.Burton@mips.com
Subject: Re: [RFC] MIPS memblock: Remove bootmem code and switch to NO_BOOTMEM
Message-ID: <20171221182127.GA3161@mobilestation>
References: <20171219201400.GA10185@mobilestation>
 <65E0D1C69B83F54F8D5C962B651A2DEC026B902C@MIPSMAIL01.mipstec.com>
 <a3865a42-d0cf-f48d-3bda-e3cd85f5b49b@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3865a42-d0cf-f48d-3bda-e3cd85f5b49b@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Hello folks,

> > -----Original Message-----
> > From: Peter Wotton
> > Sent: 20 December 2017 16:18
> > To: 'Serge Semin'
> > Cc: Paul Burton; Matt Redfearn; 'james.hogan@imips.com'; Marcin
> > Nowakowski
> > Subject: RE: [RFC] MIPS memblock: Remove bootmem code and switch to
> > NO_BOOTMEM
> > 
> > Hi Serge,
> > The imgtec.com email addresses have changed to mips.com following the
> > sale of the MIPS division, so forwarding email for Marcin, MattR, James and
> > Paul (altho' they'll have also received via the LMO list) Regards Peter.
> > Regards
> > Peter.
> >

Thanks Peter. I'll be sending the email to the @mips.com domain then.

> From: Alexander Sverdlin
> To: 'Serge Semin'
> Hello Serge,
> 
> On 19/12/17 21:14, Serge Semin wrote:
> > Almost a year ago I sent a patchset to the Linux MIPS community. The main target of the patchset
> > was to get rid from the old bootmem allocator usage at the MIPS architecture. Additionally I had
> > a problem with CMA usage on my MIPS machine due to some struct page-related issue. Moving to the
> > memblock allocator fixed the problem and gave us benefits like smaller memory consumption,
> > powerful memblock API to be used within the arch code.
> 
> [...]
> 
> > @alexander.sverdlin@nokia.com. Do you still possess the Octeon MIPS64 platform to test the patchset?
> 
> yes, I'd like to test such a serious change on Octeon2. Please include me in the distribution list.
>

Great Alexander! I'll keep you informed then CCing to your email.

> From: Matt Redfearn
> To: 'Serge Semin'
> 
> Yes, we are definitely still interested!
> 
> We have a bunch of MIPS hardware here which we can test any patches you
> submit with, and should be able to lend a hand to cover as many different
> platforms as we can.
> 
> Thanks,
> Matt
> 

Hello Matt. It's great! I'll start reworking the patchset asap and keep you
informed when it's finished. Additional notes will be also provided about the
platforms, which for my opinion might not work and couldn't be properly
quick-fixed.

Regards,
-Sergey
