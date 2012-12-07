Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 16:24:50 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43831 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823102Ab2LGPYt2knDK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Dec 2012 16:24:49 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qB7FOiNF028412;
        Fri, 7 Dec 2012 16:24:44 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qB7FOckh028411;
        Fri, 7 Dec 2012 16:24:38 +0100
Date:   Fri, 7 Dec 2012 16:24:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        "Kevin D. Kissell" <kevink@paralogos.com>
Subject: Re: [PATCH v99,01/13] MIPS: microMIPS: Add support for microMIPS
 instructions.
Message-ID: <20121207152438.GC25923@linux-mips.org>
References: <1354856737-28678-1-git-send-email-sjhill@mips.com>
 <1354856737-28678-2-git-send-email-sjhill@mips.com>
 <CAJiQ=7BKXMbRZqwxPnFqFS3nUuGr819zQbuhbAspOZvpCYpnFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJiQ=7BKXMbRZqwxPnFqFS3nUuGr819zQbuhbAspOZvpCYpnFw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35247
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Dec 06, 2012 at 11:50:10PM -0800, Kevin Cernekee wrote:

> Some random thoughts/nitpicks on this section:
> 
> The microMIPS patch nearly quadruples the number of instruction
> formats in the mips_instruction union, so it might be worth
> considering questions like:
> 
> 1) Is this the optimal way to represent this information, or have we
> reached a point where it is worth adding more complex "infrastructure"
> that would support a more compact instruction definition format?
>
> 2) Is there a better way to handle the LE/BE bitfield problem, than to
> duplicate each of the 28+ structs?

Something based on #defines, for example.  Back in the dark ages I
figured bitfields would be nicer way to represent instruction formats.
Against the warning words of I think Kevin Kissel I went for the bitfields
and this would be a good opportunity to change direction.

  Ralf
