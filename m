Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2011 19:32:29 +0200 (CEST)
Received: from lo.gmane.org ([80.91.229.12]:55239 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493420Ab1HVRcZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Aug 2011 19:32:25 +0200
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1QvYMK-000144-8u
        for linux-mips@linux-mips.org; Mon, 22 Aug 2011 19:32:24 +0200
Received: from 91-64-80-26-dynip.superkabel.de ([91.64.80.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Mon, 22 Aug 2011 19:32:24 +0200
Received: from zecke by 91-64-80-26-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Mon, 22 Aug 2011 19:32:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Holger Freyther <zecke@selfish.org>
Subject: Re: [PATCH 0/2] Implement =?utf-8?b?cGVyZl9jYWxsY2hhaW5fdXNlcg==?=
Date:   Mon, 22 Aug 2011 17:32:12 +0000 (UTC)
Message-ID: <loom.20110822T193146-370@post.gmane.org>
References: <1313022966-28152-1-git-send-email-zecke@selfish.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.64.80.26 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Ubuntu/11.04 Chromium/12.0.742.112 Chrome/12.0.742.112 Safari/534.30)
X-archive-position: 30946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zecke@selfish.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16087

Holger Hans Peter Freyther <zecke <at> selfish.org> writes:

> 
> Hi,
> this is moving code from oprofile/backtrace.c to a commom
> place and then implements perf_callchain_user using the common
> code. Right now the unwind_user_frame will always be compiled
> into the kernel.

Comments? Should this go somewhere else?
