Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2012 21:49:41 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3845 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903704Ab2EVTti (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2012 21:49:38 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4fbbed990000>; Tue, 22 May 2012 12:48:46 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 22 May 2012 12:46:39 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 22 May 2012 12:46:39 -0700
Message-ID: <4FBBED1F.5010307@cavium.com>
Date:   Tue, 22 May 2012 12:46:39 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Songmao Tian <kingkongmao@gmail.com>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: handle_sys question
References: <CADSewLWvfVsQob-y5Q9mc31JpecHFd6=5dRhKxdH3VvT0HXJZQ@mail.gmail.com>
In-Reply-To: <CADSewLWvfVsQob-y5Q9mc31JpecHFd6=5dRhKxdH3VvT0HXJZQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2012 19:46:39.0390 (UTC) FILETIME=[9AC8BBE0:01CD3853]
X-archive-position: 33428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/22/2012 02:40 AM, Songmao Tian wrote:
> Hello all:
>     In handle_sys there's a
> 50
> <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/kernel/scall32-o32.S;h=a632bc144efa1b9ca977a582864530e33ee039cb;hb=72c04af9a2d57b7945cf3de8e71461bd80695d50#l50>
>          sw      a3, PT_R26(sp)          # save a3 for syscall restarting
>
> I woner why it need to save  a3 in R26(k0) slot in the stack?
>

It has to go somewhere.  The K0 and K1 slots aren't used to save other 
things.

David Daney
