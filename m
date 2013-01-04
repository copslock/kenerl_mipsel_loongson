Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 20:29:47 +0100 (CET)
Received: from wolverine02.qualcomm.com ([199.106.114.251]:35537 "EHLO
        wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820513Ab3ADT3nXyAnV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 20:29:43 +0100
X-IronPort-AV: E=Sophos;i="4.84,412,1355126400"; 
   d="scan'208";a="17972381"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Jan 2013 11:29:35 -0800
Received: from quicinc.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
        by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 4D60D10004BE;
        Fri,  4 Jan 2013 11:29:35 -0800 (PST)
Date:   Fri, 4 Jan 2013 11:29:34 -0800
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Russell King <linux@arm.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Mike Frysinger <vapier@gentoo.org>,
        uclinux-dist-devel@blackfin.uclinux.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, mhocko@suse.cz,
        srivatsa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line
 of /proc/stat" (commit 7386cdbf2f57ea8cff3c9fde93f206e58b9fe13f).
Message-ID: <20130104192934.GB29866@quicinc.com>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
References: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
 <50E6C776.7060707@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <50E6C776.7060707@mvista.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 35373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vatsa@codeaurora.org
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

* Sergei Shtylyov <sshtylyov@mvista.com> [2013-01-04 16:13:42]:

> >With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
> >don't need the check for cpu_online() introduced in commit 7386cdbf. Offline
> 
>    Please also specify the summary of that commit in parens (or
> however you like).

I had that in Subject line, but yes would be good to include in commit message
as well. I will incorporate that change alongwith anything else required in
next version of this patch.

- vatsa
