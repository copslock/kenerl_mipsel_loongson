Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2014 18:36:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53450 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825887AbaESQgGUf7Ge (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 May 2014 18:36:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4JGa3HZ009961;
        Mon, 19 May 2014 18:36:03 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4JGa2FG009960;
        Mon, 19 May 2014 18:36:02 +0200
Date:   Mon, 19 May 2014 18:36:02 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: lib: csum_partial: more instruction paral
Message-ID: <20140519163602.GZ17197@linux-mips.org>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
 <537478D7.2000403@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537478D7.2000403@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40140
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

On Thu, May 15, 2014 at 09:20:39AM +0100, Markos Chandras wrote:

> On 05/15/2014 08:09 AM, chenj wrote:
> > This will bring at most 50% performance gain on loongson3a.
> > See
> > http://dev.lemote.com/files/upload/software/csum-opti/csum-opti-benchmark.html
> > 
> > The benchmark is done in userspace through
> > http://dev.lemote.com/files/upload/software/csum-opti/csum-test.tar.gz
> > ---
> >  arch/mips/lib/csum_partial.S | 38 +++++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> Hi chenj,
> 
> My opinion is that the commit message is not ideal. If the http links
> ever go away, the commit message will be mostly useless for someone
> trying to understand the reason for this patch. I would suggest to
> explain the reason for the optimizations in the commit message and put
> the http links as a comment to this patch which will still be visible in
> the mailing list archives. Or you can keep them in the commit message
> but I think the reason for the patch should be explained as well.

I can certainly offer a FTP space for such things.  Or alternatively,
post the archive's content as a shar archive (GNU sharutils) which will
end up in the mailing list archives itself and which provides the best
guarantee for a stable URL.

That said, tinkering with the checksum code shouldn't be done lightly.
The results on some CPUs are quite surprising and the current
impleemntation which is working well on R4000 or Sibyte class cores
has worked reasonably well for most more modern cores and some of the
attempted tweaks have benefited a few but hurt many cores.

But time progresses and we optimize the kernel for modern hardware so
I'm open to reevaluate things, including runtime generation.

  Ralf
