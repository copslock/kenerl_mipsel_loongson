Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2015 20:23:27 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:44402 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011811AbbD0SX0fsPLb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2015 20:23:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=UlB2N3+8Q4ZylbTUGrOCBjWeUgRW/1MvV2AF8eauixQ=;
        b=xl7SKU18XVgkHjWiNadvAQeSU7AETX6sIvGzW7iM1+6AbX0T5jUVs5dXoQWtIvhLqwRVevJI1IfdHMcox58eZngxF+6B1KeiMfC1S9qAx/ZOCB1Pxo7iG4Y/g3GAG8C3/nyYZ6IYP1cvvkNKLyTciL5uvz4QlocBOyWgZyuJCfE=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1Ymngf-001IR2-Pc
        for linux-mips@linux-mips.org; Mon, 27 Apr 2015 18:23:21 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:39152 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1YmngW-001ILj-Id; Mon, 27 Apr 2015 18:23:12 +0000
Date:   Mon, 27 Apr 2015 11:23:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        MarkBrown@roeck-us.net
Subject: Re: Build regressions/improvements in v4.1-rc1
Message-ID: <20150427182311.GA10136@roeck-us.net>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020201.553E7E9A.00D9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 5
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Mon, Apr 27, 2015 at 12:03:32PM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 27, 2015 at 11:51 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.1-rc1[1] compared to v4.0[2].
> >
> > Summarized:
> >   - build errors: +34/-11
> >   - build warnings: +135/-163
> >
> > As I haven't mastered kup yet, there's no verbose summary at
> > http://www.kernel.org/pub/linux/kernel/people/geert/linux-log/v4.1-rc1.summary.gz
> >
> > Happy fixing! ;-)
> >
> > Thanks to the linux-next team for providing the build service.
> >
> > [1] http://kisskb.ellerman.id.au/kisskb/head/8779/ (254 out of 257 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/head/8710/ (254 out of 257 configs)
> >
> >
> > *** ERRORS ***
> >
> > 34 regressions:
> 
> The quiet days are over...
> 
Is it just my impression, or is the code quality in this commit window
a bit lower than usual (very politely said) ?

Guenter
