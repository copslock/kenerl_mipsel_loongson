Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 21:57:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55290 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006774AbaHYT5KSH8-w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 21:57:10 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PJv8sg005779;
        Mon, 25 Aug 2014 21:57:08 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PJv8kI005778;
        Mon, 25 Aug 2014 21:57:08 +0200
Date:   Mon, 25 Aug 2014 21:57:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH V2] MIPS: fix build with binutils 2.24.51+
Message-ID: <20140825195707.GK25892@linux-mips.org>
References: <1408465632-34262-1-git-send-email-manuel.lauss@gmail.com>
 <20140825125107.GA25892@linux-mips.org>
 <alpine.LFD.2.11.1408251502140.18483@eddie.linux-mips.org>
 <CAOLZvyG4F_PCb5hbws1_e8nCeJ+odvnC5u=yitSe9CwY3TWZdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLZvyG4F_PCb5hbws1_e8nCeJ+odvnC5u=yitSe9CwY3TWZdw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42237
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

On Mon, Aug 25, 2014 at 09:29:24PM +0200, Manuel Lauss wrote:

> >    Otherwise we'd have to bump the binutils requirement up to 2.19; this
> 
> Do people really update their toolchain so rarely?

The users of very old toolchains mostly fall into two categories:

 - build farms.  All that matters is if the code is building as it probably
   won't ever get to see a CPU from the inside.
 - users running into issues with an old kernel in an otherwise well
   running system.  They will try to use whatever is installed because
   an upgrade can be technically hard - or somebody most likely wearing a
   tie may throw a tantrum at the thought of upgrding.

  Ralf
