Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2014 23:37:15 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:39237 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818469AbaEWVhL7I1Qx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 May 2014 23:37:11 +0200
Received: by mail-wg0-f43.google.com with SMTP id l18so5385095wgh.14
        for <multiple recipients>; Fri, 23 May 2014 14:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yBhh4xWRlNtiX6mcPisw93IWT+iJk0D7M40vjiFQXPQ=;
        b=WroPDwKLcywwLfG5Qs4C5C62j23HBOj4SvWEkt2ibTIncQDNz6DaM1xKNd8GxBEsyF
         MtBIyHdjpnfOL+olsEgcWZwPhPWiEnjVRgUmMlvLI35bEqEMxOk7Le4C18eM8fn2BFXk
         s2ajurxfDlIBKCfXYhBMlgYuoKolEdCDUxRjBH1WJ5r+NZ52vcQU+tzLNgrcVYE2KqjG
         iAfe7JXGHafKH4sPn616oqBy+xqkAMr0NTCqaqnFsxJCzMLiINPRKmy0FZ+wjzGHPVW9
         NSfBiknVgxcZ9sVTUarufJURUbIoedNHXq14gpiRRSIIWEUlDVMZsrwPwfSO/K720c7T
         HA5g==
X-Received: by 10.180.24.68 with SMTP id s4mr5882990wif.12.1400881026412;
        Fri, 23 May 2014 14:37:06 -0700 (PDT)
Received: from alberich ([46.78.192.208])
        by mx.google.com with ESMTPSA id b16sm5474692wjx.45.2014.05.23.14.37.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 14:37:05 -0700 (PDT)
Date:   Fri, 23 May 2014 23:37:01 +0200
From:   Andreas Herrmann <herrmann.der.user@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Bolle <pebolle@tiscali.nl>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: cavium-octeon: remove checks for CONFIG_CAVIUM_GDB
Message-ID: <20140523213701.GD23153@alberich>
References: <1400602574.4912.43.camel@x220>
 <20140522132645.GC10287@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140522132645.GC10287@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herrmann.der.user@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herrmann.der.user@googlemail.com
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

On Thu, May 22, 2014 at 03:26:45PM +0200, Ralf Baechle wrote:
> On Tue, May 20, 2014 at 06:16:14PM +0200, Paul Bolle wrote:
> 
> > Three checks for CONFIG_CAVIUM_GDB were added in v2.6.29. But the
> > Kconfig symbol CAVIUM_GDB was never added to the tree. Remove these
> > checks.
> > 
> > Also remove the last reference to octeon_get_boot_debug_flag(). There is
> > no definition of that function anyway.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> 
> Queued for 3.16.  Thanks Paul & Andreas!
> 
> > A follow up might be to remove plat_smp_ops.cpus_done. All these
> > callbacks are now (basically) nops.
> 
> I'll think about it.  The hook is no useful if unused then again now and
> then ordering issues in SMP startup of secondary CPUs are showing up and
> it may be useful to solve those.  Maybe something like
> 
> void __init smp_cpus_done(unsigned int max_cpus)
> {
> - 	mp_ops->cpus_done();
> + 	if (cpus_done)
> + 		mp_ops->cpus_done();
> }
> 
> which would make a NULL cpus_done function pointer safe and allow empty definitions
> to be removed.

I'd prefer this solution over complete removal of the hook.


Andreas
