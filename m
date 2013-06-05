Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 21:26:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55751 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827525Ab3FET053IAgR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 21:26:57 +0200
Date:   Wed, 5 Jun 2013 20:26:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4] MIPS: micromips: Fix improper definition of ISA
 exception bit.
In-Reply-To: <51AF8DAE.30206@gmail.com>
Message-ID: <alpine.LFD.2.03.1306052016120.15274@linux-mips.org>
References: <1370455529-19621-1-git-send-email-Steven.Hill@imgtec.com> <alpine.LFD.2.03.1306052004030.15274@linux-mips.org> <51AF8DAE.30206@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36701
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

On Wed, 5 Jun 2013, David Daney wrote:

> >   Shouldn't this be in a generic place such as trap_init instead?
> > 
> 
> I think it is fine here.  If it spreads to more systems, then factoring them
> out into trap_init might make sense.  For now it doesn't seem like we should
> clutter up trap_init when there aren't many microMIPS systems in existence.

 I disagree.  I don't think a generic processor feature should be handled 
in board-specific files.  A kernel built as a microMIPS binary has 
microMIPS exception handlers so no matter what system it is for it'll need 
the mode bit set correctly (unless someone implements support for a mixed 
setup), so having to add this change to some board-specific file for every 
system that gets support for a microMIPS-ISA-enabled processor looks like 
no more than a maintenance burden to me.  Especially as the !CPU_MICROMIPS 
version of the function is empty and will be optimised away (although 
actually it shouldn't be -- it should clear the ISAOnExc bit to avoid 
surprises).

  Maciej
