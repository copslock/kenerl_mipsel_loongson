Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2015 11:28:58 +0100 (CET)
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34751 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007818AbbLNK2zcgxU2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Dec 2015 11:28:55 +0100
Received: by mail-wm0-f47.google.com with SMTP id p66so54970315wmp.1
        for <linux-mips@linux-mips.org>; Mon, 14 Dec 2015 02:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=xJVreFyNkFnmjAd05UMMrFfnaNHgkYQCgd0h3L5Rwho=;
        b=lsPhy2M28imMj2OwWO+y9ogrpnH7PgpRT72x14XhD7CGKfRuhvGNWawjyPEwHVr3ib
         4tZfO8kcrR0R2OUJjMQQMqAWZFPF76+emCTfIB2LUBtHVusnYpZgbHSoRCJ5wi9wHS+f
         7nY4OWX+pcHfHQW3w292uwaw/Didb12IZJ9BDvSmPZ6R1B/8fvsv7qX6kaC93HQPk7Ib
         zvoGLSBM30aGMVF0X3JlHls300fiOCxNUJESamlUp8Cf+cs9hF94ShTEn9vL23pGozLA
         LzqMtSiEp8kUZH30iQM7d0NUJFMrwNV51MS73L5IQGbdNIe3ItF5SqX6zD4MXE9ax/Nt
         GpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xJVreFyNkFnmjAd05UMMrFfnaNHgkYQCgd0h3L5Rwho=;
        b=PzM1mX5I2+p7sXogj5MeM0z14SRxYZr5uybsUekpG3ByhSrrJjvfQCIYWvBhZ20yRS
         VK6bbI7qTolVLgxmUm4brgSCtd9QLNPWA77EBaL1TbzUH+rJQYA/uVXewTLgPakNUxYi
         hTbirwKcRziGaErRrHnouapJaeNkDzRgR/8wj4mYhN/FnN5Mzb4gxQoGkffYiXc+mGdp
         g9geYtYQWpdpBOg6y7FOTZ6+OffboNiYeYSCPni8ZPowh4VaApB4h+mH07pcNjNLIQkr
         ycTrpCr2aoswhXsPnAkuL8nkhHqorm/yvV8OPynh8GcPEpQtp3Y/gqzVDLYUj5IJhwc8
         WGgw==
X-Gm-Message-State: ALoCoQnJCgG/dPwAk8AYIzspb7f8Zl5NFodKVAZ/ijxTv6C4HQU/XDPgKfB0BE3uaZOJJ5XXCtKMtHSJByzaIqcQrJCYG/Pphw==
X-Received: by 10.194.89.226 with SMTP id br2mr40816005wjb.22.1450088930267;
        Mon, 14 Dec 2015 02:28:50 -0800 (PST)
Received: from [192.168.1.125] (cpc4-aztw19-0-0-cust71.18-1.cable.virginm.net. [82.33.25.72])
        by smtp.googlemail.com with ESMTPSA id da10sm29024491wjb.22.2015.12.14.02.28.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Dec 2015 02:28:49 -0800 (PST)
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
Cc:     Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Cris <linux-cris-kernel@axis.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <566E99DF.6050008@linaro.org>
Date:   Mon, 14 Dec 2015 10:28:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <20151211232113.GZ8644@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.thompson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.thompson@linaro.org
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

On 11/12/15 23:21, Russell King - ARM Linux wrote:
> As I explained when I did that work, the vast majority of ARM platforms
> are unable to trigger anything like a NMI - the FIQ is something that's
> generally a property of the secure monitor, and is not accessible to
> Linux.  However, there are platforms where it is accessible.
>
> The work to add the FIQ-based variant never happened (I've no idea what
> happened to that part, Daniel seems to have lost interest in working on
> it.)  So, what we have is the IRQ-based variant merged in mainline, which
> would be the fallback for the "FIQ not available" cases, and I carry a
> local hack in my tree which provides the FIQ-based version - but if it
> were to trigger, it takes out all interrupts (hence why I've not merged
> my hack.)
>
> I think the reason that the FIQ-based variant has never really happened
> is that hooking into the interrupt controller code to clear down the FIQ
> creates such a horrid layering violation, and also a locking mess that
> I suspect it's just been given up with.

I haven't quite given up; I'm still looking into this stuff. However 
you're certainly right that connecting the FIQ handler to the GIC code 
in an elegant way is tough.

I've been working in parallel on an arm64 implementation with the result 
that I'm now two lumps of code that are almost, but not quite, ready.

Right now I hope to share latest arm code fairly late in the this 
devcycle (for review rather than merge) followed up with a new version 
very early in v4.6. Even now I think the code needs a long soak in -next 
just in case there are any lurking regressions on particular platforms.

I don't expect anyone to base decisions on my aspirations above but 
would like to reassure Russell that I haven't given up on it.


Daniel.
