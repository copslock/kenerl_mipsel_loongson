Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 23:51:02 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:41231 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491844Ab0FBVu6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 23:50:58 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
        id CA1E986655; Wed,  2 Jun 2010 22:50:56 +0100 (BST)
Date:   Wed, 2 Jun 2010 22:50:56 +0100
From:   Alexander Clouter <alex@digriz.org.uk>
To:     wuzhangjin@gmail.com
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>, sam@ravnborg.org
Subject: Re: [PATCH v4] MIPS: Clean up the calculation of
        VMLINUZ_LOAD_ADDRESS
Message-ID: <20100602215056.GX2519@chipmunk>
References: <9890d1383c75ce6df44d357687a9c4e2d6ba4050.1275438553.git.wuzhangjin@gmail.com> <96f3b48ba7f749c4357760008cdae644aa55b92d.1275438520.git.wuzhangjin@gmail.com> <20100602194817.GA7530@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100602194817.GA7530@merkur.ravnborg.org>
Organization: diGriz
X-URL:  http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 27034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1808

* Sam Ravnborg <sam@ravnborg.org> [2010-06-02 21:48:17+0200]:
>
> On Wed, Jun 02, 2010 at 04:35:25PM +0800, Wu Zhangjin wrote:
> > We have calculated VMLINUZ_LOAD_ADDRESS in shell, which is indecipherable. This
> > patch rewrites it in C.
> > 
> > Changes:
> > 
> > v3 -> v4: (feedback from Sam Ravnborg)
> >   o Makefile: Follow the 80 characters' limit and Remove an un-needed objcopy.
> >   o calc_vmlinuz_load_addr.c: Use a smaller alignment and Add more comments
> > 
> > v2 -> v3: (feedback from Alexander Clouter)
> >   o Drop the unneeded variable n
> >   o Replace the last "unsigned long long" by uint64_t
> > 
> > v1 -> v2: (feedback from Alexander Clouter)
> >   o make it more portable
> >     use EXIT_SUCCESS and EXIT_FAILURE as the return value, and use uint64_t
> >     instead of "unsigned long long".
> >   o add a missing return value
> >     return EXIT_FAILURE if sscanf() not return 1
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Reviewed-by: Alexander Clouter <alex@digriz.org.uk>

-- 
Alexander Clouter
.sigmonster says: The price of greatness is responsibility.
