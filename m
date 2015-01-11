Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 00:51:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35886 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011055AbbAKXvArhSVA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 00:51:00 +0100
Date:   Sun, 11 Jan 2015 23:51:00 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA constrains
 for MIPS R6 support
In-Reply-To: <5493FBE1.7000602@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501112338070.27458@eddie.linux-mips.org>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com> <549321F3.1090704@gmail.com> <20141218190125.GA8221@linux-mips.org> <6D39441BF12EF246A7ABCE6654B0235320F8AD08@LEMAIL01.le.imgtec.org>
 <549352E4.7090800@gmail.com> <6D39441BF12EF246A7ABCE6654B0235320F8AF3D@LEMAIL01.le.imgtec.org> <5493FBE1.7000602@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 19 Dec 2014, Markos Chandras wrote:

> > Obviously to use anything other than the 'm' constraint you are going
> > to need to know when any given constraint was added to GCC.
> > 'ZC' was only added to GCC in March 2013 r196828 which I believe it is a
> > GCC 4.9 feature so you will have to use it conditionally if you use it at
> > all.
> > 
> 
> is this something desirable? check the gcc version, initialize a macro
> and then use that macro as a constrain? i haven't thought this through,
> but it could be a bit messy.

 There is prior art for this, see arch/mips/include/asm/compiler.h and 
then grep the tree for uses.

  Maciej
