Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 11:14:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45606 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903560Ab2EFJOq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2012 11:14:46 +0200
Date:   Sun, 6 May 2012 10:14:46 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>
cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 1/2] MIPS: Kbuild: remove -Werror
In-Reply-To: <1336293478.2801.4.camel@brekeke>
Message-ID: <alpine.LFD.2.00.1205060950090.3701@eddie.linux-mips.org>
References: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>                 <4F9AD14E.9060008@gmail.com>                 <alpine.LFD.2.00.1205060754390.19691@eddie.linux-mips.org>         <1336289676.1996.3.camel@koala>        
 <alpine.LFD.2.00.1205060925070.3701@eddie.linux-mips.org> <1336293478.2801.4.camel@brekeke>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, 6 May 2012, Artem Bityutskiy wrote:

> >  And my opinion is based on experience.  Please check the LMO archives for 
> > why Ralf added this option in the first place -- many years ago.  It's 
> > probably recorded in the git repository too (I'm not sure if the option 
> > was added before or after we moved away from CVS, but in any case old 
> > change logs have been imported when our current repo was created).
> 
> We need to figure out how to make -Werror be applied only when we do not
> have W=[123].

 Hmm, that sounds better, however has the counter-intuitive side-effect of 
lowering the severity of the warnings that are enabled even without 
W=[123].

 Modern versions of GCC have that selective -Wno-error=foo option and I 
think it should be possible to build the precise list of warnings not to 
choke on locally in arch/mips/Kbuild with little Makefile magic, falling 
back to something sane for older GCC versions (I'm not sure exactly when 
these selective options were added, certainly sometime between 4.1 and 
4.3).

 This will be a bit imperfect if any of these additional -Wfoo options 
duplicate ones already added to KBUILD_CFLAGS in our top-level Makefile 
(either explicitly or via -Wall), but that's about the best we can do.  
I'll see if I can cook up something quickly.

  Maciej
