Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Oct 2017 21:23:13 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:35918 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992185AbdJGTXGZ2REV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Oct 2017 21:23:06 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id B9E80208F7; Sat,  7 Oct 2017 21:22:56 +0200 (CEST)
Received: from windsurf.home (LFbn-1-15130-153.w86-206.abo.wanadoo.fr [86.206.236.153])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 8F7B9208B2;
        Sat,  7 Oct 2017 21:22:56 +0200 (CEST)
Date:   Sat, 7 Oct 2017 21:22:55 +0200
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20171007212255.287e6b45@windsurf.home>
In-Reply-To: <20170817221931.GB12588@linux-mips.org>
References: <20170803225547.6caa602b@windsurf.lan>
        <20170804000556.GC30597@linux-mips.org>
        <20170804151920.GA11317@linux-mips.org>
        <20170804174151.2eea9af3@windsurf.lan>
        <20170804222500.GA11675@linux-mips.org>
        <20170805135649.152b0739@windsurf>
        <20170807083448.GA20713@linux-mips.org>
        <20170813224602.25043e8a@windsurf>
        <20170817071534.GH13257@linux-mips.org>
        <6D39441BF12EF246A7ABCE6654B0235380DAB457@hhmail02.hh.imgtec.org>
        <20170817221931.GB12588@linux-mips.org>
Organization: Free Electrons
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Hello,

On Fri, 18 Aug 2017 00:19:31 +0200, Ralf Baechle wrote:

> > Despite the theory being simple, wiring this up will take time as it also
> > involves getting the costing calculations updated.
> > 
> > Please can you submit it as a GCC bug?  
> 
> Will do.
> 
> > As a workaround you may want to include a version of __multi3 in the kernel
> > until it is resolved.  
> 
> Yes, working on that.  This has been made harder by the fact that the
> implementation of __umulti3 is well hidden in the source :)  I now have
> functioning implementation of __multi3 but it's still too ugly to be
> committed to the kernel.
> 
> And while I agree it should be fixed in GCC at the same time the
> generated code while convoluted and unnecessarily slow appears to be
> correct so I think we should support this by adding a suitable __umulti3
> to the kernel code as you suggest.

Has there been any progress on solving this issue ? Either on the GCC
side or the kernel side ?

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
