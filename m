Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2018 11:02:12 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994562AbeERJCFShfLK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 May 2018 11:02:05 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A21320834;
        Fri, 18 May 2018 09:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526634118;
        bh=1SRWfoD/psW265W0vT6SkEYVwFaJZV//o8sPscC1Ots=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yG3qvLwRGv7O+CGbyHALAoDhrv5hXvUquGE09lGU2oBdq7COnfz28qPQxLWrVQ8LY
         7g602wZdp5Z08Kb70DWy7zYY4LLYiFL+qCl6pJGo25Hgf2g0+xQRzXMmzkbqG28ksx
         4ZQvckvd4d6AA4/uXwbmgAeh2c99asU7GZdxE3J8=
Date:   Fri, 18 May 2018 11:01:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        peterz@infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        linux-snps-arc@lists.infradead.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Stafford Horne <shorne@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Kuo <rkuo@codeaurora.org>, linux-alpha@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH 4.9 27/33] futex: Remove duplicated code and fix
 undefined behaviour
Message-ID: <20180518090141.GA10227@kroah.com>
References: <20180518081535.096308218@linuxfoundation.org>
 <20180518081536.166573281@linuxfoundation.org>
 <e8dc5f94-3b52-dcf0-3b5e-b442bde7d803@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8dc5f94-3b52-dcf0-3b5e-b442bde7d803@suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Fri, May 18, 2018 at 10:30:24AM +0200, Jiri Slaby wrote:
> On 05/18/2018, 10:16 AM, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Jiri Slaby <jslaby@suse.cz>
> > 
> > commit 30d6e0a4190d37740e9447e4e4815f06992dd8c3 upstream.
> ...
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -1458,6 +1458,45 @@ out:
> >  	return ret;
> >  }
> >  
> > +static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> > +{
> > +	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
> > +	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
> > +	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
> > +	int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);
> 
> 12 is wrong here – wherever you apply this, you need also a follow-up fix:
> commit d70ef22892ed6c066e51e118b225923c9b74af34
> Author: Jiri Slaby <jslaby@suse.cz>
> Date:   Thu Nov 30 15:35:44 2017 +0100
> 
>     futex: futex_wake_op, fix sign_extend32 sign bits

Thanks for letting me know, I've now queued it up to the needed trees.

greg k-h
