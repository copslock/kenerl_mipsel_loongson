Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 13:05:03 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60085 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6867611AbaCRME7cHiHt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Mar 2014 13:04:59 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2IC4txq017289;
        Tue, 18 Mar 2014 13:04:55 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2IC4qbr017288;
        Tue, 18 Mar 2014 13:04:52 +0100
Date:   Tue, 18 Mar 2014 13:04:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Viller Hsiao <villerhsiao@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Qais Yousef <Qais.Yousef@imgtec.com>
Subject: Re: [PATCH v2 1/2] MIPS: ftrace: Tweak safe_load()/safe_store()
 macros
Message-ID: <20140318120452.GA17197@linux-mips.org>
References: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
 <1393055209-28251-2-git-send-email-villerhsiao@gmail.com>
 <20140317145641.GN19285@linux-mips.org>
 <CAA1JSY+0_4Vb9y0T+oWdZRKPEpy08soa05kNT=7Hw9+qfPG5DQ@mail.gmail.com>
 <CAA1JSY+pzsUp+Pfhvm2-rMJ0KfeZr8YaDvuefO3KqRr-Xbmj6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA1JSY+pzsUp+Pfhvm2-rMJ0KfeZr8YaDvuefO3KqRr-Xbmj6A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39491
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

On Tue, Mar 18, 2014 at 03:53:00PM +0800, Viller Hsiao wrote:

> The operand name and variable name are a little ambiguous in PATCH v2.
> Therefore I tweaked and submitted PATCH v3. Please help to use them if
> possible.

Too late, the older versions of your patch were pulled by Linus
yesterday.  If you have further improvments beyond those version in
Linus' tree now, please submit a new patch.

Thanks!

  Ralf
