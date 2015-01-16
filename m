Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 15:37:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45003 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010551AbbAPOh3s0qK4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jan 2015 15:37:29 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id t0GEbR8I031376;
        Fri, 16 Jan 2015 15:37:27 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id t0GEbPSB031375;
        Fri, 16 Jan 2015 15:37:25 +0100
Date:   Fri, 16 Jan 2015 15:37:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Daniel Sanders <Daniel.Sanders@imgtec.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
Message-ID: <20150116143725.GB22296@linux-mips.org>
References: <1420805177-9087-1-git-send-email-daniel.sanders@imgtec.com>
 <54AFC6F3.1020300@cogentembedded.com>
 <E484D272A3A61B4880CDF2E712E9279F458E68B8@hhmail02.hh.imgtec.org>
 <54B00F3C.8030903@gmail.com>
 <E484D272A3A61B4880CDF2E712E9279F458E7DF1@hhmail02.hh.imgtec.org>
 <54B069D4.4090608@gmail.com>
 <E484D272A3A61B4880CDF2E712E9279F458E8336@hhmail02.hh.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E484D272A3A61B4880CDF2E712E9279F458E8336@hhmail02.hh.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45226
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

On Sat, Jan 10, 2015 at 12:53:22PM +0000, Daniel Sanders wrote:

> The main reason I renamed it is that identifiers starting with '__' are reserved. It's pretty unlikely but it's possible that the name will conflict with a C implementation in the future.

The whole kernel is using identifiers starting with a double underscore
left and right.  The risk should be acceptable though - also because the
kernel isn't linked against external libraries.

The sole reason why _current_thread_info was a local variable is so nobody
else can use it - the proper interface to use is current_thread_info().

Other than that, both the current and the proposed variant aren't really
correct for a variable that really is per thread.  So I'm going to just
queue this for 3.20.

Thanks!

  Ralf
