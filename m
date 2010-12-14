Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2010 00:01:14 +0100 (CET)
Received: from gateway16.websitewelcome.com ([69.56.206.4]:35399 "HELO
        gateway16.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491036Ab0LNXBL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Dec 2010 00:01:11 +0100
Received: (qmail 20429 invoked from network); 14 Dec 2010 23:00:44 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway16.websitewelcome.com with SMTP; 14 Dec 2010 23:00:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=CKz2TKWJsn1Lhk8TTqS5SVOuhhGHojcRPKMdNLYh5AsT4HZJgAIGoAodUJcbsv+Alv71FQydP6cptxTRo0U3sVuWBxI9B6nASn68p/rcxqa1HRX857Tes4dacWOOZ1Us;
Received: from [216.239.45.4] (port=4545 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PSdrf-0000cJ-Ae; Tue, 14 Dec 2010 17:00:59 -0600
Message-ID: <4D07F72E.30608@paralogos.com>
Date:   Tue, 14 Dec 2010 15:01:02 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     STUART VENTERS <stuart.venters@adtran.com>
CC:     linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head
References: <8F242B230AD6474C8E7815DE0B4982D7179FB87A@EXV1.corp.adtran.com>
In-Reply-To: <8F242B230AD6474C8E7815DE0B4982D7179FB87A@EXV1.corp.adtran.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 12/14/10 13:27, STUART VENTERS wrote:
> Kevin,
>
> It turns out we are also looking at Linux SMTC support for 34kc.
>     (For a different pmc part.)
>
> You said you remembered seeing it work on at least one version of the kernel.
>
> Could you help us find that version by bracketing the search a bit?
>
> Maybe a date and/or version range to look in.
>

There were early working versions without dyntick or interrupt affinity
in the 2.6.23/24 timeframe, but as per the commit lots in linux-mips.org,
I finally got the dyntick stuff working in September 2008, with the commits
propagating to various git branches over the following two months.  I 
can see
that the new code was in 2.6.28.1 but not in 2.6.26.8 At some point 
subsequent
to that, I'm pretty sure I checked out the then-latest stable version of 
the Malta
branch and got a functional build.

The last time I regression checked it was in March  of 2009 at which point
some infrastructure changes had broken things, which I fixed in patches
posted on March 31, 2009, one which addressed a change in the semantics
of CP0 access macros, and one of which fixed  a name conflict.
Those were committed on 3/31 and 5/14/2009, depending on the branch
you look at.  With those patches and only those patches on what was then
the latest stable (Malta?) branch at LMO, it seemed to run OK
to the limited degree I was able to have it tested.   Someone else found a
hole in smtc_distribute_timer() in November of 2009, and I worked with
the discoverer on a very small patch committed November 13, 2009,
but I never actually ran the code to test (then again, I'd never been able
to drive a system into the failure it could cause).

Sorry to be a little vague, but I no longer have my MIPS Linux development
build or test systems, so I'm reduced to googling and searching LMO, just
like anyone else.

             Regards,

             Kevin K.
