Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 14:49:32 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56560 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012034AbbAUNta3vrPf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Jan 2015 14:49:30 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id t0LDnSt6003708;
        Wed, 21 Jan 2015 14:49:28 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id t0LDnRlT003707;
        Wed, 21 Jan 2015 14:49:27 +0100
Date:   Wed, 21 Jan 2015 14:49:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
Message-ID: <20150121134927.GJ1205@linux-mips.org>
References: <54BCC827.3020806@gentoo.org>
 <54BEDF3C.6040105@gmail.com>
 <54BF12B9.8000507@gentoo.org>
 <54BF14D2.70006@gentoo.org>
 <54BF7DE6.6050704@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54BF7DE6.6050704@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45409
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

On Wed, Jan 21, 2015 at 10:22:30AM +0000, Markos Chandras wrote:

> >>> What would use this?  Or in other words, why is this needed?
> >>
> >> It was a patch I started including years ago in Gentoo's mips-sources, and just
> >> never thought much about.  I know it was submitted several times in the past,
> >> but I can't recall what, if any objection was ever made.  No harm in sending it
> >> in again...
> > 
> > Clarification, submitted several times in the past by others.  I think I sent
> > it in once prior, but never got review or feedback.
> > 
> I believe this patch is mostly useful for cores that can boot in both LE
> and BE so being able to tell the byteorder from cpuinfo can be helpful
> at times. Having readelf and other tools in your userland may not always
> be the case, but you surely have "cat" :)
> 
> So that patch looks good to me but i think the #ifdefs can be avoided.
> Can we use
> 
> if (config_enabled(CONFIG_CPU_BIG_ENDIAN) {
> } else {
> }
> 
> stuff instead?

Exactly the code Joshua is submitting is what has been there until commit
874124ebb630 (Merge with Linux 2.4.15.) in 2001.  One reason to remove it
was that I had a prototype of a kernel supporting the execution of
application of native and the other byte order working and the field in
/proc/cpuinfo was plain lying in that case.  Not a terribly relevant
reason in retrospective but I'm wondering if just in case we should
rename the field to kernel_byteorder?

  Ralf
