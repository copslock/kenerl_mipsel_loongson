Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 18:19:00 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:46156 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493100Ab0ACRSx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 18:18:53 +0100
Received: by pzk35 with SMTP id 35so2471458pzk.22
        for <multiple recipients>; Sun, 03 Jan 2010 09:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ADqWtOkmWNRAXak6e5D2rrQDNmCIruLo0UK4TmDi4qo=;
        b=UbT69qXw9uPti8my6Bose/KxDVfYtyK4KB+jA0df3tMhB39YuQ9CjwlTYHbhJvgUTX
         UchFWLZJr3qFJyU8SkxFAIoQ12o/JSTEdx/JZPcsa0j+sExbOZwxEgOWnC4csbaOACh1
         sRzUYJbs33fd5o1apQK2pfsH+mFcH67k5/46c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GY12ynTmXlY2rZO+lUmsBUmE0pCMofK0IUZtLuIeSQQ7FWUzbXEmCHNdW4RWak+9C5
         d8anxJsf1zhUo7wN0moQt+/xeUePCS318o2A6a/gkNLMXaihk7D1pCBpyEDT0bjuz31S
         umCN2fyKVswhmkitpc6TFi+I+y8Bz598IXRl8=
MIME-Version: 1.0
Received: by 10.143.25.9 with SMTP id c9mr198023wfj.7.1262539125091; Sun, 03 
        Jan 2010 09:18:45 -0800 (PST)
In-Reply-To: <20100103171013.GC21156@n2100.arm.linux.org.uk>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> 
        <20100103160313.GA21156@n2100.arm.linux.org.uk> <daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com> 
        <20100103164414.GB21156@n2100.arm.linux.org.uk> <daef60381001030855o3a39c3fdr879e2634fb85c491@mail.gmail.com> 
        <20100103171013.GC21156@n2100.arm.linux.org.uk>
From:   Hui Zhu <teawater@gmail.com>
Date:   Mon, 4 Jan 2010 01:18:25 +0800
Message-ID: <daef60381001030918r26658a26l52133d43d4342a16@mail.gmail.com>
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
X-archive-position: 25480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: teawater@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1956

Sorry I make a mistake, I sent the mail before I complete it.  Maybe
some hotkey or something.

The s2c can get the message from the current panic message is better.
I am not get them for now, maybe it need open some options or
something.

Thanks,
Hui

On Mon, Jan 4, 2010 at 01:10, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 04, 2010 at 12:55:04AM +0800, Hui Zhu wrote:
>> I didn't give the user raw oopses.
>> I give him core file. When the kernel die, do we can get a core file now?
>
> I think there's a communication issue here... clearly you're not
> understanding what I've been trying to tell you.
>
> I don't think I can help you any further.
>
