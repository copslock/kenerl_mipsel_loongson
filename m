Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2002 15:04:09 +0200 (CEST)
Received: from newgate1.zarlink.com ([209.226.172.66]:55907 "EHLO
	semigate.zarlink.com") by linux-mips.org with ESMTP
	id <S1123396AbSJINEI>; Wed, 9 Oct 2002 15:04:08 +0200
Received: from ottmta01.zarlink.com (ottmta01 [134.199.14.110])
	by semigate.zarlink.com (8.10.2+Sun/8.10.2) with ESMTP id g99D3wx14474;
	Wed, 9 Oct 2002 09:03:58 -0400 (EDT)
Subject: Re: hints on wait queue bug?
To: linux-mips@linux-mips.org, Rob Lembree <lembree@metrolink.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFCA4057FB.AF21BBC1-ON80256C4D.0046ED5D@zarlink.com>
From: Colin.Helliwell@Zarlink.Com
Date: Wed, 9 Oct 2002 14:03:54 +0100
X-MIMETrack: Serialize by Router on ottmta01/Semi(Release 5.0.11  |July 24, 2002) at 10/09/2002
 09:04:00 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Return-Path: <Colin.Helliwell@Zarlink.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Colin.Helliwell@Zarlink.Com
Precedence: bulk
X-list: linux-mips


Does your code use the DECLARE_WAIT_QUEUE_HEAD macro?
If so : I had a similar-sounding problem (on a PowerPC platform) where if
this macro was used to declare+initialise the queue, the initialisation did
not occur correctly. Performing the initialisation separately at runtime
with "init_waitqueue_head(&wqh)" corrects the problem. Our working
assumption is that it was perhaps a PPC gcc bug (I have seen mention of it
on a PPC msg board), but it could be more widespread. I have a piece of
test code which showed the problem, if you want to try it.




                                                                                                                                           
                      Ralf Baechle                                                                                                         
                      <ralf@uni-koblenz.de>        To:       Rob Lembree <lembree@metrolink.com>                                           
                      Sent by:                     cc:       linux-mips@linux-mips.org                                                     
                      linux-mips-bounce@lin        Subject:  Re: hints on wait queue bug?                                                  
                      ux-mips.org                                                                                                          
                                                                                                                                           
                                                                                                                                           
                      09-Oct-2002 01:19 PM                                                                                                 
                                                                                                                                           
                                                                                                                                           




On Thu, Aug 29, 2002 at 04:29:16PM -0400, Rob Lembree wrote:

> I've got a problem where lots of io to the console seems
> to break something in the kernel, resulting in a segfault,
> along with a kernel error.
>
> I dove into it, and found that it's related to wait queue
> stuff.  I turned on the wait queue debugging, and got the
> following, just prior to things going off the deep end.
>
> bad magic 802ccb24 (should be 802ccb2c), kernel BUG at sched.c:729!
>
> Is there some tutorial on this stuff somewhere (besides
> reading the code -- I'm doing that now!)
>
> Has this stuff changed a great deal since 2.4.5 (when this
> code last worked correctly)?

No.  Typicall such bugs are caused by memory corruption but as in your
case the magic number which is an address is only off by eight bytes
you might also consider a tool bug, so I suggest disassembling the
kernel binary and checking if it's getting initialized correctly.

  Ralf
