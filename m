Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Apr 2010 19:11:02 +0200 (CEST)
Received: from mail1.adax.com ([208.201.231.104]:7354 "EHLO mail1.adax.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492732Ab0DVRK7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Apr 2010 19:10:59 +0200
Received: from static-151-204-189-187.pskn.east.verizon.net (static-151-204-189-187.pskn.east.verizon.net [151.204.189.187])
        by mail1.adax.com (Postfix) with ESMTP id E7890120E71;
        Thu, 22 Apr 2010 10:10:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 0AA91400582;
        Thu, 22 Apr 2010 13:10:49 -0400 (EDT)
X-Virus-Scanned: amavisd-new at pskn.east.verizon.net
Received: from static-151-204-189-187.pskn.east.verizon.net ([127.0.0.1])
        by localhost (static-151-204-189-187.pskn.east.verizon.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mCHZaBnXtf1W; Thu, 22 Apr 2010 13:10:47 -0400 (EDT)
Received: from [192.168.1.76] (jr001327.mtl-nj.adax [192.168.1.76])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 5B27E400431;
        Thu, 22 Apr 2010 13:10:47 -0400 (EDT)
Message-ID: <4BD08329.80804@adax.com>
Date:   Thu, 22 Apr 2010 13:11:05 -0400
From:   Jan Rovins <janr@adax.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Jian Wang <dominicwj@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Ask help:why my 64-bit ELF file could not run at the 64-bit mips
 cpu
References: <j2sdf5e30c51004172251z9fd01867h562b99c1f1044c26@mail.gmail.com> <q2odf5e30c51004220901l8bfa979ftc9c6a7b633569460@mail.gmail.com>
In-Reply-To: <q2odf5e30c51004220901l8bfa979ftc9c6a7b633569460@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <janr@adax.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: janr@adax.com
Precedence: bulk
X-list: linux-mips

Jian Wang wrote:
> Hi,
>
>  I have a 64-bit mips cpu, and compiled a 64-bit application, but this
>  application could not run. (the target is running Linux)
>  The details is:
>  1)if I compile the application with -mabi=n64, this program could not
>  run, when I run it in the shell, it prompts "command not found"
>  2)but if I compile the application with -mabi=n32, it runs well and
>  gives the correct result.
>
>  I am wondering why with "-mabi=n64", this program could not run? I
>  checked the CP0(status register), Bit px=0b0, KX=0b1, SX=0b1, UX=0b1,
>  it seems that in User Mode, it accepts 64-bit operation.
>
>  Anybody could give me some help? Any comments is much appreciated!!
>
>  BR/Dominic
>
>   
Perhaps you do not have the "n64" system libraries set up correctly in 
userspace.
I have seen the "command not found" error when some fundamental 
libraries or the loader was missing.

Do you have a /lib64 & /user/lib64?
Run the file command on some of those libraries & see if they are n64 or 
n32 libs.

double check your ld.so.conf to make sure it points to every thing you need.
re run ldconfig if you change something.


Jan
