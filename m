Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2015 15:46:38 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36121 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009724AbbDBNqg7MoKk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2015 15:46:36 +0200
Received: by wizk4 with SMTP id k4so15837006wiz.1
        for <linux-mips@linux-mips.org>; Thu, 02 Apr 2015 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Kk1qkmPzwbIpm8NAVf58qfV7vJjhxKByoGkb3H+KKXI=;
        b=O0pDAgI62l3Tk6ZbQB8m0RTyBItnGjPEoXb4YAyzxObdpBN9R4r3Ao1uobAlbq/dwc
         wg3af/bVGWYTz0zHdwEn40rf+/YCKuZK6+O3Zfo/EoISB4b+2L+vJnzPD96v4zlVApK4
         wpeH6VP8ij+CGBai4OW9MBZCAwH9bDiP+avGByX5dJE8LC6xMg/ncfySjCWnaeRBB5b9
         9DnQmXFQEVEe0XTbNyVdNDgqnOxdkjccYsou+al+l0s8bI/z3H2uylN7RnRG6X/T0mXY
         8yFCeCqQ15IkqmeB5bTm/lAiJQ9Cq+uVpuwXowlkMgfomwIjBY1mi/jCzuGukUsVar97
         3PqQ==
X-Received: by 10.180.74.238 with SMTP id x14mr3369528wiv.81.1427982392868;
 Thu, 02 Apr 2015 06:46:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.139.21 with HTTP; Thu, 2 Apr 2015 06:46:12 -0700 (PDT)
In-Reply-To: <5516DE64.6000104@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com>
 <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Apr 2015 08:46:12 -0500
X-Google-Sender-Auth: R_dlceH6rkw1dfgaDtk1ODXaMjw
Message-ID: <CAL_JsqKQD2ivpZ5kOy8ehmzsdFy8EMFZ-KvO2QS3fxtLgQL8Lw@mail.gmail.com>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT properties
To:     Peter Hurley <peter@hurleysoftware.com>
Cc:     Grant Likely <grant.likely@linaro.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Sat, Mar 28, 2015 at 12:01 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Hi Grant,
>
> On 03/27/2015 09:36 PM, Grant Likely wrote:
>> On Sun, 01 Mar 2015 17:23:11 -0500
>> , Peter Hurley <peter@hurleysoftware.com>
>>  wrote:

[...]

>> Something like the following would do it and would be future-proof. We
>> can add support for 16 or 64bit big or little endian access if it ever
>> became necessary.
>
> I was planning on adding MEM32BE support to OF earlycon on top of my
> patch series 'OF earlycon cleanup', which adds full support for the
> of_serial driver DT properties (among other things).
>
> Unfortunately, that series is waiting on two things:
> 1. libfdt upstream patch, which I submitted but was referred back to me
> to add test cases. That was 3 weeks ago and I simply haven't had a free
> day to burn to figure out how their test matrix is organized. I don't
> think that's going to change anytime soon; I might just abandon that patch
> and do the string manipulation on the stack.
>
> ATM, earlycon is still broken if stdout-path options have been set.

Given David was okay with the patch itself, I suppose we could go
ahead and apply it to the kernel copy. If you're going to require
testcases, it should be trivial and/or documented on how to add...

> 2. Rob never got back to me on my query [1] to unify the OF_EARLYCON_DECLARE
> macro with the EARLYCON_DECLARE macro so that all earlycon consoles
> are named.

Sorry about that. I had thought about doing the same thing. At least
unifying the macros, but not necessarily the tables. If it is also
extendable to other firmware interfaces like ACPI perhaps that would
be good.

Rob

>
> Regards,
> Peter Hurley
>
> [1] https://lkml.org/lkml/2015/3/6/571
>
