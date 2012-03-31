Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Mar 2012 22:25:16 +0200 (CEST)
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:50663 "HELO
        oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1903631Ab2CaUZM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Mar 2012 22:25:12 +0200
Received: (qmail 18934 invoked by uid 0); 31 Mar 2012 20:25:08 -0000
Received: from unknown (HELO box742.bluehost.com) (66.147.244.242)
  by cpoproxy1.bluehost.com with SMTP; 31 Mar 2012 20:25:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xenotime.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=fQvDRtvb5qaSxJ8hdf1WmrM7Zo8pFWHi8X8HBanaV90=;
        b=cWCyQa3IefoXxnWRM7oiyGCzVjO6FPXWkYfk8EAlU6JDuHjFGH0wUi5XqonAc5l1etCHYoNVCGm8bmb3LBrfry3U5G5P2GvFU4fcw9YtF0v+HnH9jBW0hYv76n/kNORr;
Received: from static-50-53-38-135.bvtn.or.frontiernet.net ([50.53.38.135] helo=[192.168.1.4])
        by box742.bluehost.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <rdunlap@xenotime.net>)
        id 1SE4rE-0002tP-Gz; Sat, 31 Mar 2012 14:25:08 -0600
Message-ID: <4F77681E.5010608@xenotime.net>
Date:   Sat, 31 Mar 2012 13:25:02 -0700
From:   Randy Dunlap <rdunlap@xenotime.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110323 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Linas Vepstas <linasvepstas@gmail.com>
CC:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tglx@linutronix.de,
        linux@arm.linux.org.uk, dhowells@redhat.com, jejb@parisc-linux.org,
        linux390@de.ibm.com, x86@kernel.org, cmetcalf@tilera.com
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
References: <20120331163321.GA15809@linux.vnet.ibm.com> <20120331201500.GA27640@linas.org>
In-Reply-To: <20120331201500.GA27640@linas.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Identified-User: {1807:box742.bluehost.com:xenotime:xenotime.net} {sentby:smtp auth 50.53.38.135 authed with rdunlap@xenotime.net}
X-archive-position: 32842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@xenotime.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/31/2012 01:15 PM, Linas Vepstas wrote:

> 
> Hi,
> 
> I didn't actually try to compile the patch below; it didn't look like
> C code so I wasn't sure what compiler to run it through.  I guess maybe
> its python?  However, I'm very sure that the patches are completely
> correct, because I read them, and I also know Paul.  And I've heard of
> Thomas Gleixner.


x86_64 defconfig has many build errors and warnings.  :(

back to my abacus.

-- 
~Randy
