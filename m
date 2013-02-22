Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2013 19:06:27 +0100 (CET)
Received: from smtp02.citrix.com ([66.165.176.63]:26808 "EHLO
        SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827576Ab3BVSGRnJ7vf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Feb 2013 19:06:17 +0100
X-IronPort-AV: E=Sophos;i="4.84,717,1355097600"; 
   d="scan'208";a="8631647"
Received: from accessns.citrite.net (HELO FTLPEX01CL02.citrite.net) ([10.9.154.239])
  by FTLPIPO02.CITRIX.COM with ESMTP/TLS/AES128-SHA; 22 Feb 2013 18:06:10 +0000
Received: from ukmail1.uk.xensource.com (10.80.16.128) by smtprelay.citrix.com
 (10.13.107.79) with Microsoft SMTP Server id 14.2.318.1; Fri, 22 Feb 2013
 13:06:09 -0500
Received: from kaball.uk.xensource.com ([10.80.2.59])   by
 ukmail1.uk.xensource.com with esmtp (Exim 4.69)        (envelope-from
 <stefano.stabellini@eu.citrix.com>)    id 1U8x0b-0006RG-4R; Fri, 22 Feb 2013
 18:06:09 +0000
Date:   Fri, 22 Feb 2013 18:06:04 +0000
From:   Stefano Stabellini <stefano.stabellini@eu.citrix.com>
X-X-Sender: sstabellini@kaball.uk.xensource.com
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Borislav Petkov <bp@suse.de>, Christoph Lameter <cl@linux.com>,
        Daniel J Blueman <daniel@numascale-asia.com>,
        Dave Hansen <dave@linux.vnet.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Gleb Natapov <gleb@redhat.com>,
        Gokul Caushik <caushik1@gmail.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>,
        Jacob Shin <jacob.shin@amd.com>,
        Jamie Lokier <jamie@shareable.org>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Jeremy Fitzhardinge <jeremy@goop.org>,
        Joe Millenbach <jmillenbach@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Lee Schermerhorn <Lee.Schermerhorn@hp.com>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matt Fleming <matt.fleming@intel.com>,
        Mel Gorman <mgorman@suse.de>, Paul Turner <pjt@google.com>,
        Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rik van Riel <riel@redhat.com>,
        Rob Landley <rob@landley.net>,
        Russell King <linux@arm.linux.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Shuah Khan <shuah.khan@hp.com>,
        Shuah Khan <shuahkhan@gmail.com>,
        Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Zachary Amsden <zamsden@gmail.com>,
        "avi@redhat.com" <avi@redhat.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
In-Reply-To: <20130222173805.GC7768@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1302221804340.22997@kaball.uk.xensource.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com> <20130222165531.GA29308@phenom.dumpdata.com> <5127A719.3060702@zytor.com> <20130222173805.GC7768@phenom.dumpdata.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-archive-position: 35816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefano.stabellini@eu.citrix.com
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

On Fri, 22 Feb 2013, Konrad Rzeszutek Wilk wrote:
> On Fri, Feb 22, 2013 at 09:12:57AM -0800, H. Peter Anvin wrote:
> > On 02/22/2013 08:55 AM, Konrad Rzeszutek Wilk wrote:
> > >
> > >What is bizzare is that I do recall testing this (and Stefano also did it).
> > >So I am not sure what has altered.
> > >
> > 
> > Yes, there was a very specific reason why I wanted you guys to test it...
> 
> Exactly. And I re-ran the same test, but with a new kernel. This is what
> git reflog tells me:
> 
> 473cd24 HEAD@{75}: checkout: moving from 08f321ed97353cf3b3fafa6b1c1971d6a8970830 to linux-next
> 08f321e HEAD@{76}: checkout: moving from linux-next to yinghai/for-x86-mm
> eb827a7 HEAD@{77}: checkout: moving from 1b66ccf15ff4bd0200567e8d70446a8763f96ee7 to linux-next
> [konrad@build linux]$ git show 08f321e
> commit 08f321ed97353cf3b3fafa6b1c1971d6a8970830
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Thu Nov 8 00:00:19 2012 -0800
> 
>     mm: Kill NO_BOOTMEM version free_all_bootmem_node()
> 
> And I recall Stefano later on testing (I was in a conference and did not have
> the opportunity to test it). Not sure what he ran with.
> 

FYI the last patch series I tested was Yinghai's "x86, boot, 64bit: Add
support for loading ramdisk and bzImage above 4G" v7u1.
