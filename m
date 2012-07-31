Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2012 16:07:40 +0200 (CEST)
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25745 "EHLO
        mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903610Ab2GaOHd convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2012 16:07:33 +0200
Received: from 114.107.77.188.dynamic.jazztel.es ([188.77.107.114] helo=mail.viric.name)
        by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1SwD6d-000IDg-Sf; Tue, 31 Jul 2012 14:07:28 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id BCBCC2446; Tue, 31 Jul 2012 16:07:23 +0200 (CEST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 188.77.107.114
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18fsuIpaQBQwB9FMRSDIWw6
Date:   Tue, 31 Jul 2012 16:07:23 +0200
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, loongson-dev@googlegroups.com
Subject: Re: [PATCH] MIPS: Add emulation for fpureg-mem unaligned access
Message-ID: <20120731140723.GB25996@vicerveza.homeunix.net>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, loongson-dev@googlegroups.com
References: <20120615234641.6938B58FE7C@mail.viric.name>
 <20120731134001.GA14151@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20120731134001.GA14151@linux-mips.org>
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: 8BIT
X-archive-position: 34005
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

On Tue, Jul 31, 2012 at 03:40:01PM +0200, Ralf Baechle wrote:
> On Sat, Jun 16, 2012 at 12:22:53AM +0200, Lluis Batlle i Rossell wrote:
> 
> > Reusing most of the code from lw,ld,sw,sd emulation,
> > I add the emulation for lwc1,ldc1,swc1,sdc1.
> > 
> > This avoids the direct SIGBUS sent to userspace processes that have
> > misaligned memory accesses.
> > 
> > I've tested the change in Loongson2F, with an own test program, and
> > WebKit 1.4.0, as both were killed by sigbus without this patch.
> 
> A misaligned FPU access is a strong indication for broken, non-portable
> software.  which means you're likely trying to fix the wrong issue.  It's
> quite intentional that there is no unaligned handling for the FPU in the
> kernel - and afaics there isn't for any other MIPS UNIX.

Ah, I had no idea it was intentional. 

Maybe there could be a cleaner declaration of that intention, though. The only
code there was "I herewith declare: this does not happen.  So send SIGBUS."

Thank you,
Lluís.
