Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2010 16:01:50 +0100 (CET)
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:57346 "EHLO
        ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491876Ab0CZPBp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Mar 2010 16:01:45 +0100
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from imp.csi.cam.ac.uk ([131.111.10.57]:57114)
        by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:587)
        with esmtpsa (PLAIN:aia21) (TLSv1:AES128-SHA:128)
        id 1NvB2e-0007a7-N7 (Exim 4.70)
        (return-path <aia21@cam.ac.uk>); Fri, 26 Mar 2010 15:01:44 +0000
Subject: Re: [PATCH] Fix __vmalloc(), etc on MIPS for non-GPL modules
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From:   Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <20100326145236.GX4554@linux-mips.org>
Date:   Fri, 26 Mar 2010 15:01:43 +0000
Cc:     Chris Dearman <chris@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F993642A-87A5-443A-B52D-91EC2944DD3F@cam.ac.uk>
References: <Pine.LNX.4.64.1003252017360.17596@hermes-2.csi.cam.ac.uk> <20100326145236.GX4554@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
X-Mailer: Apple Mail (2.1077)
Return-Path: <aia21@cam.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aia21@cam.ac.uk
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On 26 Mar 2010, at 14:52, Ralf Baechle wrote:
> On Thu, Mar 25, 2010 at 08:48:12PM +0000, Anton Altaparmakov wrote:
>> The commit 351336929ccf222ae38ff0cb7a8dd5fd5c6236a0 which can be seen 
>> here:
> 
> Which was in 2.6.26 ...

Yes.  (-:

Embedded companies tend to use very old kernels.  Usually 2.6.10-2.6.18 range.  This is the fist time someone using MIPS architecture came up with a 2.6.27 kernel and linking failed hence my patch.  I only personally test compilation across all kernels (2.6.10-latest) on x86 so I miss things like that happening...

>> I therefore propose that the EXPORT_SYMBOL_GPL(_page_cachable_default) is 
>> changed to EXPORT_SYMBOL(_page_cachable_default) to re-instate the 
>> ability for non-GPL modules to call __vmalloc(), vmap(), vm_map_ram(), 
>> and such like.
>> 
>> Here is a patch that does this.  If you approve, please apply it.
> 
> I approve - but applying would be easier if this patch had not been
> linewrapped ...

Sorry about that!!!  I sent the patch using Pine and thought I was safe on that front but I probably did something wrong.  )))-:

> Applied to master and -stable.  Thanks!

Great, thanks!

Best regards,

	Anton

>  Ralf

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
