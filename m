Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2012 23:01:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41369 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903568Ab2GSVBJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2012 23:01:09 +0200
Date:   Thu, 19 Jul 2012 22:01:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Matt Turner <mattst88@gmail.com>
cc:     Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
In-Reply-To: <CAEdQ38EDKndUcdBu1tZ_dOuhweVRW6aA=YKb6kUE3gUQJiwWoQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1207160208570.12288@eddie.linux-mips.org>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com> <20110903103036.161616a5@endymion.delvare> <20111031105354.4b888e44@endymion.delvare> <20120110153834.531664db@endymion.delvare> <CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg@mail.gmail.com>
 <20120331082346.26cc95cb@endymion.delvare> <CAEdQ38Ez+8DudAaJY7HZu9jbisk_KMbBO5h=s+P4pjJ0Va-zWw@mail.gmail.com> <CAEdQ38EDKndUcdBu1tZ_dOuhweVRW6aA=YKb6kUE3gUQJiwWoQ@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33942
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, 30 Jun 2012, Matt Turner wrote:

> I'm not going to have time to do this. :(
> 
> I had another look at the code, and I'm not sure I really understand
> it well enough to address your concerns.

 I'll try then, as soon as I can.

> Good thing there are only about three users with this motherboard.

 Really?  I've thought Debian used them for MIPS distribution builds if 
nobody else.  AFAIK, ten years on and these systems (I mean the whole 
family) are still about the only ones reasonably widely available that 
provide performance decent enough for native use these days (yes, I did 
make serious use of an R3k DECstation natively once -- waiting for a GCC 
bootstrap to complete after the expected four weeks of computing time only 
to see it choke on a Makefile typo three weeks into was all but fun).

  Maciej
