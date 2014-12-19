Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 13:30:03 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52238 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009157AbaLSMaBn8oG5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Dec 2014 13:30:01 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBJCU0JA026881;
        Fri, 19 Dec 2014 13:30:00 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBJCTxId026880;
        Fri, 19 Dec 2014 13:29:59 +0100
Date:   Fri, 19 Dec 2014 13:29:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA
 constrains for MIPS R6 support
Message-ID: <20141219122959.GH14160@linux-mips.org>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
 <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com>
 <549321F3.1090704@gmail.com>
 <20141218190125.GA8221@linux-mips.org>
 <6D39441BF12EF246A7ABCE6654B0235320F8AD08@LEMAIL01.le.imgtec.org>
 <549352E4.7090800@gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320F8AF3D@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320F8AF3D@LEMAIL01.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Dec 18, 2014 at 10:58:02PM +0000, Matthew Fortune wrote:

> Yes you are right I thought this particular case only had constraints
> for the immediate and not the whole memory operand, I'm suffering from
> too many tasks and too little time. Several of the memory constraints are
> marked as internal and I'm not sure if that means they are unsafe to use
> from inline asm or just not deemed important.
> 
> The memory constraint that LL and SC need is 'ZC'. I don't believe this
> is documented so you will have to trust that its meaning will not change
> but I can give some assurance of that since I will review all MIPS GCC
> changes.
> 
> Obviously to use anything other than the 'm' constraint you are going
> to need to know when any given constraint was added to GCC.
> 'ZC' was only added to GCC in March 2013 r196828 which I believe it is a
> GCC 4.9 feature so you will have to use it conditionally if you use it at
> all.
> 
> BTW thanks for the thread, it seems I missed updating 'ZC' for MIPSR6.
> Bug fixed!

How about the "o" constraint?  The kernel uses it only in a few places
and not currently with LL/SC though that might allow for some extra
optimization(?).  Is the a suitable "o"-like constraint for use with
LL/SC on R6?

  Ralf
