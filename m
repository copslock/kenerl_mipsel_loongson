Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2012 14:59:00 +0200 (CEST)
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36734 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903479Ab2FPM65 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jun 2012 14:58:57 +0200
Received: from 10.103.77.188.dynamic.jazztel.es ([188.77.103.10] helo=mail.viric.name)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1SfsaY-000ACM-Cb; Sat, 16 Jun 2012 12:58:50 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id 55DDF58FDA0; Sat, 16 Jun 2012 14:58:47 +0200 (CEST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 188.77.103.10
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18nS8amA8xTQNj3Xhdd/Hvv
Date:   Sat, 16 Jun 2012 14:58:47 +0200
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        loongson-dev@googlegroups.com
Subject: Re: [PATCH] MIPS: Add emulation for fpureg-mem unaligned access
Message-ID: <20120616125847.GR2039@vicerveza.homeunix.net>
Mail-Followup-To: Jonas Gorski <jonas.gorski@gmail.com>,
        linux-mips@linux-mips.org, loongson-dev@googlegroups.com
References: <20120615234641.6938B58FE7C@mail.viric.name>
 <CAOiHx==JS9KfPWxx+pyRNwvq-pWdhbZk+Q-qvRPsVGh90Xso9Q@mail.gmail.com>
 <20120616121513.GP2039@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20120616121513.GP2039@vicerveza.homeunix.net>
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: 8BIT
X-archive-position: 33677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viric@viric.name
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello again,

On Sat, Jun 16, 2012 at 02:15:13PM +0200, Lluís Batlle i Rossell wrote:
> > From what I can tell, ldc1 is a valid MIPS32 instruction, so this
> > should probably be something like
> > 
> >         case ld_op:
> > #ifndef CONFIG_64BIT
> >                 return sigill;
> > #endif
> 
> I agree! I'll repost with these fixes.

Well, I think I take my words back. Handling the ldc1/sdc1 cases in MIPS32 is
tricker than I thought first, because I can't use ldl/ldr or sdl/sdr there.
Given my ability with mips assembly, I leave the patch as is.

In 'patchwork' I had set the patch first to superseeded, but then I set it back
to New.

Regards,
Lluís.
