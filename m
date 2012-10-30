Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2012 21:28:16 +0100 (CET)
Received: from smtp167.iad.emailsrvr.com ([207.97.245.167]:34842 "EHLO
        smtp167.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825741Ab2J3U2PoYuQ5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Oct 2012 21:28:15 +0100
Received: from smtp56.relay.iad1a.emailsrvr.com (localhost.localdomain [127.0.0.1])
        by smtp56.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 0645D3D85B3;
        Tue, 30 Oct 2012 16:28:09 -0400 (EDT)
X-SMTPDoctor-Processed: csmtpprox 2.7.4
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp56.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id ED9D73D85B5;
        Tue, 30 Oct 2012 16:28:08 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp192.mex02.mlsrvr.com (smtp192.mex02.mlsrvr.com [204.232.137.43])
        by smtp56.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTPS id C3CE93D85B3;
        Tue, 30 Oct 2012 16:28:08 -0400 (EDT)
Received: from IAD2MBX02.mex02.mlsrvr.com ([172.23.11.10]) by
 iad2hub11.mex02.mlsrvr.com ([172.23.10.75]) with mapi; Tue, 30 Oct 2012
 16:28:05 -0400
From:   Jacob Burkholder <jacob.burkholder@blinqnetworks.com>
To:     David Daney <ddaney.cavm@gmail.com>, Jayachandran C.
        <c.jayachandran@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Tue, 30 Oct 2012 16:28:04 -0400
Subject: RE: linux 3.6.3 mips64 mtd jffs2 unmount issue
Thread-Topic: linux 3.6.3 mips64 mtd jffs2 unmount issue
Thread-Index: Ac22xSFQUT2U75hjRAeERV0E5Y++mQAFuJhg
Message-ID: <14A0B61B8C8EFA4A9F40381A10D219104EEB0F541D@IAD2MBX02.mex02.mlsrvr.com>
References: <14A0B61B8C8EFA4A9F40381A10D219104EEB0F5226@IAD2MBX02.mex02.mlsrvr.com>
 <CA+7sy7CWkcsg9YffJ-rcdN7D=vZtuees31upGzgUya5puDN0og@mail.gmail.com>
 <50901027.6090802@gmail.com>
In-Reply-To: <50901027.6090802@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 34794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jacob.burkholder@blinqnetworks.com
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

> On 10/30/2012 01:09 AM, Jayachandran C. wrote:
> [...]
>
> >
> > We had seen the same issue here, and worked around it the same way
> > (i.e use dynamic allocation for the backing dev structures).
> >
> > I ran across a similar issue in using built-in DTB (basically, kernel
> > data address does not work for virt_to_phys/phys_to_virt in 64-bit
> > when the load address is in CKSEG0).  There I did something like this:
> >
> > ptr = phys_to_virt(__pa(kernel_data_ptr));
> >
> > This works since __pa knows about CKSEG0 addresses in 64bit.
> >
> >
>
> Really the proper fix is to make virt_to_phys() work.  This isn't the only case where we have seen failures due to this issue:
>
>
> http://www.linux-mips.org/archives/linux-mips/2011-09/msg00029.html
>
> I fixed it like this...
>
> In io.h:
>
> static inline unsigned long virt_to_phys(volatile const void *address)
> {
>       return __pa(address);
> }
>
> Really this needs to be pushed upstream by somebody.
>
 
Thanks, this makes sense and seems a good fix.  I had some problems with
twisty includes because page.h includes io.h.  Did you move the definition
of __pa also?
 
Anyway, if this can be pushed to master and merged to linux-stable I'll
pick it up.
 
Jake
