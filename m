Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2013 01:23:16 +0100 (CET)
Received: from smtp2.Stanford.EDU ([171.67.219.82]:48145 "EHLO
        smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6826046Ab3KFAXOw70Uh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Nov 2013 01:23:14 +0100
Received: from smtp.stanford.edu (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 2B901340ADD;
        Tue,  5 Nov 2013 16:23:08 -0800 (PST)
Received: from windlord.stanford.edu (windlord.Stanford.EDU [171.67.225.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id 8895C340C9C;
        Tue,  5 Nov 2013 16:23:02 -0800 (PST)
Received: by windlord.stanford.edu (Postfix, from userid 1000)
        id 09B852F490; Tue,  5 Nov 2013 16:23:01 -0800 (PST)
From:   Russ Allbery <eagle@eyrie.org>
To:     Rich Felker <dalias@aerifal.cx>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        "Joseph S. Myers" <joseph@codesourcery.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "Pinski\, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Andreas Barth <aba@ayous.org>,
        David Miller <davem@davemloft.net>, aurelien@aurel32.net,
        linux-mips@linux-mips.org, libc-alpha@sourceware.org
Subject: Re: prlimit64: inconsistencies between kernel and userland
In-Reply-To: <20131105235505.GK24286@brightrain.aerifal.cx> (Rich Felker's
        message of "Tue, 5 Nov 2013 18:55:05 -0500")
Organization: The Eyrie
References: <20131104213756.GD18700@hall.aurel32.net>
        <20131104.194519.1657797548878784116.davem@davemloft.net>
        <Pine.LNX.4.64.1311050058580.9883@digraph.polyomino.org.uk>
        <20131105012203.GA24286@brightrain.aerifal.cx>
        <20131105085859.GE28240@mails.so.argh.org>
        <20131105183732.GB24286@brightrain.aerifal.cx>
        <52793C50.9030300@gmail.com>
        <Pine.LNX.4.64.1311052234420.30260@digraph.polyomino.org.uk>
        <20131105223953.GG24286@brightrain.aerifal.cx>
        <87ppqez9sh.fsf@igel.home>
        <20131105235505.GK24286@brightrain.aerifal.cx>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Tue, 05 Nov 2013 16:23:01 -0800
Message-ID: <87bo1ycra2.fsf@windlord.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <eagle@eyrie.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eagle@eyrie.org
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

Rich Felker <dalias@aerifal.cx> writes:

> That doesn't help. The problem is that the non-devel package gets
> upgraded and ldconfig re-links the .so to the .so.X.Y.Z for the new
> version.

Require the upgrades happen in lockstep.

Package: libc6-dev
Version: 2.17-93
Depends: libc6 (= 2.17-93), libc-dev-bin (= 2.17-93), linux-libc-dev

-- 
Russ Allbery (eagle@eyrie.org)              <http://www.eyrie.org/~eagle/>
