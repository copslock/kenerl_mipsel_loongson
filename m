Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 18:23:09 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:59199 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008443AbaLRRXIIo00Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 18:23:08 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so1790153pab.28;
        Thu, 18 Dec 2014 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GywVxlRtsOAIOZ0Ziu7ZgkIapTTbvSD3iwPzsYlx/DY=;
        b=uiubv9EUM4/mBIKbE3Am0v8VOqeMLtn+bq7c1S8sKx5yGjJmivuLYw+6C/iZbP222g
         pBaFRbzcFyCv/iDxAfeGaUtT8kduVfzV8Vq6nXI2ZzIwZ15bLTYWK0/bH3cqai8yCNrS
         VOm8ot/qjs68G4iveZ11Ci5tEUbmPEZY/RDA+yeluRa0Qq72sEoIkUefqBO+ghuU2qOr
         9CmK67F0UL7Smp303FSSwSIkaGHfWmNOEvUeNefxuqAeRTV8uPVZ2ol0zk2JULjJ9bz6
         kVMRetUiMOh9MXxrkIk2nN0NN02CGelAl1lEYowTNsfT68iUGgg+EZ1K4ELTwMmdONPB
         CF9g==
X-Received: by 10.66.102.41 with SMTP id fl9mr5224127pab.7.1418923381466;
        Thu, 18 Dec 2014 09:23:01 -0800 (PST)
Received: from brian-ubuntu (cpe-76-173-170-164.socal.res.rr.com. [76.173.170.164])
        by mx.google.com with ESMTPSA id bn13sm7385279pdb.4.2014.12.18.09.23.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 09:23:00 -0800 (PST)
Date:   Thu, 18 Dec 2014 09:22:58 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: JZ4740: fixup #include's (sparse)
Message-ID: <20141218172258.GJ7112@brian-ubuntu>
References: <1418870341-16618-1-git-send-email-computersforpeace@gmail.com>
 <20141218130203.GC25711@linux-mips.org>
 <20141218144424.GA1943@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20141218144424.GA1943@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Thu, Dec 18, 2014 at 03:44:24PM +0100, Ralf Baechle wrote:
> On Thu, Dec 18, 2014 at 02:02:03PM +0100, Ralf Baechle wrote:
> 
> > > 
> > >   arch/mips/jz4740/irq.c:63:6: warning: symbol 'jz4740_irq_suspend' was not declared. Should it be static?
> > >   arch/mips/jz4740/irq.c:69:6: warning: symbol 'jz4740_irq_resume' was not declared. Should it be static?
> > > 
> > > Also, I've seen some elusive build errors on my automated build test
> > > where JZ4740_IRQ_BASE and NR_IRQS are missing, but I can't reproduce
> > > them manually for some reason. Anyway, mach-jz4740/irq.h should help us
> > > avoid relying on some implicit include.
> > 
> > Patch is looking good.
> > 
> > There is a known issue building jz in a separate build directory; building
> > in the source directory itself will succeed.  Could that be why you can't
> > seem to reproduce the build issue?
> 
> With your patch applied I still can reproduce that build issue issue:

Right, I never did straighten this out entirely for myself. And no, I
don't claim to have fixed all build issues here. I think the same issue
shows up in several other files which reference irq.h too.

> [...]
>   CC      arch/mips/jz4740/irq.o
> In file included from /home/ralf/src/linux/linux-mips/include/linux/irq.h:392:0,
>                  from /home/ralf/src/linux/linux-mips/include/asm-generic/hardirq.h:12,
>                  from /home/ralf/src/linux/linux-mips/arch/mips/include/asm/hardirq.h:16,
>                  from /home/ralf/src/linux/linux-mips/include/linux/hardirq.h:8,
>                  from /home/ralf/src/linux/linux-mips/include/linux/interrupt.h:12,
>                  from /home/ralf/src/linux/linux-mips/arch/mips/jz4740/irq.c:19:
> /home/ralf/src/linux/linux-mips/include/linux/irqdesc.h:92:33: error: ‘NR_IRQS’ undeclared here (not in a function)
>  extern struct irq_desc irq_desc[NR_IRQS];
>                                  ^
> make[4]: *** [arch/mips/jz4740/irq.o] Error 1
> make[3]: *** [arch/mips/jz4740] Error 2
> make[2]: *** [arch/mips] Error 2
> make[1]: *** [sub-make] Error 2
> make: *** [__sub-make] Error 2
> make: Leaving directory `/home/ralf/src/linux/obj/qi_lb60-build'
> 
> I haven't looked into depth at this but the issue appears to be that the
> search order for include files is different between building in the source
> directory and the object directory and that there are multiple include
> files with the same name, that is irq.h. are involved.
> 
> So changing the name of the header file should fix this issue but really
> this also is a kbuild bug.

The directory ordering differences do sound familiar.

Yeah, I would expect that in-tree and out-of-tree builds should keep as
many things as possible the same, to avoid problems like this.

Anyway, address this how you'd like (or not at all). I'm only
compile-testing; I don't actually use this build. So I'm not very likely
to spend the time to fix this one.

Thanks,
Brian
