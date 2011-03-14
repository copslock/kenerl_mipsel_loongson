Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2011 15:24:36 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:4443 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491038Ab1CNOYd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Mar 2011 15:24:33 +0100
X-TM-IMSS-Message-ID: <1acc0a5c0000d8bb@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 1acc0a5c0000d8bb ; Mon, 14 Mar 2011 07:24:24 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 14 Mar 2011 07:24:37 -0700
Date:   Mon, 14 Mar 2011 19:59:27 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     "wilbur.chan" <wilbur512@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Support for Netlogic XLR/XLS processors
Message-ID: <20110314142927.GA18480@jayachandranc.netlogicmicro.com>
References: <20110312182714.GC2217@jayachandranc.netlogicmicro.com>
 <AANLkTime__o2bGyUn1-CsY4O=VhniN14u_fHYYxYz=VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTime__o2bGyUn1-CsY4O=VhniN14u_fHYYxYz=VQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 14 Mar 2011 14:24:38.0248 (UTC) FILETIME=[8CCB2E80:01CBE253]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Mon, Mar 14, 2011 at 08:19:22PM +0800, wilbur.chan wrote:
> Will kexec be supported on XLS/XLR/XLP ?

The patches I have does not support it. I haven't really looked at what
is needed in XLR platform code to support kexec, so I'm not sure what it
takes to support it for XLR either. Any pointers?

JC.
-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
