Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 18:14:00 +0200 (CEST)
Received: from gateway05.websitewelcome.com ([69.93.154.37]:59542 "HELO
        gateway05.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492033Ab0EDQN4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 18:13:56 +0200
Received: (qmail 7748 invoked from network); 4 May 2010 16:15:47 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway05.websitewelcome.com with SMTP; 4 May 2010 16:15:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=FQRMIA2+mRKO2cVJHXTkegtB4GBTOQQfFomtsHMu8mh5BO3UShGUq1sD0W0i1M0YYilHBgu69D3wsJ/Zm/VRwlUsohLm0RHhET23daW/36lhAQYl31n9Ytv5A+3y5jUX;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:3350 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O9KkF-0006cN-RC; Tue, 04 May 2010 11:13:15 -0500
Message-ID: <4BE0479E.6060506@paralogos.com>
Date:   Tue, 04 May 2010 09:13:18 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
References: <E1O8lDn-0000Sk-86@localhost> <4BDF366E.5000501@paralogos.com>       <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>        <4BDF8092.1060401@paralogos.com>        <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>        <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>        <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>        <4BE00207.6030506@paralogos.com> <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com>
In-Reply-To: <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Shane McDonald wrote:
>
> In the following chunk of code from cp1emu.c:
>   
[snip]
> value gets set to an initial value of 0x400, and ctx->fcr31
> comes in with an initial value of 0x8420.
> By the time we hit the if statement around the return SIGFPE, ctx->fcr31
> has been set to 0x8400, not the 0x400 I implied.
>   
Ah, well that would rather change things, and you *would* get an
exception there.  As written, the code doesn't seem to allow the pending
exception (.._X) bits to be cleared by the CTC.
> Nevertheless, that's not the problem.  
Maybe it is.  I don't have my MIPS specs handy anymore, but just what is
supposed to clear a pending exception bit in a real FPU?
> You've given me some good pointers
> for where to begin searching for the problem.
>
> If anyone out there has a verification suite they can run on the emulator,
> that would be much appreciated!
>   
What we used to use was what I *thought* was an old public domain
program whose name was an English word that had something to do with
being exacting.  Googling with obvious keywords didn't turn it up.

          Regards,

          Kevin K.
