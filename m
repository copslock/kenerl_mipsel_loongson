Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2012 09:09:08 +0100 (CET)
Received: from mail-vc0-f177.google.com ([209.85.220.177]:61368 "EHLO
        mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817033Ab2J3IJHFlLwf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2012 09:09:07 +0100
Received: by mail-vc0-f177.google.com with SMTP id p16so6062512vcq.36
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2012 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zSsN+CtqnDyT0xZF6hoDSyJcu3k/pSePkJp13OybvjA=;
        b=vHA67s398mzTetPv9eRvHcOtrYNONLMF5TFF+sIAnIgucb7urt6anOmoOjYVF+pf3s
         5CsMSFStOou5tRUpkQDtakkdUiMz4eUrYqndVMCmqEEBoZ79Mv7ON+JO9dQJhs9drw4S
         dHRCEFrqyMe5JihkGLW/43y9syKAWigAPVDqw6cjeyCchCiRcc8tfp9H1uaicL+uwPR5
         j3AnMDcfpo5OJlwPkCL37DW+6XSvwoAcvPL4gJa5FBsk5GM9IW8W/fYFCWu5WrTTgj8I
         wVO2NZ4m6pwo1g6MFYdlN4fbgG4S9kKPBlr8AH0Ff3SY4BFZYxmLMHqa066FmBwV5zpL
         41XA==
MIME-Version: 1.0
Received: by 10.52.90.37 with SMTP id bt5mr21628358vdb.67.1351584540669; Tue,
 30 Oct 2012 01:09:00 -0700 (PDT)
Received: by 10.58.161.135 with HTTP; Tue, 30 Oct 2012 01:09:00 -0700 (PDT)
In-Reply-To: <14A0B61B8C8EFA4A9F40381A10D219104EEB0F5226@IAD2MBX02.mex02.mlsrvr.com>
References: <14A0B61B8C8EFA4A9F40381A10D219104EEB0F5226@IAD2MBX02.mex02.mlsrvr.com>
Date:   Tue, 30 Oct 2012 13:39:00 +0530
Message-ID: <CA+7sy7CWkcsg9YffJ-rcdN7D=vZtuees31upGzgUya5puDN0og@mail.gmail.com>
Subject: Re: linux 3.6.3 mips64 mtd jffs2 unmount issue
From:   "Jayachandran C." <c.jayachandran@gmail.com>
To:     Jacob Burkholder <jacob.burkholder@blinqnetworks.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: c.jayachandran@gmail.com
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

On Tue, Oct 30, 2012 at 2:21 AM, Jacob Burkholder
<jacob.burkholder@blinqnetworks.com> wrote:
> Greetings!
>
> We are having an issue with linux 3.6.3 on mips64 with mtd and jffs2.
> The platform is a custom Broadcom XLS board.  The issue occurs when a
> jffs2 is unmounted.  It does not occur with ubifs for what its worth.
>
> What happens is the bdi-default thread gets an unaligned kernel access
> exception.  The unaligned exception is a red herring, the address is
> aligned but it is a bad address.  A boot log and stack trace from the
> bdi-default thread is included below as well as some gdb debugging
> output.  I tracked this down to the backing_dev_info structures that
> are used with mtd devices, mtd_bdi_unmappable, mtd_bdi_ro_mappable,
> mtd_bdi_rw_mappable, in mtdcore.c around line 338.  The mtd device in
> question is nand so uses the mtd_bdi_unmappable backing_dev_info is
> used.  When the jffs2 is unmounted the the bdi_forker_thread gets a
> KILL_THREAD signal and calls bdi_clear_pending on the backing_dev_info
> structure mentioned above.  This is turn calls
> wake_up_bit(&bdi->state, BDI_pending);, wake_up_bit looks up the zone
> for the page that the passed address is in and this seems to be the
> problem.  The backing_dev_info structures are statically allocated in
> the kernel data section and these addresses don't seem to have a vm
> zone structure.  I set a breakpoint in wake_up_bit and can that it gets
> called on other addresses which all start with 0xa8000000, finally it
> gets passed the address in the mtd_bdi_unmappable structure and then
> crashes.  I changed the backing_dev_info structures to be allocated
> with kzalloc and the problem goes away and jffs2 generally works.
> We link our kernel at address 0xffffffff80100000 and this is what our
> bootloader expects.  I tried to change this to link at 0xa800000001000000,
> which would seem to put the kernel data section where the bdi thread
> expects its backing_dev_info structures to be allocated, but our
> bootloader won't boot the image and I don't know if its the correct way
> to deal with the problem.  I don't think this is an mtd problem since
> other platforms use these files unmodified, so not sure where to start.
>
> Thanks for any hints.

We had seen the same issue here, and worked around it the same way
(i.e use dynamic allocation for the backing dev structures).

I ran across a similar issue in using built-in DTB (basically, kernel
data address does not work for virt_to_phys/phys_to_virt in 64-bit
when the load address is in CKSEG0).  There I did something like this:

ptr = phys_to_virt(__pa(kernel_data_ptr));

This works since __pa knows about CKSEG0 addresses in 64bit.


JC.
