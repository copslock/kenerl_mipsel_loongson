Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2012 15:40:55 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:28342 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826638Ab2LCOkxW4ywh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Dec 2012 15:40:53 +0100
X-Authority-Analysis: v=2.0 cv=f9bK9ZOM c=1 sm=0 a=rXTBtCOcEpjy1lPqhTCpEQ==:17 a=mNMOxpOpBa8A:10 a=XlK8ECWECGUA:10 a=5SG0PmZfjMsA:10 a=Q9fys5e9bTEA:10 a=meVymXHHAAAA:8 a=aYz5cAgaFdEA:10 a=1g4hhj49uufQi-hBbH4A:9 a=PUjeQqilurYA:10 a=rXTBtCOcEpjy1lPqhTCpEQ==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 74.67.115.198
Received: from [74.67.115.198] ([74.67.115.198:52910] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 3E/1F-18789-0F9BCB05; Mon, 03 Dec 2012 14:40:48 +0000
Message-ID: <1354545648.6276.202.camel@gandalf.local.home>
Subject: Re: MIPS Function Tracer question
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Alan Cooper <alcooperx@gmail.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Dec 2012 09:40:48 -0500
In-Reply-To: <50B7E91C.6070403@gmail.com>
References: <CAOGqxeUOrVFoqsmUV19h5tXsD6pw5creXP9aN1C-V7K3WL2EXA@mail.gmail.com>
         <50B7E91C.6070403@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.4.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-archive-position: 35171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 2012-11-29 at 15:00 -0800, David Daney wrote:
> On 11/29/2012 01:04 PM, Alan Cooper wrote:
> > I've been doing some testing of the MIPS Function Tracer functionality
> > on the 3.3 kernel. I was surprised to find that the option to generate
> > frame pointers was required for tracing.
> 
> It is not really required for MIPS function tracing, but the Kconfigs 
> for some reason set it.
> 

The issue is with x86. Gcc wont compile if you have -pg and
-fomit-frame-pointer on x86. I originally forced function tracing to
select FRAME_POINTER, but because now on x86 with -mfentry, -pg no
longer requires frame pointers being set, I just let -pg complain one
way or the other. I believe that gcc by default will not add frame
pointers. Thus adding function tracing just prevents
-fomit-frame-pointer from being set, and if -pg requires frame pointers
it will automatically enable them otherwise they should not be enabled.

-- Steve

> >  When I don't enable
> > FRAME_POINTER along with FUNCTION_TRACER, the kernel hangs on boot. I
> > also noticed that a checkin to the 3.4 kernel
> > (b732d439cb43336cd6d7e804ecb2c81193ef63b0) no longer forces on
> > FRAME_POINTER when FUNCTION_TRACER is selected. I was wondering how it
> > works in 3.4 and beyond, so I built a Malta kernel from the latest
> > MIPS tree with FUNCTION_TRACING enabled and tested it with QEMU. The
> > kernel hung the same way. I can think of 2 reasons for this:
> > 1. Function tracing is broken for MIPS in 3.4 and beyond.
> > 2. The 4.5.3 GNU C compiler I'm using is generating different code for
> > function tracing.
> 
