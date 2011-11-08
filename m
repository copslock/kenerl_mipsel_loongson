Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 23:30:52 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:57730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904024Ab1KHWap (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2011 23:30:45 +0100
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id DB1D78AD27;
        Tue,  8 Nov 2011 23:30:44 +0100 (CET)
Message-ID: <4EB9AD98.3010404@suse.cz>
Date:   Tue, 08 Nov 2011 23:30:48 +0100
From:   Michal Marek <mmarek@suse.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; cs-CZ; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Arnaud Lacombe <lacombar@gmail.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Daney, David" <David.Daney@caviumnetworks.com>
Subject: Re: [PATCH] Kbuild: append missing-syscalls to the default target
 list
References: <1314234210-11090-1-git-send-email-lacombar@gmail.com> <4E69FEC9.2080204@suse.cz> <CACqU3MUFyn_jh2pN4GLENqcGVUzAwcMJUR_WLY2EtqOhMheceQ@mail.gmail.com> <20111101232233.GA32441@sepie.suse.cz> <20111107204448.GA9949@linux-mips.org> <20111107211900.GB6264@sepie.suse.cz> <20111107233330.GA26705@linux-mips.org> <4EB8E75D.1010706@suse.cz> <4EB97333.1050403@gmail.com>
In-Reply-To: <4EB97333.1050403@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7269

On 8.11.2011 19:21, David Daney wrote:
> The problem is that compiler options meant to be used only for the 
> compiling done by scripts/checksyscalls.sh are now leaking into the 
> compilation of other parts of the kernel (asm-offsets.c), where they 
> wreak havoc.
> 
> Something like the attached is what I think needs to be done.

Ah, right. That makes a lot of sense now. Ralf, does the patch at
https://lkml.org/lkml/2011/11/8/312 work for you?

Michal
