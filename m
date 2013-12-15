Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Dec 2013 16:50:59 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:43929 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817033Ab3LOPu5YA3u1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 Dec 2013 16:50:57 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rBFFoVIG019506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 15 Dec 2013 10:50:31 -0500
Received: from [10.3.113.72] (ovpn-113-72.phx2.redhat.com [10.3.113.72])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id rBFFoQQ3004319;
        Sun, 15 Dec 2013 10:50:27 -0500
Message-ID: <1387122626.1979.136.camel@deneb.redhat.com>
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
From:   Mark Salter <msalter@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Date:   Sun, 15 Dec 2013 10:50:26 -0500
In-Reply-To: <20131215103657.GB20197@core.coreip.homeip.net>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
         <1387040376-26906-11-git-send-email-msalter@redhat.com>
         <52ACA43F.2040402@zytor.com>
         <20131215103657.GB20197@core.coreip.homeip.net>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <msalter@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msalter@redhat.com
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

On Sun, 2013-12-15 at 02:36 -0800, Dmitry Torokhov wrote:
> On Sat, Dec 14, 2013 at 10:32:31AM -0800, H. Peter Anvin wrote:
> > On 12/14/2013 08:59 AM, Mark Salter wrote:
> > > Remove messy dependencies from SERIO_I8042 by having it depend on one
> > > Kconfig symbol (ARCH_MIGHT_HAVE_PC_SERIO) and having architectures
> > > which need it select ARCH_MIGHT_HAVE_PC_SERIO in arch/*/Kconfig.
> > > New architectures are unlikely to need SERIO_I8042, so this avoids
> > > having an ever growing list of architectures to exclude.

> How are we going to merge this? In bulk through input tree or peacemeal
> through all arches first?
> 

They should all go together to eliminate the chance of bisect breakage.
Either the input tree or maybe akpm tree.
