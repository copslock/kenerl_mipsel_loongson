Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 18:38:20 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:64301 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491892Ab0ACRiI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2010 18:38:08 +0100
Received: by pzk35 with SMTP id 35so2476445pzk.22
        for <multiple recipients>; Sun, 03 Jan 2010 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ajeM29bon0W4+LHcKUrMqnmWm0CgpYBqP3BFuio5NHU=;
        b=Y6+3UE2HP2KGqPnIUDavLVPdrP6NUcShaQ9jWbEF+Ag/pI4jIDrNT1ROnQbQQtv1oR
         MZNQXXYXIIb7u4uoiO1lpEiI/YsUfdi1rTLAVIzNST8lgiDowKoF5z2+gnXQT/SdB2tC
         rL1HpjJMytB3kHddNb8VXr0g2M27qBqHXyQ20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=juUCw70UxF0yOxHpwVywbEepP2up/+RZzVcGksVR1nPm9OkogqemWHE2Kj5cyWo20f
         OLdhGs5wqEf5ckWmF8PvR8hQGYaOGIKwtiu2WhJUgEKroWzU61zdZRszyLxs3muD5PWd
         AfMBJliYt9IKJTbdFm0YglK1Wy+jF+DDXvzfc=
MIME-Version: 1.0
Received: by 10.142.60.3 with SMTP id i3mr14712326wfa.147.1262540280173; Sun, 
        03 Jan 2010 09:38:00 -0800 (PST)
In-Reply-To: <daef60381001030918r26658a26l52133d43d4342a16@mail.gmail.com>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> 
        <20100103160313.GA21156@n2100.arm.linux.org.uk> <daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com> 
        <20100103164414.GB21156@n2100.arm.linux.org.uk> <daef60381001030855o3a39c3fdr879e2634fb85c491@mail.gmail.com> 
        <20100103171013.GC21156@n2100.arm.linux.org.uk> <daef60381001030918r26658a26l52133d43d4342a16@mail.gmail.com>
From:   Hui Zhu <teawater@gmail.com>
Date:   Mon, 4 Jan 2010 01:37:40 +0800
Message-ID: <daef60381001030937w16f0cc66x7376abdf14e36b4d@mail.gmail.com>
Subject: Re: [PATCH] stack2core: show stack message and convert it to core 
        file when kernel die
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     saeed bishara <saeed.bishara@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
        Chris Dearman <chris@mips.com>,
        Paul Gortmaker <Paul.Gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Brian Gerst <brgerst@gmail.com>, Tejun Heo <tj@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Coly Li <coly.li@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: teawater@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1962

And gdb need a message that seems panic doesn't show:
LKM address message. like:
S2C:add-symbol-file e.ko 0xffffffffa0000000

Thanks,
Hui

On Mon, Jan 4, 2010 at 01:18, Hui Zhu <teawater@gmail.com> wrote:
> Sorry I make a mistake, I sent the mail before I complete it.  Maybe
> some hotkey or something.
>
> The s2c can get the message from the current panic message is better.
> I am not get them for now, maybe it need open some options or
> something.
>
> Thanks,
> Hui
>
> On Mon, Jan 4, 2010 at 01:10, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Jan 04, 2010 at 12:55:04AM +0800, Hui Zhu wrote:
>>> I didn't give the user raw oopses.
>>> I give him core file. When the kernel die, do we can get a core file now?
>>
>> I think there's a communication issue here... clearly you're not
>> understanding what I've been trying to tell you.
>>
>> I don't think I can help you any further.
>>
>
