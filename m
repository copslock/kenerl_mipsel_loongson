Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2010 16:39:11 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:48741 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491030Ab0J0OjD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Oct 2010 16:39:03 +0200
X-Authority-Analysis: v=1.1 cv=+c36koQ5Dcj/1qolKHjtkYAGXvrVJRRiKMp+84F5sLg= c=1 sm=0 a=ZDzuQiiN56AA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8 a=SyI_GHdlAAAA:8 a=WPyIoOwQAAAA:8 a=tsvOLuEiFaFAFILXScQA:9 a=VTmaPT9_Z_SN8OkkgzWWlG6jX1sA:4 a=PUjeQqilurYA:10 a=jeBq3FmKZ4MA:10 a=MSl-tDqOz04A:10 a=UQxMgyrMzRwA:10 a=1DbiqZag68YA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:49716] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 9D/F3-24070-C6938CC4; Wed, 27 Oct 2010 14:38:36 +0000
Subject: Re: [PATCH 1/3] ftrace/MIPS: Add MIPS64 support for C version of
 recordmcount
From:   Steven Rostedt <rostedt@goodmis.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, John Reiser <jreiser@bitwagon.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <AANLkTinsfveuYdo4YJGHqasPgG=+ftL-8sbC5_aYAytt@mail.gmail.com>
References: <cover.1288176026.git.wuzhangjin@gmail.com>
         <910dc2d5ae1ed042df4f96815fe4a433078d1c2a.1288176026.git.wuzhangjin@gmail.com>
         <1288186366.18238.125.camel@gandalf.stny.rr.com>
         <AANLkTinsfveuYdo4YJGHqasPgG=+ftL-8sbC5_aYAytt@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 27 Oct 2010 10:38:35 -0400
Message-ID: <1288190315.18238.128.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Wed, 2010-10-27 at 22:09 +0800, wu zhangjin wrote:
> On Wed, Oct 27, 2010 at 9:32 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 2010-10-27 at 18:59 +0800, Wu Zhangjin wrote:
> >> From: Wu Zhangjin <wuzhangjin@gmail.com>
> >
> > The From above states that you wrote this. Did you modify what John and
> > Maciej did? If so, please state clearly what each author has done, and
> > how you modified it. If you did not write this, please change the From
> > to the correct author.
> >
> > If you did modify it, then state something like this in the change log.
> >
> > Original version written by John Reiser <jreiser@BitWagon.com>
> >
> > Usage of "union mips_r_info" and the functions MIPS64_r_sym() and
> > MIPS64_r_info() written by Maciej W. Rozycki <macro@linux-mips.org>
> >
> 
> yeah, that is true above.
> 
> > Then state the changes you made.
> 
> I didn't change it, just added the comments in the patch log and tested it.
> 
> Should I resend the patch with the change log information about John and Maciej?
> 

I can make the changes.

Then the patch is originally John's, right?

I'll make him the author, with the comment about Maciej, and keep you as
the Tested-by.

-- Steve
