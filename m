Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 16:54:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55968 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827391Ab3ISOywwyT8b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Sep 2013 16:54:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8JEspgG027225;
        Thu, 19 Sep 2013 16:54:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8JEspAn027224;
        Thu, 19 Sep 2013 16:54:51 +0200
Date:   Thu, 19 Sep 2013 16:54:51 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Lohoff <f@zz.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: Roll call for porters of architectures in sid and testing
 (Status update)
Message-ID: <20130919145451.GE22468@linux-mips.org>
References: <20130919103158.GB7476@pax.zz.de>
 <20130919135852.GB22468@linux-mips.org>
 <20130919141006.GB9062@pax.zz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130919141006.GB9062@pax.zz.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37886
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

On Thu, Sep 19, 2013 at 04:10:06PM +0200, Florian Lohoff wrote:

> On Thu, Sep 19, 2013 at 03:58:52PM +0200, Ralf Baechle wrote:
> > On Thu, Sep 19, 2013 at 12:31:58PM +0200, Florian Lohoff wrote:
> > 
> > > just a heads up that Mips and Mipsel are 2 architectures in danger
> > > of beeing dropped by Debian if no one steps up as a porter beeing
> > > reachable for addressing architecture specific bugs. 
> > 
> > What components and packages are we talking about?  Are we talking about
> > a fulltime job for a small army of geeks or?
> 
> Its about dealing with architecture specific problems. Looking after
> ICEs, userspace asm stuff for debian packages where they break etc.
> 
> A typical Debian Developer wont know about the mips specifics and 
> needs someone to adress stuff to if the build breaks for architecture
> specific problems.
> 
> Debian has formalizes the release criterias for their architectures
> concerning build architecture, availabibility of hardware and 
> manpower to fix those problems. This is why there needs to be some
> names on the list.
> 
> All the Debian architectures are depending on one another. So if a
> gcc build fails for parisc the new gcc cant propagate to stable/testing.
> So the release managers are keen on quickly fixing those bugs to not
> hold up all architectures progressing.

Sounds like this is really a job for a number of specialists in various
fields.

You also mentioned the availability of hardware.  How's the situation
there wrt. to MIPS?

  Ralf
