Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2014 00:20:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38741 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6875434AbaHGWUkUSVht (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Aug 2014 00:20:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s77MKcXA013787;
        Fri, 8 Aug 2014 00:20:38 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s77MKc5e013786;
        Fri, 8 Aug 2014 00:20:38 +0200
Date:   Fri, 8 Aug 2014 00:20:38 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] MIPS: GIC: Fix GICBIS macro
Message-ID: <20140807222038.GF29898@linux-mips.org>
References: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com>
 <1405585259-24941-8-git-send-email-markos.chandras@imgtec.com>
 <53C7C5E2.1020307@cogentembedded.com>
 <53C8D2AE.3020300@imgtec.com>
 <53C961E9.9000803@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53C961E9.9000803@cogentembedded.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41901
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

On Fri, Jul 18, 2014 at 10:05:29PM +0400, Sergei Shtylyov wrote:

> >>>+#define GICBIS(reg, mask, bits)            \
> >>>+    do { u32 data;                \
> >>>+        GICREAD((reg), data);        \
> 
> >>    Why () only around 'reg', not around 'data'?
> 
> >Brackets aren't necessary around "data" because it is declared at the start of
> >the "do" code block, so it can't expand to anything else within that scope.
> 
>    Oh, I was not attentive enough, sorry about that... :-<
>    However, it makes sense to at least put that declaration at a separate line.

And it's not safe against multiple evaluation of macro arguments.  Imagine
what's going to happen if GICBIS is called as something like

	GICBIS(++a, ++b, c);

That'll expand to:

    do { u32 data;
            GICREAD((++a), data);
            data &= ~(++b);
            data |= ((bits) & (++b));
            GICWRITE((++a), data);
    } while (0)

Paranoia?

  Ralf
