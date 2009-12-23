Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Dec 2009 11:42:56 +0100 (CET)
Received: from kuber.nabble.com ([216.139.236.158]:33110 "EHLO
        kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491935AbZLWKmw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Dec 2009 11:42:52 +0100
Received: from isper.nabble.com ([192.168.236.156])
        by kuber.nabble.com with esmtp (Exim 4.63)
        (envelope-from <lists@nabble.com>)
        id 1NNOg4-0001CD-Ve
        for linux-mips@linux-mips.org; Wed, 23 Dec 2009 02:42:48 -0800
Message-ID: <26897656.post@talk.nabble.com>
Date:   Wed, 23 Dec 2009 02:42:48 -0800 (PST)
From:   hermit <hermitcranecn@yahoo.com.cn>
To:     linux-mips@linux-mips.org
Subject: Re: Do_ade
In-Reply-To: <20091223004130.GA31076@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: hermitcranecn@yahoo.com.cn
References: <26871250.post@talk.nabble.com> <20091223004130.GA31076@dvomlehn-lnx2.corp.sa.net>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hermitcranecn@yahoo.com.cn
Precedence: bulk
X-list: linux-mips


David
       Thanks!
       My GCC version is 4.2.3. it seems that it is not too old. I believe
there is bad pointer arithmetic. 
       Here is the do_ade print:
       do_ade, 542 address error exception occurs! MediaPlayerServ(pid:839)
        (a0 == 7edff5b6 a1 == 302daaca a2 == 00000002 a3 == 302daaca)
        (gp == 302e2730 sp == 7edff578 t9 == 2afb4640)
        (epc == 302c3250, ra == 302c3388)
        Suppose we can find which function cause "bad pointer arithmetic". 
        I am new to MIPS, anybody can tell me how i can find the function?
        Thanks!
BGs/Hermit

David VomLehn (dvomlehn) wrote:
> 
> On Mon, Dec 21, 2009 at 02:47:22AM -0600, hermit wrote:
>> 
>> We are trying to run WEBkit on MIPS 24ke system.
>> we found a lot of "do_ade" print. but system doesn't crash. 
>> because of do_ade print, the system performance seems poor.
>> I wonder if there is any compile flag can remove do_ade warning?
>> Thanks!
>> -- 
>> View this message in context:
>> http://old.nabble.com/Do_ade-tp26871250p26871250.html
>> Sent from the linux-mips main mailing list archive at Nabble.com.
>> 
>> 
> 
> If you get messages from do_ade(), it means that your application is
> accessing data that is not aligned on a boundary that is a multiple
> of the size of the data. Accessing such unaligned data causes an exception
> that one would typically expect to kill your process. Fortunately, or
> unfortunately, depending on your view, the code that handles this
> exception
> can be configured to do one of three things:
> 
> o	Send a SIGBUS signal to your process, which generally kills it
> o	Print a message and then emulate the unaligned load or store
> o	Silently emulate the unaligned load or store
> 
> It sounds like your system is configured for the print and emulate option.
> The emulation is quite a bit slower than a simple aligned load or store,
> so I am not surprised you are seeing noticable performance impact. The
> warning
> may be impacting your performance as it is printed sychronously, but even
> if you silence the warning, your performance will suffer.
> 
> There are various ways that you can get unaligned accesses. One is to have
> code that does bad pointer arithmetic. Another possiblity, one that I
> encountered recently, is to have a bad gcc. IIRC gcc 4.1.0 had this
> problem.
> Upgrading the version of gcc caused the problem to go away, but it wasn't
> really clear what bug fix did the job. Anyway, I know that verson 4.3.2
> works as you would expect.
> 
> I strongly recommend, if you have an older gcc, that you upgrade. An
> instruction emulated through exception handling can easily be a hundred
> times
> slower than that instruction operating on aligned data. If, however, you
> really only want to quiet the warning, you must first mount the debugfs
> filesystem: "mount -t debugfs debug /proc/sys/debug". Then write a zero to
> /proc/sys/debug/mips/unaligned_action, i.e.
> echo 0 >/proc/sys/debug/mips/unaligned_action.
> 
> -- 
> David VL
> 
> 
> 

-- 
View this message in context: http://old.nabble.com/Do_ade-tp26871250p26897656.html
Sent from the linux-mips main mailing list archive at Nabble.com.
