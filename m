Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 May 2003 18:54:59 +0100 (BST)
Received: from shell.cyberus.ca ([IPv6:::ffff:216.191.236.4]:35338 "EHLO
	shell.cyberus.ca") by linux-mips.org with ESMTP id <S8225217AbTEZRyz>;
	Mon, 26 May 2003 18:54:55 +0100
Received: from hadi (helo=localhost)
	by shell.cyberus.ca with local-esmtp (Exim 4.14)
	id 19KM8n-000FHP-CX
	for linux-mips@linux-mips.org; Mon, 26 May 2003 13:52:09 -0400
Date: Mon, 26 May 2003 13:52:09 -0400 (EDT)
From: Jamal Hadi <hadi@shell.cyberus.ca>
To: linux-mips@linux-mips.org
Subject: Re: profiling SMP/SB1250
In-Reply-To: <20030525001222.B54761@shell.cyberus.ca>
Message-ID: <20030526135012.S58731@shell.cyberus.ca>
References: <20030525001222.B54761@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <hadi@shell.cyberus.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hadi@shell.cyberus.ca
Precedence: bulk
X-list: linux-mips


As a followup to my own question and incase someone is interested;
profiling works fine - you need to use -n option to readprofile
(which is not needed in x86).
If anyone knows what tools to use check cache misses etc on the
bcom 1250, please email me.

cheers,
jamal

On Sun, 25 May 2003, Jamal Hadi wrote:

>
> Hi,
>
> Newbie to MIPS here and not on the list (so cc me please).
> I am playing around with a SB1250 board; it has two CPUs. Attempt to
> kernel profile:
> on bootup selected profile=2 to enable profiling(validated because
> /proc/profile shows up). readprofile produce some strange
> output after i ran a lot of interupt related stresses. The output seems
> to claim the CPU was idle ... I know it was not.
> The SB1250 ties all IO interupts on CPU0 - i wonder if this was causing me
> some issues? Is what i am doing the right way to turn on profiling on
> MIPS or the SB1250?
>
> cheers,
> jamal
>
>
>
