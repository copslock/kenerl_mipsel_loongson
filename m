Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 14:42:35 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:47665 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492343Ab0FAMm3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 14:42:29 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
        id B7B7883871; Tue,  1 Jun 2010 13:42:28 +0100 (BST)
Date:   Tue, 1 Jun 2010 13:42:28 +0100
From:   Alexander Clouter <alex@digriz.org.uk>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS
Message-ID: <20100601124228.GI2519@chipmunk>
References: <1275388144-5998-1-git-send-email-wuzhangjin@gmail.com> <1275388144-5998-2-git-send-email-wuzhangjin@gmail.com> <20100601105606.GD2519@chipmunk> <AANLkTikxHLWSoUFQItXnULP-pF1-us7FgAP_GkkoCMeO@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikxHLWSoUFQItXnULP-pF1-us7FgAP_GkkoCMeO@mail.gmail.com>
Organization: diGriz
X-URL:  http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 26961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 323

Hi,

* wu zhangjin <wuzhangjin@gmail.com> [2010-06-01 20:26:23+0800]:
>
> On Tue, Jun 1, 2010 at 6:56 PM, Alexander Clouter <alex@digriz.org.uk> wrote:
> >
> > * Wu Zhangjin <wuzhangjin@gmail.com> [2010-06-01 18:29:03+0800]:
> >>
> >> We have calculated VMLINUZ_LOAD_ADDRESS in shell, which is awful. This patch
> >> rewrites it in C.
> >>
> > I really feel that going down the C route is even worse....what's more
> > this implementation is broken as it always returns with zero, even when
> > sscanf() fails....and 'return -1' is just plain wrong too (look at
> > sysexits.h for wisdom[1]).
> 
> ooh, Sorry, Just found I have forgotten one "return", and for
> portability, will use exit(EXIT_SUCCESS) and exit(EXIT_FAILURE)
> instead later.
>
I *think* 'return EXIT_SUCCESS' is just as good if not better, as you 
have 'int main()' as your entry point...or whatever it is called.
 
> > What is so 'awful' about the shell code version?
> 
> From my point of view, it looks not good at least, and also not good
> for maintaining.
>
Well, I guess I as you are the maintaining, what ever you says 
goes...more importantly whatever you are more comfortable with also.
 
> > The shell lump is shorter in implementation size and I am personally not
> > convinced any reasons hinting towards 'clarity' even apply as the shell
> > code is well documented plus it is trivial to step through on any POSIX
> > shell implementation; which cannot be said for the C code.
> 
> I like shell too, herein, it is really shorter but is also hard to
> understand, and of course, we need to ensure "unsigned long long" is
> at least 64bit wide, I have tested it on my thinkpad SL400 laptop(X86)
> and my Yeeloong netbook(MIPS), both of them works well.
> 
> > I am also not too confident 'unsigned long long' is a great 
> > idea...maybe 'u64' or 'uint64_t' if you are relying on C99[1]?
> 
> good idea, which c header file defines u64 and uint64_t?
>
Wackipedia claims[1] that for C99 you want stdint.h, a quick grep of my 
/usr/include directory agrees too.  It seems that you want 'uint64_t' 
too and not 'u64' which is Linux only...or something.
 
Cheers

[1] http://en.wikipedia.org/wiki/Stdint.h

-- 
Alexander Clouter
.sigmonster says: Gibble, Gobble, we ACCEPT YOU ...
