Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Dec 2013 05:59:22 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58376 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816022Ab3LPE7RY3IhB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Dec 2013 05:59:17 +0100
Received: by mail-pa0-f52.google.com with SMTP id ld10so2455045pab.11
        for <multiple recipients>; Sun, 15 Dec 2013 20:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nfz6J5u37pGmWidZHZ4/p+aN+HOQYnA35hSo2JiOFEo=;
        b=mPbjwf1GKHr0kv0GWOL8w10oXhW45xUXP/tQ/jzVaJ4E1MkYksgsg0BA7YY4QOxvoJ
         fj+GTJeHLwtA28w93g3WL4fyn8L8jZDnzfzuZY/Xg/JljvZYMndnZyoJRbQJ04VVbYZs
         tLLXLViRFM0eVzvoTAV59G/wrNo0+yJVNdbs9S4rRoqkcrR9Vw9x7Hyj5gr/I8erwn8L
         ybKOJoxvCrdrF1pucgdRsS1udFqfRI9xclYr8gw8Lh323njF62BEbZIMJ7X4rlxyj6Ix
         NQ5gd4daXt1ieOUZyT9MargKzGdiWr44jIClcHvL+hUaB50m5YNQvz//xbKMRl6wRkuy
         EgOQ==
X-Received: by 10.68.236.133 with SMTP id uu5mr17764960pbc.153.1387169950384;
        Sun, 15 Dec 2013 20:59:10 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-67-188-112-76.hsd1.ca.comcast.net. [67.188.112.76])
        by mx.google.com with ESMTPSA id xn12sm31613141pac.12.2013.12.15.20.59.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 20:59:09 -0800 (PST)
Date:   Sun, 15 Dec 2013 20:59:00 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     msalter@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        rth@twiddle.net, linux-alpha@vger.kernel.org,
        linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
        tony.luck@intel.com, fenghua.yu@intel.com,
        linux-ia64@vger.kernel.org, ralf@linux-mips.org,
        linux-mips@linux-mips.org, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        lethal@linux-sh.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, gxt@mprc.pku.edu.cn, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
Message-ID: <20131216045859.GA4322@core.coreip.homeip.net>
References: <52ACA43F.2040402@zytor.com>
 <20131215103657.GB20197@core.coreip.homeip.net>
 <1387122626.1979.136.camel@deneb.redhat.com>
 <20131215.202725.1549146673897801643.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131215.202725.1549146673897801643.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Sun, Dec 15, 2013 at 08:27:25PM -0500, David Miller wrote:
> From: Mark Salter <msalter@redhat.com>
> Date: Sun, 15 Dec 2013 10:50:26 -0500
> 
> > On Sun, 2013-12-15 at 02:36 -0800, Dmitry Torokhov wrote:
> >> How are we going to merge this? In bulk through input tree or peacemeal
> >> through all arches first?
> >
> > They should all go together to eliminate the chance of bisect breakage.
> > Either the input tree or maybe akpm tree.
> 
> This sounds good to me.

OK, then I'll pick it up once I collect more acks from the arch
maintainers.

-- 
Dmitry
