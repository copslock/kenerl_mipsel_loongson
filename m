Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2011 19:54:14 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:60564 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491755Ab1DNRyI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2011 19:54:08 +0200
Received: by pzk5 with SMTP id 5so720445pzk.36
        for <linux-mips@linux-mips.org>; Thu, 14 Apr 2011 10:54:01 -0700 (PDT)
Received: by 10.68.71.133 with SMTP id v5mr659776pbu.487.1302803641376;
        Thu, 14 Apr 2011 10:54:01 -0700 (PDT)
Received: from [10.0.0.3] ([122.172.162.249])
        by mx.google.com with ESMTPS id 25sm2582803wfb.10.2011.04.14.10.53.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 10:53:59 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
From:   philby john <pjohn@mvista.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <4DA5DF7A.1030207@caviumnetworks.com>
References: <1302710833.14458.1.camel@localhost.localdomain>
         <4DA5DF7A.1030207@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 14 Apr 2011 23:24:45 +0530
Message-ID: <1302803685.3322.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.1 (2.32.1-1.fc14) 
Content-Transfer-Encoding: 7bit
Return-Path: <pjohn@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pjohn@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2011-04-13 at 10:38 -0700, David Daney wrote:
> On 04/13/2011 09:07 AM, philby john wrote:
> > From: Philby John<pjohn@mvista.com>
> 
> ^^^^^^^^ I believe that statement to be not entirely correct.

To be honest, we had a xyz customer report this issue with a patch that
had no original author sign-off. Good to know its origin.
Another shot with correct attributions follows in a second.

Regards,
Philby
> 
> Perhaps you should change it to something like:
> From: David Daney <ddaney@caviumnetworks.com>
> 
> 
> > Date: Wed, 13 Apr 2011 20:46:32 +0530
> > Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
> >
> > Some early Octeon bootloaders cannot process PT_NOTE program
> > headers as reported in numerous sections of the web, here is
> > an example http://www.spinics.net/lists/mips/msg37799.html
> > Loading usually fails with such an error ...
> > Error allocating memory for elf image!
> >
> > The work around usually is to strip the .notes section by using
> > such a command $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
> > It is expected that the vmlinux image got after compilation be
> > bootable. Add a Kconfig option to ignore the PT_NOTE section.
> >
> > Signed-off-by: Philby John<pjohn@mvista.com>
> > ---
