Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2013 18:39:30 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:45986 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827576Ab3BVRj3D0LW0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Feb 2013 18:39:29 +0100
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
        by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id r1MHcEIr014128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 22 Feb 2013 17:38:15 GMT
Received: from acsmt356.oracle.com (acsmt356.oracle.com [141.146.40.156])
        by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id r1MHcCoQ001862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 22 Feb 2013 17:38:12 GMT
Received: from abhmt109.oracle.com (abhmt109.oracle.com [141.146.116.61])
        by acsmt356.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id r1MHcAQ8005390;
        Fri, 22 Feb 2013 11:38:10 -0600
Received: from phenom.dumpdata.com (/50.195.21.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Feb 2013 09:38:10 -0800
Received: by phenom.dumpdata.com (Postfix, from userid 1000)
        id B5AA41C3935; Fri, 22 Feb 2013 12:38:05 -0500 (EST)
Date:   Fri, 22 Feb 2013 12:38:05 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "H. Peter Anvin" <hpa@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, stable@vger.kernel.org,
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
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Zachary Amsden <zamsden@gmail.com>, avi@redhat.com,
        linux-mips@linux-mips.org, linux-pm@vger.kernel.org,
        mst@redhat.com, sparclinux@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xensource.com
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Message-ID: <20130222173805.GC7768@phenom.dumpdata.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
 <20130222165531.GA29308@phenom.dumpdata.com>
 <5127A719.3060702@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5127A719.3060702@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: ucsinet21.oracle.com [156.151.31.93]
X-archive-position: 35813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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

On Fri, Feb 22, 2013 at 09:12:57AM -0800, H. Peter Anvin wrote:
> On 02/22/2013 08:55 AM, Konrad Rzeszutek Wilk wrote:
> >
> >What is bizzare is that I do recall testing this (and Stefano also did it).
> >So I am not sure what has altered.
> >
> 
> Yes, there was a very specific reason why I wanted you guys to test it...

Exactly. And I re-ran the same test, but with a new kernel. This is what
git reflog tells me:

473cd24 HEAD@{75}: checkout: moving from 08f321ed97353cf3b3fafa6b1c1971d6a8970830 to linux-next
08f321e HEAD@{76}: checkout: moving from linux-next to yinghai/for-x86-mm
eb827a7 HEAD@{77}: checkout: moving from 1b66ccf15ff4bd0200567e8d70446a8763f96ee7 to linux-next
[konrad@build linux]$ git show 08f321e
commit 08f321ed97353cf3b3fafa6b1c1971d6a8970830
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Thu Nov 8 00:00:19 2012 -0800

    mm: Kill NO_BOOTMEM version free_all_bootmem_node()

And I recall Stefano later on testing (I was in a conference and did not have
the opportunity to test it). Not sure what he ran with.
