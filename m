Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 18:24:50 +0200 (CEST)
Received: from mail-la0-f53.google.com ([209.85.215.53]:58843 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819546Ab3DRQYtu3wp9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Apr 2013 18:24:49 +0200
Received: by mail-la0-f53.google.com with SMTP id fp13so2747581lab.12
        for <multiple recipients>; Thu, 18 Apr 2013 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=w5jyTqZtompb2GJ9u3bTxPNXS1zaDiqLvxZ6d3NgErY=;
        b=bE8rpiRpSgKtY+ECxWpJFwKZJbg78XNdKOpvZfMonB7OiPZ640yD8lHhfQg7xcL9kL
         cZy9Pk3N17a+WkoKidTHsRfL+fL4dfsJCw5ZdvUQCo/IwXJvkZpoWqSAZf3Zg+arAPy2
         ji53N2Rp8fbSXacrmlBLMpmB4yjq2Y9tveLOuhwL55X4/1MbNJyBIoS7OBmOl0TbU0Nf
         gUpvgC9hzIctYXb7FO1aRSHQUUbnKI/IneKewiT9XQhgXWDVFvXQ3Dmf9iW9wYe/CXC4
         b0voBy/gWUynJEJqVU5WBzHZkYnuQBFPLrgJKWZGgKjxwLatro0Cn5h/j1WvzgDPtWyo
         Qy8A==
MIME-Version: 1.0
X-Received: by 10.152.87.73 with SMTP id v9mr6261910laz.2.1366302284070; Thu,
 18 Apr 2013 09:24:44 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Thu, 18 Apr 2013 09:24:43 -0700 (PDT)
In-Reply-To: <20130418124455.GA16655@linux-mips.org>
References: <CAF1ivSZXGY0dUSTVan-VuMVaQrtUOEZuRqhqmnNe-euCj03XAA@mail.gmail.com>
        <20130418124455.GA16655@linux-mips.org>
Date:   Thu, 18 Apr 2013 12:24:43 -0400
Message-ID: <CAF1ivSYkrb_b90GRx+QfB+HehT0K03bMs9ikRJfYYmZE0Zc2uA@mail.gmail.com>
Subject: Re: hard lockup problem
From:   Lin Ming <minggr@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <minggr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minggr@gmail.com
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

On Thu, Apr 18, 2013 at 8:44 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Apr 18, 2013 at 03:13:55PM +0800, Lin Ming wrote:
>
>> I encounter a problem that cpu stuck with irq disabled, which is known
>> as hard lockup.
>> I know there is NMI hard lockup detector for x86, which can dump the
>> back trace of the hard lockup.
>>
>> Is there any similar feature for MIPS?
>
> No, there isn't, unfortunately.
>
> This is because on MIPS an NMI is very different from for example x86.
> An NMI goes straight to a firmware address and most firmware implementations
> don't provided a suitable hook for an OS to gain control back from an NMI.
>
> Generally on MIPS NMIs are used to signal catastrophic problems, things
> like a machine check exception but external to the CPU.
>
> One of the notable exceptions is Octeon where (see the Octeon watchdog
> driver) an OS can regain control after an NMI.  Malta and SGI IP27 also
> have somewhat useful NMIs.
>
>   Ralf
