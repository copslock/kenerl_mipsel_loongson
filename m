Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 20:01:30 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45989 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008789AbaLRTB1yrcsj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Dec 2014 20:01:27 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBIJ1P1O008381;
        Thu, 18 Dec 2014 20:01:25 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBIJ1Pc2008380;
        Thu, 18 Dec 2014 20:01:25 +0100
Date:   Thu, 18 Dec 2014 20:01:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA
 constrains for MIPS R6 support
Message-ID: <20141218190125.GA8221@linux-mips.org>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
 <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com>
 <549321F3.1090704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549321F3.1090704@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44810
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

On Thu, Dec 18, 2014 at 10:50:27AM -0800, David Daney wrote:

> On 12/18/2014 07:09 AM, Markos Chandras wrote:
> >MIPS R6 changed the opcodes for LL/SC instructions and reduced the
> >offset field to 9-bits. This has some undesired effects with the "m"
> >constrain since it implies a 16-bit immediate. As a result of which,
> >add a register ("r") constrain as well to make sure the entire address
> >is loaded to a register before the LL/SC operations. Also use macro
> >to set the appropriate ISA for the asm blocks
> >
> 
> Has support for MIPS R6 been added to GCC?
> 
> If so, that should include a proper constraint to be used with the new
> offset restrictions.  We should probably use that, instead of forcing to a
> "r" constraint.

In a non-public earlier discussion I've requested the same but somehow
that was ignored.

We need suitable constraints or the alternatives will be very, very ugly.

  Ralf
