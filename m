Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2012 17:13:53 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52260 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6831627Ab2LCQNvjmNDj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Dec 2012 17:13:51 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qB3GDmaF029676;
        Mon, 3 Dec 2012 17:13:48 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qB3GDkin029675;
        Mon, 3 Dec 2012 17:13:46 +0100
Date:   Mon, 3 Dec 2012 17:13:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Alan Cooper <alcooperx@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: MIPS Function Tracer question
Message-ID: <20121203161346.GA29573@linux-mips.org>
References: <CAOGqxeUOrVFoqsmUV19h5tXsD6pw5creXP9aN1C-V7K3WL2EXA@mail.gmail.com>
 <50B7E91C.6070403@gmail.com>
 <1354545648.6276.202.camel@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1354545648.6276.202.camel@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Dec 03, 2012 at 09:40:48AM -0500, Steven Rostedt wrote:

> The issue is with x86. Gcc wont compile if you have -pg and
> -fomit-frame-pointer on x86. I originally forced function tracing to
> select FRAME_POINTER, but because now on x86 with -mfentry, -pg no
> longer requires frame pointers being set, I just let -pg complain one
> way or the other. I believe that gcc by default will not add frame
> pointers. Thus adding function tracing just prevents
> -fomit-frame-pointer from being set, and if -pg requires frame pointers
> it will automatically enable them otherwise they should not be enabled.

On architectures such as MIPS where a frame pointer is not required for
debugging -O and higher imply -fomit-frame-pointer.

  Ralf
