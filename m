Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Mar 2010 12:37:20 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.144]:21574 "EHLO
        ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491075Ab0C0LhP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Mar 2010 12:37:15 +0100
Received: by ey-out-1920.google.com with SMTP id 3so845504eyh.52
        for <linux-mips@linux-mips.org>; Sat, 27 Mar 2010 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Hb/SscA689bcXG56bOFhlLbjCCuHWYxAbr4pYr+H7Go=;
        b=VDjgOcaihu9wsK1ykyeX1CTyLbv9x9ZmHSHv3OyzhO4sIhAb9lXATgozuRgHiwGVZz
         IqAwb5Kzq43vFzMQ3FJutcb6rmLOsL0r8UGn4we69DXotImtShRTGb2TlQ2VuvzEqfoW
         lDNA1uIHGHCd6Iu7shKSDBvOr02BtfC3I4iHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=jC7xJfpJrX6pWpubnbNbiO95C6G4sJmDGc/rfyLbsK6mpXXzUJD3bAbIZcA/lbCf0V
         LB46vBV5cMBTlxEoc9a58PZCMD2N+w7780WOMhkhpc/cB/s57bF7JeaTvx7eF/Y1+0HV
         d2kUJJIXDdqjqAbe1ry6uoXdr4ryf8om5+RiQ=
Received: by 10.213.41.3 with SMTP id m3mr850797ebe.93.1269689834870;
        Sat, 27 Mar 2010 04:37:14 -0700 (PDT)
Received: from [192.168.1.2] ([91.196.252.7])
        by mx.google.com with ESMTPS id 16sm1176238ewy.11.2010.03.27.04.37.10
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 04:37:13 -0700 (PDT)
From:   randrianasulu@gmail.com
To:     linux-mips@linux-mips.org
Subject: SGI O2 boot  hang with latest kernels
Date:   Sat, 27 Mar 2010 14:35:09 +0000
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201003271435.17816.randrianasulu@gmail.com>
Return-Path: <randrianasulu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randrianasulu@gmail.com
Precedence: bulk
X-list: linux-mips

I was testing my r5k, 256 Mb ram SGI O2 again after some inactivity, and found 
what latest kernel (from LMO git, up to commit 
9368a0777aa3eaab13dcbd7038041df54885dc32
   MIPS: Fix __vmalloc() etc. on MIPS for non-GPL modules ) compiled with my 
usual kernel toolchain (binutils-2.19.1/gcc 4.3.3) will lock up/hang very 
early, even before  clearing screen.

Git bisect point me at some bootmem changes, last working commit for me is


commit a626b46e17d0762d664ce471d40bc506b6e721ab
Merge: c1dcb4b dce46a0
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Mar 3 08:15:05 2010 -0800

    Merge branch 'x86-bootmem-for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip

and bad one:

commit fb7b096d949fa852442ed9d8f982bce526ccfe7e
Merge: a626b46 fad5399
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Mar 3 08:15:37 2010 -0800

    Merge branch 'x86-apic-for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip


Sorry for annoy you all on IRC, i'll try to add more interesting details about 
this hang as fast as my O2 finished some compile job i have running on it 
currently
