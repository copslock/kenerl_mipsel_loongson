Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 18:39:41 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:58314 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992240AbdKGRjelk7Hx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 18:39:34 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id A2C962083B; Tue,  7 Nov 2017 18:39:25 +0100 (CET)
Received: from windsurf (unknown [88.128.80.144])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 667FD20838;
        Tue,  7 Nov 2017 18:39:15 +0100 (CET)
Date:   Tue, 7 Nov 2017 18:39:15 +0100
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20171107183915.7aa19ae9@windsurf>
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
X-archive-position: 60748
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

Has there been some progress on this front? I'm willing to test patches
if needed.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
