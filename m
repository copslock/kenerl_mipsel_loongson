Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 17:46:31 +0200 (CEST)
Received: from relay1.mentorg.com ([192.94.38.131]:38088 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6862607AbaFQPoqLZxKn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 17:44:46 +0200
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
        by relay1.mentorg.com with esmtp 
        id 1WwvYt-0006fb-25 from joseph_myers@mentor.com ; Tue, 17 Jun 2014 08:44:39 -0700
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by SVR-ORW-EXC-10.mgc.mentorg.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 17 Jun 2014 08:44:38 -0700
Received: from digraph.polyomino.org.uk (137.202.0.76) by
 SVR-IES-FEM-01.mgc.mentorg.com (137.202.0.104) with Microsoft SMTP Server id
 14.2.247.3; Tue, 17 Jun 2014 16:44:37 +0100
Received: from jsm28 (helo=localhost)   by digraph.polyomino.org.uk with
 local-esmtp (Exim 4.76)        (envelope-from <joseph@codesourcery.com>)       id
 1WwvYq-00054n-1W; Tue, 17 Jun 2014 15:44:36 +0000
Date:   Tue, 17 Jun 2014 15:44:36 +0000
From:   "Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     <linux-mips@linux-mips.org>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>
Subject: Re: MIPS MSA sigcontext changes in 3.15
In-Reply-To: <Pine.LNX.4.64.1406171447030.23412@digraph.polyomino.org.uk>
Message-ID: <Pine.LNX.4.64.1406171539240.23412@digraph.polyomino.org.uk>
References: <Pine.LNX.4.64.1406171447030.23412@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 17 Jun 2014 15:44:38.0713 (UTC) FILETIME=[0C144290:01CF8A43]
Return-Path: <joseph_myers@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
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

On Tue, 17 Jun 2014, Joseph S. Myers wrote:

> signal mask at a particular offset in the ucontext.  As far as I can see, 
> extending sigcontext requires a new sigaction flag that could be used to 
> opt in, for a particular signal handler, to receiving the new-layout 
> ucontext (so new symbol versions of sigaction in glibc could then pass 
> that flag to the kernel, but existing binaries would continue to get 
> old-layout ucontext from the kernel), or else putting the new data at the 

And a new flag would itself be problematic - signal handlers would need 
wrapping with userspace code to convert structure layout when new-version 
sigaction is used on an older kernel.  That suggests putting the new data 
at the end of ucontext is to be preferred (but in any case it would be 
best to revert the incompatible changes until something compatible with 
existing userspace can be produced).

-- 
Joseph S. Myers
joseph@codesourcery.com
