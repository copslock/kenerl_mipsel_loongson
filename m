Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 18:55:57 +0200 (CEST)
Received: from mail-qg0-f41.google.com ([209.85.192.41]:36259 "EHLO
        mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817913AbaE2QzzGiltm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 18:55:55 +0200
Received: by mail-qg0-f41.google.com with SMTP id j5so1811760qga.14
        for <linux-mips@linux-mips.org>; Thu, 29 May 2014 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5izgH0HqxJfwzJM0jLr6387w1r20HpO23Ved4JOGNtg=;
        b=FO1wcpOwRf+bS+iT9X+siUZJUqdx7xt9QV2RdFR7KBWpNyeVsSxfTyoBIkrYd1yXmI
         RY+kWyvyd9KvtUqD3n9pB+Rnmq+bVBPOtBaOB1fIyWNmt+V7FQ32jSIZx79oSMCGeM9d
         WUXSV3JfyGcwVLJW6GCYrc7hUQW86VBuY8QauKMmDc9PahZGa7Aw2PIDVjf6BhGzbRZ2
         5aXLDpyV6FMzFKh2LzCwsBDhETBbnb8yvmFrF7jhoD3xhpsEyJNQzYeoo7q3Aaj6QK9z
         dHHj0j6VrtqiKnZldiAZJGV/0fi15PKi7H/+3Mru90lpaKlDCQLs6BX9F4BsWeXsIUKW
         Ly9w==
X-Received: by 10.140.92.54 with SMTP id a51mr11733963qge.23.1401382549014;
 Thu, 29 May 2014 09:55:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.96.147.163 with HTTP; Thu, 29 May 2014 09:55:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1405291100320.1285-100000@iolanthe.rowland.org>
References: <1401358203-60225-4-git-send-email-alex.smith@imgtec.com> <Pine.LNX.4.44L0.1405291100320.1285-100000@iolanthe.rowland.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 29 May 2014 09:55:08 -0700
Message-ID: <CAGVrzcZuo2MvMv20W4zJQxkK3JBxD8L_tfkZoP=s175__kDQ3Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb host/MIPS: Remove hard-coded OCTEON platform information.
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-usb <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40360
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

2014-05-29 8:03 GMT-07:00 Alan Stern <stern@rowland.harvard.edu>:
> On Thu, 29 May 2014, Alex Smith wrote:
>
>> From: David Daney <david.daney@cavium.com>
>>
>> The device tree will *always* have correct ehci/ohci clock
>> configuration, so use it.  This allows us to remove a big chunk of
>> platform configuration code from octeon-platform.c.
>
> Instead of doing this, how about moving the octeon2_usb_clocks_start()
> and _stop() routines into octeon-platform.c, and then using the
> ehci-platform and ohci-platform drivers instead of special-purpose
> ehci-octeon and ohci-octeon drivers?

How about they get their changes in now, and eventually they cleanup
the octeon driver in the future? My personal experience with that sort
of request, is that I had to come up with 50+ patches to clean up the
Kconfig mess that USB drivers had back then and I still have not
re-submitted the bcm63xx USB patchset.

It is fair to pinpoint what *should* be improved and what the next
steps could look like, it is not fair to ask people submitting changes
to come up with a much bigger task before their patches can be merged.
-- 
Florian
