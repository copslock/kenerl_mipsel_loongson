Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2013 23:36:36 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:53849 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824820Ab3KEWgecvBCQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Nov 2013 23:36:34 +0100
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
        by relay1.mentorg.com with esmtp 
        id 1VdpEZ-0004pZ-0v from joseph_myers@mentor.com ; Tue, 05 Nov 2013 14:36:27 -0800
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by SVR-ORW-EXC-10.mgc.mentorg.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 5 Nov 2013 14:36:27 -0800
Received: from digraph.polyomino.org.uk (137.202.0.76) by
 SVR-IES-FEM-01.mgc.mentorg.com (137.202.0.104) with Microsoft SMTP Server id
 14.2.247.3; Tue, 5 Nov 2013 22:36:25 +0000
Received: from jsm28 (helo=localhost)   by digraph.polyomino.org.uk with
 local-esmtp (Exim 4.76)        (envelope-from <joseph@codesourcery.com>)       id
 1VdpEW-00009s-0s; Tue, 05 Nov 2013 22:36:24 +0000
Date:   Tue, 5 Nov 2013 22:36:24 +0000
From:   "Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Rich Felker <dalias@aerifal.cx>,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Andreas Barth <aba@ayous.org>,
        David Miller <davem@davemloft.net>, <aurelien@aurel32.net>,
        <linux-mips@linux-mips.org>, <libc-alpha@sourceware.org>
Subject: Re: prlimit64: inconsistencies between kernel and userland
In-Reply-To: <52793C50.9030300@gmail.com>
Message-ID: <Pine.LNX.4.64.1311052234420.30260@digraph.polyomino.org.uk>
References: <20130628133835.GA21839@hall.aurel32.net> <20131104213756.GD18700@hall.aurel32.net>
 <20131104.194519.1657797548878784116.davem@davemloft.net>
 <Pine.LNX.4.64.1311050058580.9883@digraph.polyomino.org.uk>
 <20131105012203.GA24286@brightrain.aerifal.cx> <20131105085859.GE28240@mails.so.argh.org>
 <20131105183732.GB24286@brightrain.aerifal.cx> <52793C50.9030300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 05 Nov 2013 22:36:27.0228 (UTC) FILETIME=[76F871C0:01CEDA77]
Return-Path: <joseph_myers@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38457
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

On Tue, 5 Nov 2013, David Daney wrote:

> Why can't the default version of the functions in question be fixed so that
> they do the right thing?  That way you wouldn't have to rebuild old binaries.
> 
> Do we really need new function versions at all?

If we change RLIM64_INFINITY to match the kernel, then the right thing for 
at least getrlimit64 depends on whether it's an old or new binary (for old 
binaries it should return the old value of RLIM64_INFINITY and for new 
ones it should return the new value).

-- 
Joseph S. Myers
joseph@codesourcery.com
