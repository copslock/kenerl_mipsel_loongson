Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2013 19:23:08 +0100 (CET)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63870 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827599Ab3BVSXF3XtDa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Feb 2013 19:23:05 +0100
Received: by mail-ie0-f177.google.com with SMTP id 16so1071265iea.22
        for <multiple recipients>; Fri, 22 Feb 2013 10:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=eawHSTBHCwjL2bRkJUFYFi1yDzmmlhlZR4+sK0dg5So=;
        b=GlP0/wJrAcIExv+bUMErz+l/wB39q9/qwScD0qOtLtJ7+l37Y2jM1eeMcyfdxPygnA
         /HBRB2eKwVJXggk5wPs4wugdvciOfBAbf75fZuMDTurbFDfZSjbQPzW4i27yGUqqAYDB
         yTQONC5plr4vYPhVf+qLfNasfcijDYp7kjGyD1+eitwxU44t523zjfVzNTHuTX7DM2ye
         B/fMPSBAnoYhnj0ImcC0YUr0aKl/vNNuslANNiD1SLKizl3T7a1RZ/V2vRhGHZykbZ+X
         oRmjF4xyCzU1Tk9oqVfzK4NnlvFAnhGDyvMLW8+BJnGOA9/53IrHAK/MySSNnQm5Sim+
         6KYA==
MIME-Version: 1.0
X-Received: by 10.50.186.165 with SMTP id fl5mr46888igc.81.1361557379147; Fri,
 22 Feb 2013 10:22:59 -0800 (PST)
Received: by 10.64.33.203 with HTTP; Fri, 22 Feb 2013 10:22:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1302221804340.22997@kaball.uk.xensource.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
        <20130222165531.GA29308@phenom.dumpdata.com>
        <5127A719.3060702@zytor.com>
        <20130222173805.GC7768@phenom.dumpdata.com>
        <alpine.DEB.2.02.1302221804340.22997@kaball.uk.xensource.com>
Date:   Fri, 22 Feb 2013 10:22:59 -0800
X-Google-Sender-Auth: OfM_9rT84W15D603mqOA0AtPjYI
Message-ID: <CAE9FiQV8U-7rZZU4Uj_3MVRZiFeq3uEW0ErmCuy1m8AE55gxfw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
From:   Yinghai Lu <yinghai@kernel.org>
To:     Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
        Zachary Amsden <zamsden@gmail.com>,
        "avi@redhat.com" <avi@redhat.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yinghai@kernel.org
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

On Fri, Feb 22, 2013 at 10:06 AM, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> On Fri, 22 Feb 2013, Konrad Rzeszutek Wilk wrote:
>> On Fri, Feb 22, 2013 at 09:12:57AM -0800, H. Peter Anvin wrote:
>> > On 02/22/2013 08:55 AM, Konrad Rzeszutek Wilk wrote:
>> > >
>> > >What is bizzare is that I do recall testing this (and Stefano also did it).
>> > >So I am not sure what has altered.
>> > >
>> >
>> > Yes, there was a very specific reason why I wanted you guys to test it...
>>
>> Exactly. And I re-ran the same test, but with a new kernel. This is what
>> git reflog tells me:
>>
>> 473cd24 HEAD@{75}: checkout: moving from 08f321ed97353cf3b3fafa6b1c1971d6a8970830 to linux-next
>> 08f321e HEAD@{76}: checkout: moving from linux-next to yinghai/for-x86-mm
>> eb827a7 HEAD@{77}: checkout: moving from 1b66ccf15ff4bd0200567e8d70446a8763f96ee7 to linux-next
>> [konrad@build linux]$ git show 08f321e
>> commit 08f321ed97353cf3b3fafa6b1c1971d6a8970830
>> Author: Yinghai Lu <yinghai@kernel.org>
>> Date:   Thu Nov 8 00:00:19 2012 -0800
>>
>>     mm: Kill NO_BOOTMEM version free_all_bootmem_node()
>>
>> And I recall Stefano later on testing (I was in a conference and did not have
>> the opportunity to test it). Not sure what he ran with.
>>
>
> FYI the last patch series I tested was Yinghai's "x86, boot, 64bit: Add
> support for loading ramdisk and bzImage above 4G" v7u1.


the one in tip and linus's tree is
---
-v7u2: update changelog and comments, and clear more fields for sentinel.
     Update swiotlb autoswitch off patch.
     Fix crash with xen PV guest with 2G.
---

and it fixes xen crash that you reported with v7u1, and you tested
that add-on patch
fix_xen_2g.patch with v7u1.
and I fold the addon patch into offending patch in v7u2.


Thanks

Yinghai
