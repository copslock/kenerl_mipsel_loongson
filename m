Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 13:13:54 +0100 (CET)
Received: from mail-la0-f53.google.com ([209.85.215.53]:61365 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab3ADMNwmzPkl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 13:13:52 +0100
Received: by mail-la0-f53.google.com with SMTP id fn20so9660077lab.12
        for <linux-mips@linux-mips.org>; Fri, 04 Jan 2013 04:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=dt4zimQaJ0mzs/+SodCArpnmuFEx4aIMTG3htFMAUjs=;
        b=Sx2ZzeTenhRmd3l5VFI0GdgPrHnwitP//8bB4G9PrFemd350DlDYEWTEUJorikLCf9
         69xlksC//LYXx71+yT+EVKpQ/NSuNLkVvTrGNcU9KNgkPxeoxdDaThFwzkEXp10NcICN
         JOR7e4TMYbp6718AXZ+iGW9jxWz1dKWKm7vUGOxJHGcZfRH2Ziqc+Yc6aznPeMWXvL/y
         N1Xi52O5rfRr+1Kl4l/t6IkIUDHF7fx2luw6ZvDSTpRfN/tV7xCr0WpD/V+BmgXhTU9l
         +wwji8KW9qr4l9aJ+rvkLugqBtYi8O9bKXD0Zhc6B6vvc61B56z0eeY+ulRlLX3QOv3z
         VngQ==
X-Received: by 10.112.54.6 with SMTP id f6mr21393757lbp.71.1357301626691;
        Fri, 04 Jan 2013 04:13:46 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-95-142.pppoe.mtu-net.ru. [91.79.95.142])
        by mx.google.com with ESMTPS id fh4sm17879228lbb.7.2013.01.04.04.13.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Jan 2013 04:13:45 -0800 (PST)
Message-ID: <50E6C776.7060707@mvista.com>
Date:   Fri, 04 Jan 2013 16:13:42 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
CC:     Russell King <linux@arm.linux.org.uk>,
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
References: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
In-Reply-To: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmcrg/lCFAZMvVWKZQbTpjDWNSEy7sIQrF/oW15y39S3UB7BWe74wNEkjheYyuA8/UUAJEo
X-archive-position: 35366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 04-01-2013 6:58, Srivatsa Vaddagiri wrote:

> With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
> don't need the check for cpu_online() introduced in commit 7386cdbf. Offline

    Please also specify the summary of that commit in parens (or however you 
like).

> cpu's idle time as last recorded in its ts->idle_sleeptime will be reported
> (thus excluding its offline time as part of idle time statistics).

> Cc: mhocko@suse.cz
> Cc: srivatsa.bhat@linux.vnet.ibm.com
> Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>

WBR, Sergei
