Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2011 05:49:26 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:45640 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491046Ab1DCDtT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2011 05:49:19 +0200
Received: by vxd2 with SMTP id 2so4269384vxd.36
        for <linux-mips@linux-mips.org>; Sat, 02 Apr 2011 20:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=S4Go7U19N/MZaCYDJY1f532FqR4InbX/UYpZ4PhUs3Q=;
        b=CR0YZ/8bETBpGmaA29RaRJl0wOF6syp/0yDm3Js55FhsSXbeQ8PJ/GtmUQDhUKYCQy
         l3GCr82rvWqR7BKcpDD3X+cHjoDvJt0AAcKmHJMBFbxIzKgw8eR/FPF+PWxzN6+ohMX1
         kFnD5bwEXNNEVE+TFQVANhYnGPG6+uTWEIkIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=IfCyrBDYyO0Nc94z45/UUXfbgmI+ZwYmTGWv4GC33BesCoIu6HHQtGiy7sJdK/V4t+
         SHKpY68vqCyBcT7Hxw1KRlbm+X9dZVZvUR0fmcopFK0D05ICoEtRF4MuRXynUrY6sj11
         OmGPXlOamfF95K/O8gm44a+ew5zPvTRX5vgyw=
MIME-Version: 1.0
Received: by 10.52.66.135 with SMTP id f7mr469728vdt.198.1301802553404; Sat,
 02 Apr 2011 20:49:13 -0700 (PDT)
Received: by 10.52.161.169 with HTTP; Sat, 2 Apr 2011 20:49:13 -0700 (PDT)
Date:   Sun, 3 Apr 2011 11:49:13 +0800
Message-ID: <BANLkTikpqk-UcFHHD6MGyZgv6LociaETtg@mail.gmail.com>
Subject: System suffers frequent TLB miss
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all

We have a system running on mips64 xlr 732.  Our major application
process is binded on CPU5,

In order to reduce the tlb miss of our major process, we took the
following steps:

(I)  Use 2 number of  tlb entries  to map  the elf code segment and
data segment, say,  tlb_entry[i] { code segment}   and tlb_entry[i+1]
{data segment}  respectively.

(II)  Use another  6 number of tlb entries to map 6 reserved memory
regions. In this way, our process can manipulate these

   6 regions without any tlb miss.


However we found that,  the tlib miss frequency  for (I) and (II) is
very high.

We guess the reson for this is that, we use some malloc
operation,which leads to great tlb miss, and replace our tlb entries.

So we took messures to  isolate our tlb  entries and ordinary tlb
entres that were used for malloc.

(III)  In tlb_init function, we set the wried register to 6, so when
ordinary tlb miss occured, the tlb refill hander would write a random
tlb entry above 6,

 at the same time we can use our own 6 tlb entries to map whatever we want.




After this, we found that, process is still sufferring from TLB miss
in our 6 tlb entries.


I'm  totally exhausted about the tlb miss, I wonder if we can record
the virtual region of tlb miss  and the miss count in each region, in
that way,

I can find out which part leads to this tlb miss.That is , to record
C0_BADVADDR  in tlb miss.


However I'm not sure how to add code in build_r4000_tlb_refill_handler
function, for it is wrote in some strage way .


Any  suggestion on how to reduce tlb miss?

Thx in advance.
