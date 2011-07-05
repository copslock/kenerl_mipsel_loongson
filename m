Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2011 00:36:28 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:52568 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492018Ab1GEWgT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jul 2011 00:36:19 +0200
Received: from hanvin-mobl4.sc.intel.com (hpa@localhost [127.0.0.1])
        (authenticated bits=0)
        by mail.zytor.com (8.14.4/8.14.4) with ESMTP id p65MZkqp029009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Tue, 5 Jul 2011 15:35:47 -0700
Message-ID: <4E1391C2.2090904@zytor.com>
Date:   Tue, 05 Jul 2011 15:35:46 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Ohad Ben-Cohen <ohad@wizery.com>
CC:     Rusty Russell <rusty@rustcorp.com.au>,
        virtualization@lists.linux-foundation.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Xiantao Zhang <xiantao.zhang@intel.com>,
        Avi Kivity <avi@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexander Graf <agraf@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Carsten Otte <cotte@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mundt <lethal@linux-sh.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        John Stultz <john.stultz@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kvm-ia64@vger.kernel.org, kvm@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [RFC] virtio: expose for non-virtualization users too
References: <1309874774-31689-1-git-send-email-ohad@wizery.com>
In-Reply-To: <1309874774-31689-1-git-send-email-ohad@wizery.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 30582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3582

On 07/05/2011 07:06 AM, Ohad Ben-Cohen wrote:
> virtio has been so far used only in the context of virtualization,
> and the virtio Kconfig was sourced directly by the relevant arch
> Kconfigs when VIRTUALIZATION was selected.
> 
> Now that we start using virtio for inter-processor communications,
> we need to source the virtio Kconfig outside of the virtualization
> scope too.
> 

Seems reasonable to me.

	-hpa
