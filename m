Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Dec 2013 19:33:17 +0100 (CET)
Received: from terminus.zytor.com ([198.137.202.10]:49578 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822679Ab3LNSdOhMdSO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 Dec 2013 19:33:14 +0100
Received: from tazenda.hos.anvin.org (c-71-202-112-181.hsd1.ca.comcast.net [71.202.112.181])
        (authenticated bits=0)
        by mail.zytor.com (8.14.7/8.14.5) with ESMTP id rBEIWajb024393
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Sat, 14 Dec 2013 10:32:37 -0800
Message-ID: <52ACA43F.2040402@zytor.com>
Date:   Sat, 14 Dec 2013 10:32:31 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To:     Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
References: <1387040376-26906-1-git-send-email-msalter@redhat.com> <1387040376-26906-11-git-send-email-msalter@redhat.com>
In-Reply-To: <1387040376-26906-11-git-send-email-msalter@redhat.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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

On 12/14/2013 08:59 AM, Mark Salter wrote:
> Remove messy dependencies from SERIO_I8042 by having it depend on one
> Kconfig symbol (ARCH_MIGHT_HAVE_PC_SERIO) and having architectures
> which need it select ARCH_MIGHT_HAVE_PC_SERIO in arch/*/Kconfig.
> New architectures are unlikely to need SERIO_I8042, so this avoids
> having an ever growing list of architectures to exclude.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: linux-alpha@vger.kernel.org
> CC: Russell King <linux@arm.linux.org.uk>
> CC: linux-arm-kernel@lists.infradead.org
> CC: Tony Luck <tony.luck@intel.com>
> CC: Fenghua Yu <fenghua.yu@intel.com>
> CC: linux-ia64@vger.kernel.org
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: linux-mips@linux-mips.org
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: Paul Mundt <lethal@linux-sh.org>
> CC: linux-sh@vger.kernel.org
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: x86@kernel.org

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
