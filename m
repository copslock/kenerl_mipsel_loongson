Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2014 17:12:09 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46704 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6839123AbaHKPME0RMck (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Aug 2014 17:12:04 +0200
Received: by mail-pa0-f46.google.com with SMTP id lj1so11339018pab.33
        for <linux-mips@linux-mips.org>; Mon, 11 Aug 2014 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PfVSF7MwGzHZKMdLwHtwnIrbUMITmMF26McsY5pr2q0=;
        b=l/4gYapwHAs9qN+jHzBHLFogV/3jKUwSnEUfERfqO87jcqtiB2NqKwYbb+59LPpDrz
         NtToBtoxF0NmjaJeMssB/W12OjQJ/Kzmt79jyiYVQxdast1HJjyt7maaSDpYazQLLM/j
         6VLCZBtsO3CDtBmDFrA7Q4n7Nm4nycaJ7T9n/GsrGCuJRGXYj0v0iNM44BEjfXDhPYcM
         amGbjO7a+vpaZciKxeKtc8A42QSIWLiwIQOQ6dBUdyGhcjnsXduUKKJpUq64d6//U3k6
         +NZgbPgGrUxqax6aKpJZJSAcD4fbi1i7Wzq7jrGbBpYaYk3nQOHe4+qqK5m3iovPDPNB
         M6VA==
X-Received: by 10.68.176.5 with SMTP id ce5mr42655236pbc.93.1407769917728;
        Mon, 11 Aug 2014 08:11:57 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id wd15sm4138259pbc.25.2014.08.11.08.11.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Aug 2014 08:11:57 -0700 (PDT)
Date:   Mon, 11 Aug 2014 08:11:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: MIPS: hang in kmalloc with seccomp writer locks
Message-ID: <20140811151153.GA14365@roeck-us.net>
References: <CAOLZvyFuDqi4+pEae=n7+ZJoAx-vca-pRS8ZAQqvTk-tSyPiwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLZvyFuDqi4+pEae=n7+ZJoAx-vca-pRS8ZAQqvTk-tSyPiwg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41952
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

On Mon, Aug 11, 2014 at 01:35:28PM +0200, Manuel Lauss wrote:
> Hi Kees,
> 
> My MIPS32 toys hang early during bootup at the first kmalloc() with
> seccomp enabled.
> I've bisected it to commit dbd952127d11bb44a4ea30b08cc60531b6a23d71
> ("seccomp: introduce writer locking").  And indeed, reverting this
> commit fixes the hang.
> 
> I'm not sure if seccomp is even working on MIPS, but I've never had
> problems with
> it before so I thought I let you know.
> 

Also see [1] and [2], the latter providing a patch to fix the problem.
The problem is only seen in unicore systems with lock debugging disabled.

Guenter

---
[1] https://lkml.org/lkml/2014/8/9/163
[2] https://lkml.org/lkml/2014/8/10/184
