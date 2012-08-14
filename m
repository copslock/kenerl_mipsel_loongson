Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 13:15:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33964 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903424Ab2HNLPr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 13:15:47 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7EBFk1o013902;
        Tue, 14 Aug 2012 13:15:46 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7EBFj5K013900;
        Tue, 14 Aug 2012 13:15:45 +0200
Date:   Tue, 14 Aug 2012 13:15:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Akhilesh Kumar <akhilesh.lxr@gmail.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [Bug-fix] backtrace when HAVE_FUNCTION_TRACER is enable
Message-ID: <20120814111545.GA13470@linux-mips.org>
References: <CADArhcB+N+D4fyVN20f0hu=vfPj1tsn5NHi0cjG4JJcKAhTkeQ@mail.gmail.com>
 <CAD+V5YKZJHKONehvT+-GrKLP2+e0PiLiFTJWEojiDoNyLT3yGQ@mail.gmail.com>
 <CADArhcAN4renH1hFnhc14d+VMn2N+k0GsDpXevRFKd6UD=X=8Q@mail.gmail.com>
 <CADArhcDuWksB2_ktGrhwRcb1yCuAiKMfnt8gd7+PHXFTTCzX-Q@mail.gmail.com>
 <20120813164717.GC5786@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120813164717.GC5786@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34142
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

On Mon, Aug 13, 2012 at 06:47:17PM +0200, Ralf Baechle wrote:

> 
> > Detail Description is added in the patch
> 
> This patch is garbled and doesn't apply.  You can find some hints on
> how to deal with patch-corrupting mail clients in:
> 
>   http://www.linux-mips.org/wiki/Mailing-patches

Also it appears to be incomplete.  I see your patch plenty of macro
definitions and function declarations but nothing appears to use them.

  Ralf
