Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 00:57:10 +0100 (CET)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:41996
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994584AbeBLX5EH1BSv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2018 00:57:04 +0100
Received: by mail-pg0-x241.google.com with SMTP id y8so1363216pgr.9;
        Mon, 12 Feb 2018 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rg5NeLkwXQ2uamTjxkZwGhA5g32BzL436wa/AHLjcek=;
        b=P7Jk0pIBvFK9ezUsC+a7T4q1hLHeolCcsVU28Ie9Szjstp+Uc7tPAPMVAWlsy8rjow
         LrsvwfW6nURy5RqeBvT5EjrMW48NH7DodtUqKO6lMvWTRxFNClAtboCo7LNaqPBAlgO7
         LAWp7tFz5rLqVbeWLx78vXUiKYqCRe6r1dm3no5NHGX2OG63Qo7WdXRprToYxduU+snI
         qS90qQhl0z+fxPe7AJe9HzTd8WmBm8rjtVsmt31fEKAUUutRS3+lc+DaAWK3a3XZt0Gz
         3kyX+3BLN5nMDFvY1LkqZplf4txGqk7fn/9k+Ad3gPZB4lqCTKpe6NEQKsxpSTlngSBK
         /6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rg5NeLkwXQ2uamTjxkZwGhA5g32BzL436wa/AHLjcek=;
        b=DNp7ewQ+K/Q8vdRLNsoJqsjYL3KNQwMykzVZ1eXMCuBhKF7ex3pnWl2ZL2tYs2icI2
         F2yF5AF9fyDvuY1QslWrkyrc2SEnXmPs+CXfZA5Gq8RjzRXBBd4rcNofEeLTF1MvB2AQ
         8sm2h/PU6jtKOp3NJSepOfPmoqLRe5+7fJMskAVUXvGwB2qvmbl1BmfpMWQvUTYd12pQ
         AYqAD/Yd6CY3W8jYwXEzCZLxQcF45lM49qjF5FxBwWvP5uMAOsWYoDhfZPOK4dKe0GZP
         XKbWiRpeatXRFCvHfDA4cH9A7tNwJeHjuSHtEIYw9C7ppBk2qiLzVilLnY5DtgI10TwP
         DSow==
X-Gm-Message-State: APf1xPDHdbtjvd7KcqN6Bphxc1JvdPJQdC+xclKS92VP+vZYInsLYZQ3
        jef2tTt7K6U8qcWRukeNLZ0lYtra
X-Google-Smtp-Source: AH8x224Cg9wwJlNAd+hrf7quN2M9rysa3hjoXDbLgWOwXxKb8gXavQXPyQP3A3cXbisFEo6qd89oSA==
X-Received: by 10.98.226.22 with SMTP id a22mr12671452pfi.24.1518479817488;
        Mon, 12 Feb 2018 15:56:57 -0800 (PST)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a28sm25721405pfe.70.2018.02.12.15.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 15:56:56 -0800 (PST)
Date:   Mon, 12 Feb 2018 15:56:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alice Michael <alice.michael@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>
Subject: Re: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
Message-ID: <20180212235655.GC5199@roeck-us.net>
References: <1518475021-3337-1-git-send-email-linux@roeck-us.net>
 <20180212234201.GB4290@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212234201.GB4290@saruman>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Mon, Feb 12, 2018 at 11:42:02PM +0000, James Hogan wrote:
> Hi Guenter,
> 
> On Mon, Feb 12, 2018 at 02:37:01PM -0800, Guenter Roeck wrote:
> > Since commit 60f481b970386 ("i40e: change flags to use 64 bits"),
> > the i40e driver uses cmpxchg64(). This causes mips:allmodconfig builds
> > to fail with
> > 
> > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
> > 	In function 'i40e_set_priv_flags':
> > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4443:2: error:
> > 	implicit declaration of function 'cmpxchg64'
> > 
> > Implement a poor-mans-version of cmpxchg64() to fix the problem for 32-bit
> > mips builds. The code is derived from sparc32, but only uses a single
> > spinlock.
> 
> Will this be implemened for all 32-bit architectures which are currently
> missing cmpxchg64()?
> 
No idea.

> If so, any particular reason not to do it in generic code?
> 
Again, no idea. When the problem was previously seen on sparc32,
it was implemented there.

> If not then I think that driver should be fixed to either depend on some
> appropriate Kconfig symbol or to not use this API since it clearly isn't
> portable at the moment.
> 
Good point.

> See also Shannon's comment about that specific driver:
> https://lkml.kernel.org/r/e7c934d7-e5f4-ee1b-0647-c31a98d9e944@oracle.com
> 

Well, this was an RFC only. Feel free to ignore it.

FWIW, this is the second time that the call was introduced in the i40 driver.
After the first time the code was rewritten to avoid the problem, but now it
came back. Someone must really like it ;-). For my part, I may just blacklist
the offending driver in my builds; that is less than perfect, but much easier
than having to deal with the same problem over and over again. Guess I'll wait
for a while and do just that if the problem isn't fixed in a later RC.

Guenter
