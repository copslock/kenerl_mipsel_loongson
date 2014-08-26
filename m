Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 11:27:38 +0200 (CEST)
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:54915
        "EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006674AbaHZJ1hN3W2o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 11:27:37 +0200
Received: from omta14.westchester.pa.mail.comcast.net ([76.96.62.60])
        by QMTA11.westchester.pa.mail.comcast.net with comcast
        id jMT51o0011HzFnQ5BMTWAt; Tue, 26 Aug 2014 09:27:30 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta14.westchester.pa.mail.comcast.net with comcast
        id jMTW1o00Q0JZ7Re3aMTWB9; Tue, 26 Aug 2014 09:27:30 +0000
Message-ID: <53FC5300.4070902@gentoo.org>
Date:   Tue, 26 Aug 2014 05:27:28 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: 16k or 64k PAGE_SIZE and "illegal instruction" (signal -4) errors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1409045250;
        bh=MK2tEuXymikf2y3qaP9b4tfKYIStrfmdq9Uxa4KouEw=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=tsR06Uvx3oLTEW3BNM5S7Uzit6Gs4RyPxOLoDv5EXLW4QpfHksm0vyqNs7Kh4KKux
         TiIbeKQdUsMYKMa6zwBYuXrmJ7hwTrm6rNHh8YIuDF7mYvepJNlYXC0ehMrPi96Bco
         7OURGs2aytyyJpBXWrOpC2VS9it83fVaG0Xshpyaar3Y811tOW0a373Gm0i+M56reW
         1LbVgi0Rja8qqS2BgkhzCjRuQjbxSVvdO7+IKVKPlDMohh32sxMiDcoDrbXqptWLx7
         Cz7zEs6BrqRg+hGHQg+GTgzXpYfecPf6oyX/lL8asHpoRBpUltyiUgOj6VKBWXJG9U
         GjhbEIouszBAQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

Okay, so from the "make kmap cache coloring aware" thread, I've been playing
with larger PAGE_SIZE values on the Octane and O2 for the last few hours.
16k and 64k used to, in the past, never get far after init (usually died
*at* init)  That appears to have changed now.  Most programs seem to
JustWork(), but very randomly, I am getting a signal -4, illegal instruction
(SIGILL) on the Octane.  Both systems are running kernels w/ 64k PAGE_SIZE
at the moment.

I cannot reproduce it on demand, so I'm not really sure what the cause could
be.  PAGE_SIZE should be largely transparent to userland these days, so I am
wondering if this might be more oddities w/ an R14000 CPU.

Ideas?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
