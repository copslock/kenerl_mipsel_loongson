Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 17:37:56 +0200 (CEST)
Received: from relay1.mentorg.com ([192.94.38.131]:33699 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6862060AbaFQPD1Rnoqw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 17:03:27 +0200
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
        by relay1.mentorg.com with esmtp 
        id 1Wwuus-0001th-VF from joseph_myers@mentor.com ; Tue, 17 Jun 2014 08:03:19 -0700
Received: from SVR-IES-FEM-02.mgc.mentorg.com ([137.202.0.106]) by svr-orw-fem-01.mgc.mentorg.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 17 Jun 2014 08:03:18 -0700
Received: from digraph.polyomino.org.uk (137.202.0.76) by
 SVR-IES-FEM-02.mgc.mentorg.com (137.202.0.106) with Microsoft SMTP Server id
 14.2.247.3; Tue, 17 Jun 2014 16:03:16 +0100
Received: from jsm28 (helo=localhost)   by digraph.polyomino.org.uk with
 local-esmtp (Exim 4.76)        (envelope-from <joseph@codesourcery.com>)       id
 1Wwuup-0006WV-7T; Tue, 17 Jun 2014 15:03:15 +0000
Date:   Tue, 17 Jun 2014 15:03:15 +0000
From:   "Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     <linux-mips@linux-mips.org>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>
Subject: MIPS MSA sigcontext changes in 3.15
Message-ID: <Pine.LNX.4.64.1406171447030.23412@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 17 Jun 2014 15:03:18.0807 (UTC) FILETIME=[45F0A270:01CF8A3D]
Return-Path: <joseph_myers@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40596
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

Reviewing changes in Linux 3.15 for anything for which glibc changes would 
be appropriate, I don't see how the MSA sigcontext changes are supposed to 
work with existing binaries.

The sigcontext structure isn't used on its own - it's part of ucontext, 
which is passed to signal handlers, and it's not at the end of ucontext, 
but followed by the signal mask.  So existing binaries will expect the 
signal mask at a particular offset in the ucontext.  As far as I can see, 
extending sigcontext requires a new sigaction flag that could be used to 
opt in, for a particular signal handler, to receiving the new-layout 
ucontext (so new symbol versions of sigaction in glibc could then pass 
that flag to the kernel, but existing binaries would continue to get 
old-layout ucontext from the kernel), or else putting the new data at the 
end of ucontext rather than in the main sigcontext structure (though I 
don't know if that would have other issues).

-- 
Joseph S. Myers
joseph@codesourcery.com
