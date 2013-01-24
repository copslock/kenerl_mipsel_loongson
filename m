Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 14:22:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47530 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6833444Ab3AXNWJ3NlRg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jan 2013 14:22:09 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0ODM8KQ029213;
        Thu, 24 Jan 2013 14:22:08 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0ODM6qg029212;
        Thu, 24 Jan 2013 14:22:06 +0100
Date:   Thu, 24 Jan 2013 14:22:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Gleb Natapov <gleb@redhat.com>
Cc:     Sanjay Lal <sanjayl@kymasys.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 02/18] KVM/MIPS32: Arch specific KVM data structures.
Message-ID: <20130124132206.GB28065@linux-mips.org>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
 <1353551656-23579-3-git-send-email-sanjayl@kymasys.com>
 <20121226131445.GH17584@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121226131445.GH17584@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35539
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

On Wed, Dec 26, 2012 at 03:14:45PM +0200, Gleb Natapov wrote:

> On Wed, Nov 21, 2012 at 06:34:00PM -0800, Sanjay Lal wrote:
> > +
> > +#ifndef __unused
> > +#define __unused __attribute__((unused))
> > +#endif
> > +
> There are __maybe_unused and __always_unused, no need to define your
> own.

Also the symbol __unused is a member of struct compat_flock in
<asm/compat.h> which is going to bite on 64 bit.

  Ralf
