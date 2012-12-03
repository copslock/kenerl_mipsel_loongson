Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2012 18:51:09 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:25411 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831625Ab2LCRvHy9Hz3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Dec 2012 18:51:07 +0100
X-Authority-Analysis: v=2.0 cv=Mv7QGhme c=1 sm=0 a=rXTBtCOcEpjy1lPqhTCpEQ==:17 a=mNMOxpOpBa8A:10 a=XlK8ECWECGUA:10 a=5SG0PmZfjMsA:10 a=Q9fys5e9bTEA:10 a=meVymXHHAAAA:8 a=aYz5cAgaFdEA:10 a=s-gwoRVtHMEgTxDo564A:9 a=PUjeQqilurYA:10 a=rXTBtCOcEpjy1lPqhTCpEQ==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 74.67.115.198
Received: from [74.67.115.198] ([74.67.115.198:51994] helo=[192.168.23.10])
        by hrndva-oedge02.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 3F/3F-01392-586ECB05; Mon, 03 Dec 2012 17:51:02 +0000
Message-ID: <1354557056.6276.203.camel@gandalf.local.home>
Subject: Re: MIPS Function Tracer question
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Alan Cooper <alcooperx@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Dec 2012 12:50:56 -0500
In-Reply-To: <20121203161346.GA29573@linux-mips.org>
References: <CAOGqxeUOrVFoqsmUV19h5tXsD6pw5creXP9aN1C-V7K3WL2EXA@mail.gmail.com>
         <50B7E91C.6070403@gmail.com> <1354545648.6276.202.camel@gandalf.local.home>
         <20121203161346.GA29573@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.4.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-archive-position: 35173
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

On Mon, 2012-12-03 at 17:13 +0100, Ralf Baechle wrote:
> On Mon, Dec 03, 2012 at 09:40:48AM -0500, Steven Rostedt wrote:
> 
> > The issue is with x86. Gcc wont compile if you have -pg and
> > -fomit-frame-pointer on x86. I originally forced function tracing to
> > select FRAME_POINTER, but because now on x86 with -mfentry, -pg no
> > longer requires frame pointers being set, I just let -pg complain one
> > way or the other. I believe that gcc by default will not add frame
> > pointers. Thus adding function tracing just prevents
> > -fomit-frame-pointer from being set, and if -pg requires frame pointers
> > it will automatically enable them otherwise they should not be enabled.
> 
> On architectures such as MIPS where a frame pointer is not required for
> debugging -O and higher imply -fomit-frame-pointer.

Then this shouldn't be an issue for MIPS.

-- Steve
