Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2014 21:33:58 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:55384 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012394AbaJaUdzmuIC9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2014 21:33:55 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XkItF-0000J4-V4; Fri, 31 Oct 2014 21:33:46 +0100
Date:   Fri, 31 Oct 2014 21:33:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     "Ren, Qiaowei" <qiaowei.ren@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v9 09/12] x86, mpx: decode MPX instruction to get bound
 violation information
In-Reply-To: <5453EE0E.8060200@intel.com>
Message-ID: <alpine.DEB.2.11.1410312133120.5308@nanos>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-10-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241408360.5308@nanos> <9E0BE1322F2F2246BD820DA9FC397ADE0180ED16@shsmsx102.ccr.corp.intel.com>
 <alpine.DEB.2.11.1410272135420.5308@nanos> <5453EE0E.8060200@intel.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Fri, 31 Oct 2014, Dave Hansen wrote:

> On 10/27/2014 01:36 PM, Thomas Gleixner wrote:
> > You're repeating yourself. Care to read the discussion about this from
> > the last round of review again?
> 
> OK, so here's a rewritten decoder.  I think it's a lot more robust and
> probably fixes a bug or two.  This ends up saving ~70 lines of code out
> of ~300 or so for the old patch.
> 
> I'll include this in the next series, but I'm posting it early and often
> to make sure I'm on the right track.

Had a short glance. This looks really very well done!

Thanks,

	tglx
